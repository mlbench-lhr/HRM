<?php

namespace App\Tasks;

use App\Models\Addition;
use App\Models\Deduction;
use App\Models\Employee;
use App\Models\Payroll;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Throwable;

class MonthlyPayrollsHandle
{
    /**
     * Execute the payroll generation task.
     * * This task creates a "Draft" payroll for every employee for the current month.
     * It uses firstOrCreate to ensure it is idempotent (can run multiple times safely).
     */
    public function __invoke(): void
    {
        $dueDate = Carbon::now()->startOfMonth()->endOfMonth();

        Log::info('Monthly Payroll Generation Started', [
            'due_date' => $dueDate->toDateString(),
        ]);

        try {
            DB::transaction(function () use ($dueDate) {
                foreach (Employee::cursor() as $employee) {

                    $salary = $employee->salary();

                    $payroll = Payroll::firstOrCreate(
                        [
                            'employee_id' => $employee->id,
                            'due_date'    => $dueDate,
                        ],
                        [
                            'currency' => $salary[0],
                            'base' => $salary[1],
                            'total_payable' => $salary[1],
                            'performance_multiplier' => 1,

                        ]
                    );

                    if ($payroll->wasRecentlyCreated) {
                        Addition::create([
                            'payroll_id' => $payroll->id,
                            'due_date'   => $dueDate,
                        ]);

                        Deduction::create([
                            'payroll_id' => $payroll->id,
                            'due_date'   => $dueDate,
                        ]);
                    }
                }
            });

            Log::info('Monthly Payroll Generation Completed', [
                'due_date' => $dueDate->toDateString(),
            ]);
        } catch (Throwable $e) {
            Log::error('Payroll Task Failed', [
                'error' => $e->getMessage(),
            ]);
            throw $e;
        }
    }
}
