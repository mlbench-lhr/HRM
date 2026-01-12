<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Employee;
use App\Models\Attendance;
use App\Services\AttendanceServices;
use App\Services\CommonServices; // Import CommonServices
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class BulkAttendanceFix extends Command
{
    protected $signature = 'attendance:bulk-fix';
    protected $description = 'Mark all employees present from Jan 1 to Jan 11 (Working Days Only)';

    public function handle(AttendanceServices $attendanceService)
    {
        // Instantiate CommonServices to check for holidays/weekends
        $commonServices = new CommonServices();

        $employees = Employee::all();
        $startDate = Carbon::create(2026, 1, 1);
        $endDate = Carbon::create(2026, 1, 11);

        $this->info("Starting attendance generation for " . $employees->count() . " employees...");

        DB::transaction(function () use ($employees, $startDate, $endDate, $attendanceService, $commonServices) {
            $currentDate = $startDate->copy();

            while ($currentDate->lte($endDate)) {
                $dateString = $currentDate->toDateString();

                // 🛑 CHECK: Is this a working day?
                if ($commonServices->isDayOff($dateString)) {
                    $this->warn("Skipping $dateString (Day Off/Holiday)");
                    $currentDate->addDay();
                    continue;
                }

                $this->line("Processing Working Day: $dateString");

                foreach ($employees as $employee) {
                    $signIn = '09:00:00';
                    $signOut = '18:00:00';

                    // Calculate working/overtime minutes based on employee's specific shift
                    [$working, $overtime] = $attendanceService->calculateMinutes(
                        $employee,
                        $dateString,
                        $signIn,
                        $signOut,
                        'on_time'
                    );

                    Attendance::updateOrCreate(
                        [
                            'employee_id' => $employee->id,
                            'date' => $dateString,
                        ],
                        [
                            'status' => 'on_time',
                            'sign_in_time' => $signIn,
                            'sign_off_time' => $signOut,
                            'working_minutes' => $working,
                            'overtime_minutes' => $overtime,
                            'notes' => 'Bulk fixed (Working Days Only)',
                            'is_manually_filled' => true,
                        ]
                    );
                }
                $currentDate->addDay();
            }
        });

        $this->info('Attendance successfully marked for working days!');
    }
}
