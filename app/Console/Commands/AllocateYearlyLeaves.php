<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Employee;
use App\Services\LeaveAllocationService;

class AllocateYearlyLeaves extends Command
{
    protected $signature = 'leaves:allocate {--year=}';
    protected $description = 'Allocate yearly leave entitlements';

    public function handle()
    {
        $year = (int) ($this->option('year') ?? now()->year);

        $service = app(LeaveAllocationService::class);

        $employees = Employee::whereHas(
            'roles',
            fn($q) =>
            $q->where('name', 'employee')
        )->get();

        foreach ($employees as $employee) {
            $service->allocateNewYear($employee, $year);
        }

        $this->info("Leave allocation completed for year {$year}");
        return Command::SUCCESS;
    }
}
