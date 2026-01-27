<?php

namespace App\Tasks;

use App\Models\Attendance;
use App\Models\Employee;
use App\Models\Globals;
use App\Models\EmployeeLeaveAllocation;
use App\Models\Request as EmployeeRequest;
use App\Services\AttendanceServices;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class DailyAttendanceHandle
{
    public function __invoke(?string $forceDate = null): void
    {
        Log::info('DailyAttendanceHandle task started.');

        // If a specific date is forced (manual run), only run that date.
        // Otherwise, look back 3 days to catch any missed runs (Self-Healing).
        $daysToCheck = $forceDate ? 1 : 3;
        $baseDate = $forceDate ? CarbonImmutable::parse($forceDate) : CarbonImmutable::now();

        // Loop backwards (Oldest day first)
        // If today is Friday: Checks Tuesday, then Wednesday, then Thursday.
        for ($i = $daysToCheck; $i >= 1; $i--) {

            $targetDate = $forceDate ? $baseDate : $baseDate->subDays($i);
            $dateString = $targetDate->toDateString();

            // GAP CHECK:
            // If we are NOT forcing a date, check if this date was already processed.
            // We assume if at least one "is_manually_filled" record exists, the script ran successfully.
            if (!$forceDate) {
                $alreadyProcessed = Attendance::where('date', $dateString)
                    ->where('is_manually_filled', true)
                    ->exists();

                if ($alreadyProcessed) {
                    continue; // Skip this day, it's already done.
                }

                Log::warning("Gap detected for $dateString. Attempting to backfill attendance.");
            }

            $this->processDate($targetDate);
        }

        Log::info('DailyAttendanceHandle task completed.');
    }

    /**
     * The Logic to Process a Single Date
     */
    private function processDate(CarbonImmutable $carbon): void
    {
        $date = $carbon->toDateString();
        $year = $carbon->year;

        // 1. Weekend/Holiday Check
        $globals = Globals::first();
        $weekendDays = is_string($globals?->weekend_off_days)
            ? json_decode($globals->weekend_off_days, true)
            : ($globals?->weekend_off_days ?? []);

        if (in_array(strtolower($carbon->dayName), array_map('strtolower', $weekendDays))) {
            Log::info("Skipping $date: Defined as a weekend/off-day.");
            return;
        }

        // 2. Mark "Forgot to Sign Out" (Incomplete)
        Attendance::where('date', $date)
            ->whereNotNull('sign_in_time')
            ->whereNull('sign_off_time')
            ->update([
                'status' => 'incomplete',
                'notes'  => DB::raw("CONCAT(COALESCE(notes, ''), ' | Auto-marked: Did not sign out')"),
                'is_manually_filled' => true // Important: Mark as processed
            ]);

        $attendanceService = new AttendanceServices();

        // 3. Process Employees
        // Chunking to handle large employee bases safely
        Employee::whereDate('hired_on', '<=', $date)
            ->with(['leaveAllocations' => function ($q) use ($year) {
                $q->where('year', $year);
            }])
            ->chunk(100, function ($employees) use ($date, $attendanceService, $year) {
                foreach ($employees as $employee) {
                    DB::transaction(function () use ($employee, $date, $attendanceService, $year) {
                        $this->processEmployee($employee, $date, $attendanceService, $year);
                    });
                }
            });
    }

    private function processEmployee($employee, $date, $attendanceService, $year): void
    {
        // A. Fetch Requests
        $request = EmployeeRequest::where('employee_id', $employee->id)
            ->where('status', 1)
            ->whereIn('type', ['Leave', 'Remote Work'])
            ->whereHas('leaveRequest', function ($query) use ($date) {
                $query->where(function ($q) use ($date) {
                    $q->whereNotNull('start_date')->whereDate('start_date', '<=', $date)->whereDate('end_date', '>=', $date);
                })->orWhere(function ($q) use ($date) {
                    $q->whereNotNull('half_leave_date')->whereDate('half_leave_date', $date);
                })->orWhere(function ($q) use ($date) {
                    $q->whereNotNull('remote_work_date')->whereDate('remote_work_date', $date);
                });
            })->with('leaveRequest')->first();

        // B. Fetch Attendance
        $attendance = Attendance::where('employee_id', $employee->id)->where('date', $date)->first();

        $status = $attendance?->status ?? 'missed';
        $notes  = $attendance?->notes  ?? 'Absent without approval';
        $workingMinutes = $attendance?->working_minutes ?? 0;
        $overtimeMinutes = $attendance?->overtime_minutes ?? 0;

        // C. Apply Logic
        if ($request) {
            if ($request->type === 'Remote Work') {
                $status = 'on_time';
                $notes  = 'Approved Remote Work';
            } elseif ($request->type === 'Leave') {
                $allocation = $employee->leaveAllocations->first();
                $duration = (float) ($request->leaveRequest->leave_duration ?? 1.0);

                if ($duration <= 0.5) {
                    // Half Day
                    if ($attendance && $attendance->sign_in_time) {
                        $status = 'partial_present';
                        $notes  = 'Worked half day + ' . ($request->leaveRequest->half_leave_segment ?? 'half leave');
                        $this->deductLeave($allocation, 0.5, $employee->id);

                        [$workingMinutes, $overtimeMinutes] = $attendanceService->calculateMinutes(
                            $employee,
                            $date,
                            $attendance->sign_in_time,
                            $attendance->sign_off_time,
                            'partial_present'
                        );
                    } else {
                        $status = 'unpaid_leave';
                        $notes  = 'Approved half-day leave, but missed working segment';
                        $allocation?->increment('unpaid_leaves', 0.5);
                        $workingMinutes = 0;
                    }
                } else {
                    // Full Day
                    if ($allocation && $allocation->remaining_leaves >= 1.0) {
                        $status = 'leave';
                        $notes  = 'Approved Paid Leave';
                        $this->deductLeave($allocation, 1.0, $employee->id);
                    } else {
                        $status = 'unpaid_leave';
                        $notes  = 'Approved Leave (Insufficient balance)';
                        $allocation?->increment('unpaid_leaves', 1.0);
                    }
                    $workingMinutes = 0;
                }
            }
        }

        // D. Save Record
        Attendance::updateOrCreate(
            ['employee_id' => $employee->id, 'date' => $date],
            [
                'status' => $status,
                'notes'  => $notes,
                'is_manually_filled' => true, // This Flag confirms the day was processed
                'working_minutes' => $workingMinutes,
                'overtime_minutes' => $overtimeMinutes
            ]
        );
    }

    private function deductLeave($allocation, float $amount, $employeeId): void
    {
        if (!$allocation) return;
        if ($allocation->remaining_leaves >= $amount) {
            $allocation->increment('used_leaves', $amount);
            $allocation->decrement('remaining_leaves', $amount);
        } else {
            $allocation->increment('unpaid_leaves', $amount);
        }
    }
}
