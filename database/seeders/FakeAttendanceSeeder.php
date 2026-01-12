<?php

namespace Database\Seeders;

use App\Models\Attendance;
use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class FakeAttendanceSeeder extends Seeder
{
    public function run(): void
    {
        $employees = Employee::whereIn('id', [
            17,
            1,
            5,
            6,
            8,
            9,
            11,
            12,
            14,
            15,
            20,
            21,
            22,
            23,
            24,
            27,
            28,
            31,
            2,
            3,
            4,
            7,
            10,
            13,
            16,
            26,
            29,
            32
        ])->get();

        $start = Carbon::parse('2025-12-01');
        $end   = Carbon::parse('2026-01-05');

        while ($start->lte($end)) {

            foreach ($employees as $employee) {

                // 70% chance employee signs in
                if (rand(1, 100) <= 70) {

                    Attendance::create([
                        'employee_id' => $employee->id,
                        'date'        => $start->toDateString(),
                        'sign_in_time' => '09:00:00',

                        // 20% chance they forget to sign out
                        'sign_off_time' => rand(1, 100) <= 20
                            ? null
                            : '17:00:00',

                        'status' => 'on_time',
                        'notes'  => 'Seeded sign-in',
                    ]);
                }
            }

            $start->addDay();
        }
    }
}
