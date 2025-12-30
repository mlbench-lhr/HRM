<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\EmployeeLeaveAllocation;
use Carbon\Carbon;

class LeaveAllocationService
{
    const TOTAL  = 20;
    const SICK   = 8;
    const CASUAL = 12;

    /**
     * Called when probation → employee
     */
    public function allocateOnConfirmation(Employee $employee): void
    {
        $year = now()->year;
        // DO NOT TOUCH IF YEARLY ALLOCATION EXISTS
        if (EmployeeLeaveAllocation::where('employee_id', $employee->id)
            ->where('year', $year)
            ->exists()
        ) {
            return;
        }
        $confirmedAt = now();
        $remainingMonths = 12 - $confirmedAt->month + 1;
        $factor = $remainingMonths / 12;

        $sick   = round(self::SICK * $factor);
        $casual = round(self::CASUAL * $factor);
        $total  = $sick + $casual;
        // 2. Calculate actual usage for THIS year only
        // This ensures that if they took unpaid leaves during probation, they are deducted
        // $used = \App\Models\LeaveRequest::whereHas('request', function ($q) use ($employee) {
        //     $q->where('employee_id', $employee->id)
        //         ->where('status', 'Approved');
        // })
        //     ->whereYear('start_date', $year)
        //     ->sum('leave_duration');
        $allocation = EmployeeLeaveAllocation::updateOrCreate(
            [
                'employee_id' => $employee->id,
                'year'        => $year,
            ],
            [
                'sick_leaves'      => $sick,
                'casual_leaves'    => $casual,
                'total_leaves'     => $total,
                'used_leaves'      => 0,        // RESET
                'remaining_leaves' => $total,    // RESET
                'unpaid_leaves'    => 0,          // RESET
            ]
        );

        $used = (int) $allocation->used_leaves;

        $allocation->update([
            'sick_leaves'      => $sick,
            'casual_leaves'    => $casual,
            'total_leaves'     => $total,
            'remaining_leaves' => max(0, $total - $used),
            'unpaid_leaves'    => max(0, $used - $total),
        ]);
    }

    /**
     * Called yearly (Jan 1)
     */
    // public function allocateNewYear(Employee $employee, int $year): void
    // {
    //     EmployeeLeaveAllocation::updateOrCreate(
    //         [
    //             'employee_id' => $employee->id,
    //             'year' => $year,
    //         ],
    //         [
    //             'sick_leaves'      => self::SICK,
    //             'casual_leaves'    => self::CASUAL,
    //             'total_leaves'     => self::TOTAL,
    //             'used_leaves'      => 0,
    //             'remaining_leaves' => self::TOTAL,
    //             'unpaid_leaves'    => 0,
    //         ]
    //     );
    // }
    /**
     * Called yearly (Jan 1)
     */
    // public function allocateNewYear(Employee $employee, int $year): void
    // {
    //     // HARD RESET for this year (prevents carry-over pollution)
    //     EmployeeLeaveAllocation::where('employee_id', $employee->id)
    //         ->where('year', $year)
    //         ->delete();

    //     // CREATE FRESH YEAR ALLOCATION
    //     EmployeeLeaveAllocation::create([
    //         'employee_id'      => $employee->id,
    //         'year'             => $year,
    //         'sick_leaves'      => self::SICK,
    //         'casual_leaves'    => self::CASUAL,
    //         'total_leaves'     => self::TOTAL,
    //         'used_leaves'      => 0,
    //         'remaining_leaves' => self::TOTAL,
    //         'unpaid_leaves'    => 0,
    //     ]);
    // }
    public function allocateNewYear(Employee $employee, int $year): void
    {
        // 1. Wipe the specific year to ensure a clean slate
        EmployeeLeaveAllocation::where('employee_id', $employee->id)
            ->where('year', $year)
            ->delete();

        // 2. Explicitly define the fresh values
        // Do NOT pull $allocation->used_leaves from the model before this
        EmployeeLeaveAllocation::create([
            'employee_id'      => $employee->id,
            'year'             => $year,
            'sick_leaves'      => self::SICK,
            'casual_leaves'    => self::CASUAL,
            'total_leaves'     => self::TOTAL,
            'used_leaves'      => 0,           // HARD SET TO 0
            'remaining_leaves' => self::TOTAL,  // HARD SET TO FULL AMOUNT
            'unpaid_leaves'    => 0,           // HARD SET TO 0
        ]);
    }
}
