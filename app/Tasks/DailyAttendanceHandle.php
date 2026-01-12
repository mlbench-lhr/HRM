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

class DailyAttendanceHandle
{
    public function __invoke(?string $forceDate = null): void
    {
        logger('DailyAttendanceHandle started');

        Artisan::call(
            'down --retry=1 --secret=HelloKittyImSoPretty --render="errors::503_daily"'
        );

        try {
            // $carbon = CarbonImmutable::now()->subDay();
            // $carbon = CarbonImmutable::parse('2026-01-02');
            // $date   = $carbon->toDateString();
            // $year   = $carbon->year;
            $carbon = $forceDate
                ? \Carbon\CarbonImmutable::parse($forceDate)
                : \Carbon\CarbonImmutable::now()->subDay();

            $date = $carbon->toDateString();
            $year = $carbon->year;
            /* -----------------------------------------
             | 1. Skip weekends
             -----------------------------------------*/
            $weekendDays = Globals::first()?->weekend_off_days ?? [];

            // Just in case it's still a string (though unlikely given the error),
            // we ensure it's an array for the next step.
            if (is_string($weekendDays)) {
                $weekendDays = json_decode($weekendDays, true) ?? [];
            }

            if (in_array(
                strtolower($carbon->dayName),
                array_map('strtolower', $weekendDays)
            )) {
                Artisan::call('up');
                return;
            }

            /* -----------------------------------------
             | 2. Mark incomplete attendances
             -----------------------------------------*/
            Attendance::where('date', $date)
                ->whereNotNull('sign_in_time')
                ->whereNull('sign_off_time')
                ->update([
                    'status' => 'incomplete',
                    'notes'  => DB::raw(
                        "CONCAT(COALESCE(notes, ''), ' | Did not sign out')"
                    ),
                ]);

            /* -----------------------------------------
             | 3. Process employees
             -----------------------------------------*/
            $employees = Employee::whereDate('hired_on', '<=', $date)->get();

            foreach ($employees as $employee) {
                DB::transaction(function () use ($employee, $date, $year) {

                    $attendance = $employee->attendances()
                        ->where('date', $date)
                        ->first();

                    $request = EmployeeRequest::where('employee_id', $employee->id)
                        ->where('status', 1)
                        ->where('type', 'Leave')
                        ->whereHas('leaveRequest', function ($q) use ($date) {
                            $q->where(function ($qq) use ($date) {
                                $qq->whereDate('start_date', '<=', $date)
                                    ->whereDate('end_date', '>=', $date);
                            })
                                ->orWhereDate('half_leave_date', $date);
                        })
                        ->with('leaveRequest')
                        ->first();

                    $status = $attendance?->status ?? 'missed';
                    $notes  = $attendance?->notes  ?? 'Absent without approval';

                    /* ---------------------------------
                     | Remote work
                     ---------------------------------*/
                    if ($request && $request->type === 'Remote Work') {
                        $status = 'on_time';
                        $notes  = 'Approved Remote Work';
                    }

                    /* ---------------------------------
                     | Leave logic
                     ---------------------------------*/
                    if ($request && $request->type === 'Leave') {
                        $allocation = EmployeeLeaveAllocation::where(
                            'employee_id',
                            $employee->id
                        )->where('year', $year)->lockForUpdate()->first();

                        $duration = (float) ($request->leaveRequest?->leave_duration ?? 1);

                        // HALF DAY
                        if ($duration === 0.5) {
                            if ($attendance && $attendance->sign_in_time) {
                                $status = 'partial_present';
                                $notes  = 'Worked half day + half leave';

                                if ($allocation && $allocation->remaining_leaves >= 0.5) {
                                    $allocation->increment('used_leaves', 0.5);
                                    $allocation->decrement('remaining_leaves', 0.5);
                                } else {
                                    $allocation?->increment('unpaid_leaves', 0.5);
                                }
                            } else {
                                $status = 'unpaid_leave';
                                $notes  = 'Half-day leave without work';
                                $allocation?->increment('unpaid_leaves', 0.5);
                            }
                        }

                        // FULL DAY
                        else {
                            if ($allocation && $allocation->remaining_leaves >= 1) {
                                $status = 'leave';
                                $notes  = 'Approved Paid Leave';

                                $allocation->increment('used_leaves', 1);
                                $allocation->decrement('remaining_leaves', 1);
                            } else {
                                $status = 'unpaid_leave';
                                $notes  = 'Approved Leave (No balance)';
                                $allocation?->increment('unpaid_leaves', 1);
                            }
                        }
                    }

                    /* ---------------------------------
                     | Create or update attendance
                     ---------------------------------*/
                    if ($attendance) {
                        $attendance->update([
                            'status' => $status,
                            'notes'  => $notes,
                        ]);
                    } else {
                        $employee->attendances()->create([
                            'date'              => $date,
                            'status'            => $status,
                            'sign_in_time'      => null,
                            'sign_off_time'     => null,
                            'notes'             => $notes,
                            'is_manually_filled' => true,
                        ]);
                    }
                });
            }
        } finally {
            Artisan::call('up');
            logger('DailyAttendanceHandle completed');
        }
    }
}
