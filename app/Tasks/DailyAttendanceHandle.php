<?php

namespace App\Tasks;

use App\Models\Attendance;
use App\Models\Employee;
use App\Models\Globals;
use App\Models\EmployeeLeaveAllocation;
use App\Models\Request as EmployeeRequest;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class DailyAttendanceHandle
{
    public function __invoke(?string $forceDate = null): void
    {
        Log::info('DailyAttendanceHandle task started.');

        // 1. Maintenance Mode (Ensures data integrity during batch processing)
        Artisan::call('down --retry=1 --secret=' . config('app.maintenance_secret', 'HelloKittyImSoPretty') . ' --render="errors::503_daily"');

        try {
            // Determine the target date (usually yesterday)
            $carbon = $forceDate
                ? CarbonImmutable::parse($forceDate)
                : CarbonImmutable::now()->subDay();

            $date = $carbon->toDateString();
            $year = $carbon->year;

            // 2. Check Global Weekend Settings
            $globals = Globals::first();
            $weekendDays = is_string($globals?->weekend_off_days)
                ? json_decode($globals->weekend_off_days, true)
                : ($globals?->weekend_off_days ?? []);

            if (in_array(strtolower($carbon->dayName), array_map('strtolower', $weekendDays))) {
                Log::info("Skipping $date: Defined as a weekend/off-day.");
                return;
            }

            // 3. Cleanup: Mark "Forgot to Sign Out"
            Attendance::where('date', $date)
                ->whereNotNull('sign_in_time')
                ->whereNull('sign_off_time')
                ->update([
                    'status' => 'incomplete',
                    'notes'  => DB::raw("CONCAT(COALESCE(notes, ''), ' | Auto-marked: Did not sign out')"),
                ]);

            // 4. Process Every Employee
            $employees = Employee::whereDate('hired_on', '<=', $date)->get();

            foreach ($employees as $employee) {
                DB::transaction(function () use ($employee, $date, $year) {

                    // A. Check for any approved Request (Leave or Remote) covering today
                    $request = EmployeeRequest::where('employee_id', $employee->id)
                        ->where('status', 1) // Approved
                        ->whereIn('type', ['Leave', 'Remote Work'])
                        ->whereHas('leaveRequest', function ($query) use ($date) {
                            $query->where(function ($q) use ($date) {
                                // Multi-day Leave
                                $q->whereNotNull('start_date')
                                    ->whereDate('start_date', '<=', $date)
                                    ->whereDate('end_date', '>=', $date);
                            })
                                ->orWhere(function ($q) use ($date) {
                                    // Half-day Leave
                                    $q->whereNotNull('half_leave_date')
                                        ->whereDate('half_leave_date', $date);
                                })
                                ->orWhere(function ($q) use ($date) {
                                    // Remote Work Date
                                    $q->whereNotNull('remote_work_date')
                                        ->whereDate('remote_work_date', $date);
                                });
                        })
                        ->with('leaveRequest')
                        ->first();

                    // B. Get actual attendance record (if employee swiped/signed in)
                    $attendance = Attendance::where('employee_id', $employee->id)
                        ->where('date', $date)
                        ->first();

                    $status = $attendance?->status ?? 'missed';
                    $notes  = $attendance?->notes  ?? 'Absent without approval';

                    // C. Logic Branching based on Request Type
                    if ($request) {
                        if ($request->type === 'Remote Work') {
                            $status = 'on_time';
                            $notes  = 'Approved Remote Work';
                        } elseif ($request->type === 'Leave') {
                            $allocation = EmployeeLeaveAllocation::where('employee_id', $employee->id)
                                ->where('year', $year)
                                ->lockForUpdate()
                                ->first();

                            $duration = (float) ($request->leaveRequest->leave_duration ?? 1.0);

                            if ($duration <= 0.5) {
                                // HALF DAY CASE
                                if ($attendance && $attendance->sign_in_time) {
                                    $status = 'partial_present';
                                    $notes  = 'Worked half day + ' . ($request->leaveRequest->half_leave_segment ?? 'half leave');
                                    $this->deductLeave($allocation, 0.5, $employee->id);
                                } else {
                                    $status = 'unpaid_leave';
                                    $notes  = 'Approved half-day leave, but missed the working segment';
                                    $allocation?->increment('unpaid_leaves', 0.5);
                                }
                            } else {
                                // FULL DAY / MULTI-DAY CASE
                                if ($allocation && $allocation->remaining_leaves >= 1.0) {
                                    $status = 'leave';
                                    $notes  = 'Approved Paid Leave';
                                    $this->deductLeave($allocation, 1.0, $employee->id);
                                } else {
                                    $status = 'unpaid_leave';
                                    $notes  = 'Approved Leave (Insufficient balance)';
                                    $allocation?->increment('unpaid_leaves', 1.0);
                                }
                            }
                        }
                    }

                    // D. Final Sync to Database
                    Attendance::updateOrCreate(
                        ['employee_id' => $employee->id, 'date' => $date],
                        [
                            'status' => $status,
                            'notes'  => $notes,
                            'is_manually_filled' => true
                        ]
                    );
                });
            }
        } catch (\Exception $e) {
            Log::error('Attendance Task Error: ' . $e->getMessage());
        } finally {
            // Always bring the site back up
            Artisan::call('up');
            Log::info('DailyAttendanceHandle task completed.');
        }
    }

    /**
     * Helper to safely deduct leave balances
     */
    private function deductLeave($allocation, float $amount, $employeeId): void
    {
        if (!$allocation) {
            Log::warning("No leave allocation found for Employee ID: $employeeId");
            return;
        }

        if ($allocation->remaining_leaves >= $amount) {
            $allocation->increment('used_leaves', $amount);
            $allocation->decrement('remaining_leaves', $amount);
        } else {
            $allocation->increment('unpaid_leaves', $amount);
        }
    }
}
