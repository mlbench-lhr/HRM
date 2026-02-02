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
        $period = Carbon::now()->startOfMonth();
        $dueDate = $period->copy()->endOfMonth();
        $periodString = $period->format('Y-m');

        Log::info('Monthly Payroll Generation Started', [
            'period' => $periodString,
        ]);

        try {
            // Using a transaction ensures that we don't end up with partial data
            DB::transaction(function () use ($periodString, $dueDate) {

                // cursor() is memory efficient for large datasets
                foreach (Employee::cursor() as $employee) {

                    // Fetch salary data once per loop
                    // Expected structure: ['currency' => 'USD', 'base' => 5000]
                    $salary = $employee->salary();

                    $payroll = Payroll::firstOrCreate(
                        [
                            'employee_id' => $employee->id,
                            'period'      => $periodString,
                        ],
                        [
                            'currency'               => $salary['currency'] ?? 'USD',
                            'base'                   => $salary['base'] ?? 0,
                            'total_payable'          => $salary['base'] ?? 0,
                            'performance_multiplier' => 1,
                            'due_date'               => $dueDate,
                            'status'                 => 'draft',
                        ]
                    );

                    /**
                     * Optimization: Only create Additions and Deductions if the
                     * payroll record was just created for the first time.
                     */
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
                'period' => $periodString,
            ]);
        } catch (Throwable $e) {
            Log::error('Payroll Task Failed', [
                'period' => $periodString,
                'error'  => $e->getMessage(),
                'trace'  => $e->getTraceAsString(),
            ]);

            // Re-throw if you want the Task Scheduler to record the failure
            throw $e;
        }
    }
}
