<?php

namespace App\Models;

use Carbon\Carbon;
use Carbon\CarbonImmutable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\DB;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Activitylog\LogOptions;


/**
 * @method static Employee user()
 */
class Employee extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles, LogsActivity;
    protected $guard_name = 'web';
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded = [];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'is_remote' => 'boolean',
        // 'hired_on' => 'date',
    ];

    public function leaveAllocations()
    {
        return $this->hasMany(EmployeeLeaveAllocation::class, 'employee_id', 'id');
    }
    public function requests()
    {
        return $this->hasMany(Request::class, 'employee_id', 'id');
    }

    public function leaveRequests()
    {
        return $this->hasManyThrough(
            LeaveRequest::class,
            Request::class,
            'employee_id',
            'request_id',
            'id',
            'id'
        )->whereHas('request', function ($q) {
            $q->where('type', 'Leave');
        });
    }
    public function branch()
    {
        return $this->belongsTo(Branch::class, 'branch_id');
    }
    protected static function boot(): void
    {
        parent::boot();
        static::created(function ($model) {
            $model->normalized_name = NormalizeArabic($model->name);
            $model->save();
        });
    }

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults();
    }

    /**************------- SALARIES -------*************/

    public function salaries(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(EmployeeSalary::class);
    }

    // Active Salary
    public function salary()
    {
        $salary = $this->salaries()->where('end_date', null)->first();
        return [$salary->currency, $salary->salary, $salary->start_date];
    }

    /**************------- Payrolls -------*************/

    public function payrolls(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Payroll::class);
    }

    /**************------- Evaluations -------*************/

    // Active Salary
    public function evaluations()
    {
        return $this->hasMany(EmployeeEvaluation::class);
    }


    /**************------- POSITIONS -------*************/

    public function employeePositions(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(EmployeePosition::class, 'employee_id');
        //        return $this->hasManyThrough(Position::class, EmployeePosition::class, 'employee_id', 'id', 'id', 'position_id');
    }

    // WARNING: THIS FUNCTION ONLY FETCHES THE LAST ACTIVE POSITION. IF AN EMPLOYEE HAS MULTIPLE ACTIVE POSITIONS, THIS FUNCTION WILL ONLY RETURN THE LAST ONE
    // USE activePositions() if you want to retrieve all active positions.
    public function activePosition(): \Illuminate\Database\Eloquent\Collection
    {
        return $this->employeePositions()->where('end_date', null)->first()->get();
    }

    public function activePositions(): \Illuminate\Database\Eloquent\Collection
    {
        return $this->positions()->where('end_date', null)->get();
    }

    /**************------- Department -------*************/
    public function department(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(Department::class, 'id', 'department_id');
    }

    /**************------- Department -------*************/


    public function manages()
    {
        return $this->hasMany(Manager::class, 'employee_id');
    }

    public function attendances(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Attendance::class);
    }

    /**************------- Shifts -------*************/

    public function shifts()
    {
        return $this->hasManyThrough(Shift::class, EmployeeShift::class, 'employee_id', 'id', 'id', 'shift_id');
    }

    public function employeeShifts(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(EmployeeShift::class, 'employee_id');
    }
    public function activeShift()
    {
        return $this->employeeShifts()
            ->with('shift')
            ->whereNull('end_date')
            ->first()->shift;
    }
    public function activeShiftPeriod()
    {
        return $this->activeShift()?->shiftPeriod();
    }

    /**************------- Department -------*************/


    public function getAttended(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        // exclude absented ones
        return $this->attendances()->where('status', '!=', 'missed');
    }
    public function getAttendedInYear($year): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        // exclude absented ones
        return $this->attendances()->where('status', '!=', 'missed')->whereYear('date', $year);
    }
    public function getAbsentedInYear($year): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        // get absented ones
        return $this->attendances()->where('status', '=', 'missed')->whereYear('date', $year);
    }
    public function getAbsented(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        // get absented ones
        return $this->attendances()->where('status', '=', 'missed');
    }

    public function getYearStats($globalSettings = null)
    {
        $globalSettings ?? Globals::first();
        $commonServices = new \App\Services\CommonServices();
        $thisYearData = $commonServices->calcOffDays($globalSettings->weekend_off_days, $this->hired_on);
        $holidaysThisYear = $commonServices->countHolidays($this->hired_on);
        return [
            "workingDaysThisYear" => $thisYearData['total_year_days'],
            "WeekendOffDaysThisYear" => $thisYearData['offDays'],
            "weekendOffDays" => $globalSettings->weekend_off_days, // Friday, Saturday.. etc
            "HolidaysThisYear" => $holidaysThisYear,
            "absence_limit" => $globalSettings->absence_limit,
        ];
    }
    public function myStats(): array
    {
        $now = \Carbon\Carbon::now();
        $globalSettings = \App\Models\Globals::first();
        $commonServices = new \App\Services\CommonServices();

        // 1. Determine the Start Date for Calculations
        // Rule: Start from the DAY AFTER they were hired/created.
        $hiredDate = \Carbon\Carbon::parse($this->hired_on);
        $startDateForCalc = $hiredDate->copy()->addDay()->startOfDay();

        // Ensure we don't calculate for dates before this month started
        // If they joined last year, start from Day 1 of this month.
        // If they joined on Jan 5th, start from Jan 6th.
        $startOfMonth = $now->copy()->startOfMonth();

        // The effective start date is whichever is later
        $effectiveStartDate = $startDateForCalc->greaterThan($startOfMonth) ? $startDateForCalc : $startOfMonth;

        // 2. Loop to calculate Expected Hours (Skipping Weekends/Holidays)
        $expectedMinutesSoFar = 0;
        $workingDaysSoFar = 0;

        // Loop from Effective Start -> Yesterday (or Now)
        // We iterate day by day to be 100% accurate
        if ($effectiveStartDate->lessThanOrEqualTo($now)) {
            $period = \Carbon\CarbonPeriod::create($effectiveStartDate, $now->copy()->subDay()); // Until yesterday? Or Today? usually stats are "so far"

            foreach ($period as $date) {
                // Check if Day Off
                if ($commonServices->isDayOff($date->toDateString())) {
                    continue;
                }

                // It is a working day
                $workingDaysSoFar++;

                // Get Shift Duration for this specific day (in case shifts changed)
                // If you have variable shifts, logic goes here. For now, assuming standard shift.
                $shift = $this->activeShift();
                if ($shift) {
                    $sStart = \Carbon\Carbon::parse($date->toDateString() . ' ' . $shift->start_time);
                    $sEnd   = \Carbon\Carbon::parse($date->toDateString() . ' ' . $shift->end_time);
                    if ($sEnd->lessThan($sStart)) $sEnd->addDay();
                    $expectedMinutesSoFar += $sStart->diffInMinutes($sEnd);
                }
            }
        }

        // 3. Expected for the WHOLE Month (Pro-rated if they joined mid-month)
        // If they joined mid-month, their "Expected This Month" is lower than existing employees.
        $expectedMinutesMonth = 0;
        $workingDaysMonth = 0;
        $monthPeriod = \Carbon\CarbonPeriod::create($effectiveStartDate, $now->copy()->endOfMonth());

        foreach ($monthPeriod as $date) {
            if ($commonServices->isDayOff($date->toDateString())) continue;
            $workingDaysMonth++;
            // Add standard shift minutes (e.g., 540)
            $expectedMinutesMonth += 540; // Or dynamic shift logic
        }

        // 4. Actual Attendance Data
        $attended = $this->getAttended();
        $absented = $this->getAbsented();

        // Filter attendance to match the calculation period
        $attendanceRecords = (clone $attended)
            ->whereDate('date', '>=', $effectiveStartDate)
            ->whereDate('date', '<=', $now)
            ->get();

        $actualMinutesSoFar = $attendanceRecords->sum('working_minutes');

        // Stats specific to current month view
        $holidaysCount = $commonServices->countHolidays($this->hired_on, [$now->year, $now->month, 1, $now->year, $now->month, $now->daysInMonth]);
        $weekendsCount = $commonServices->calcOffDays($globalSettings->weekend_off_days, $this->hired_on, [$now->year, $now->month, 1, $now->year, $now->month, $now->daysInMonth]);


        return [
            "YearStats" => $this->getYearStats($globalSettings),

            "attendableThisMonth" => $workingDaysMonth, // Total working days possible for THIS user this month
            "holidaysThisMonth"   => $holidaysCount,
            "weekendsThisMonth"   => $weekendsCount,

            "attendedThisMonth"   => $attendanceRecords->whereBetween('date', [$startOfMonth, $now])->count(),
            "absentedThisMonth"   => $workingDaysSoFar - $attendanceRecords->count(), // Rough estimate

            "totalAttendanceSoFar" => $attendanceRecords->count(),

            // Expected Hours
            "expectedHoursThisMonth" => round($expectedMinutesMonth / 60, 2),
            "actualHoursThisMonth"   => round($actualMinutesSoFar / 60, 2),

            // Differences
            "hoursDifference"      => round(($actualMinutesSoFar - $expectedMinutesMonth) / 60, 2), // vs Month Total
            "hoursDifferenceSoFar" => round(($actualMinutesSoFar - $expectedMinutesSoFar) / 60, 2), // vs Expectations up to today
        ];
    }

    public function payrollAttendanceSummary(int $year, int $month): array
    {
        $attendances = $this->attendances()
            ->whereYear('date', $year)
            ->whereMonth('date', $month)
            ->get();

        $summary = [
            'paid_days'   => 0,
            'unpaid_days' => 0,
            'worked_days' => 0,
            'worked_hours' => 0,
        ];

        foreach ($attendances as $a) {
            switch ($a->status) {

                case 'on_time':
                case 'leave':
                    $summary['paid_days']++;
                    $summary['worked_days']++;
                    $summary['worked_hours'] += 8;
                    break;

                case 'partial_present':
                    $summary['paid_days'] += 0.5;
                    $summary['worked_days'] += 0.5;
                    $summary['worked_hours'] += 4;
                    break;

                case 'late':
                    $summary['paid_days']++;
                    $summary['worked_hours'] += $a->worked_hours ?? 6;
                    break;

                case 'unpaid_leave':
                case 'missed':
                    $summary['unpaid_days']++;
                    break;

                case 'incomplete':
                    // business decision
                    break;
            }
        }

        return $summary;
    }
    // public function monthHours(int $year, int $month): array
    // {
    //     $shift = $this->activeShift();

    //     if (!$shift) {
    //         return [
    //             'expectedHours'   => 0,
    //             'actualHours'     => 0,
    //             'hoursDifference' => 0,
    //         ];
    //     }

    //     $shiftHours = $shift->shiftPeriod(); // dynamic (9, 8, night, etc.)

    //     $attendances = $this->attendances()
    //         ->whereYear('date', $year)
    //         ->whereMonth('date', $month)
    //         ->get();

    //     $actual   = 0.0;
    //     $expected = 0.0;

    //     foreach ($attendances as $a) {

    //         // every attendance day is an expected shift
    //         $expected += $shiftHours;

    //         switch ($a->status) {

    //             case 'on_time':
    //             case 'leave': // paid leave
    //                 $actual += $shiftHours;
    //                 break;

    //             case 'partial_present':
    //                 $actual += $shiftHours / 2;
    //                 break;

    //             case 'late':
    //             case 'incomplete':
    //                 if ($a->sign_in_time && $a->sign_off_time) {
    //                     $actual +=
    //                         Carbon::parse($a->sign_in_time)
    //                         ->diffInMinutes(Carbon::parse($a->sign_off_time)) / 60;
    //                 }
    //                 break;

    //             case 'unpaid_leave':
    //             case 'missed':
    //                 // zero actual hours
    //                 break;
    //         }
    //     }

    //     return [
    //         'expectedHours'   => round($expected, 2),
    //         'actualHours'     => round($actual, 2),
    //         'hoursDifference' => round($actual - $expected, 2),
    //     ];
    // }
    public function monthHours(int $year, int $month): array
    {
        $shift = $this->activeShift();

        if (!$shift) {
            return [
                'expectedHours'   => 0,
                'actualHours'     => 0,
                'hoursDifference' => 0,
            ];
        }

        // ---- SHIFT LENGTH ----
        $shiftStart = Carbon::parse($shift->start_time);
        $shiftEnd   = Carbon::parse($shift->end_time);

        if ($shiftEnd->lessThanOrEqualTo($shiftStart)) {
            $shiftEnd->addDay();
        }

        $dailyExpectedMinutes = $shiftStart->diffInMinutes($shiftEnd);

        // ---- EXPECTED: ALL ATTENDABLE DAYS ----
        $attendableDays = $this->attendances()
            ->whereYear('date', $year)
            ->whereMonth('date', $month)
            ->count();

        $expectedMinutes = $attendableDays * $dailyExpectedMinutes;

        // ---- ACTUAL: STORED TRUTH ----
        $actualMinutes = $this->attendances()
            ->whereYear('date', $year)
            ->whereMonth('date', $month)
            ->sum(DB::raw('working_minutes + overtime_minutes'));

        return [
            'expectedHours'   => round($expectedMinutes / 60, 2),
            'actualHours'     => round($actualMinutes / 60, 2),
            'hoursDifference' => round(($actualMinutes - $expectedMinutes) / 60, 2),
        ];
    }






    // public function monthHours($year, $month): array
    // {
    //     $monthEnd = Carbon::createFromDate($year, $month, 1)->endOfMonth()->format('j');
    //     $commonServices = new \App\Services\CommonServices();
    //     $monthDates = [$year, $month, 1, $year, $month, $monthEnd];

    //     // Calculations for the entire month
    //     $holidaysCount = $commonServices->countHolidays($this->hired_on, $monthDates);
    //     $workingDays = $monthEnd - $holidaysCount -
    //         $commonServices->calcOffDays(Globals::first()->weekend_off_days, $this->hired_on, $monthDates);

    //     $attended = $this->getAttended();

    //     $monthAttendance = (clone $attended)->whereYear('date', $year)->whereMonth('date', $month)->get();

    //     $actualHours =
    //         $monthAttendance->sum(function ($attendance) {
    //             $signInTime = Carbon::parse($attendance->sign_in_time);
    //             $signOffTime = Carbon::parse($attendance->sign_off_time);
    //             return $signInTime->diffInMinutes($signOffTime) / 60;
    //         });

    //     $shiftHours = $this->activeShiftPeriod();
    //     $expectedHours = $workingDays * $shiftHours;

    //     return [
    //         "expectedHours" => $expectedHours,
    //         "actualHours" => $actualHours,
    //         "hoursDifference" => $actualHours - $expectedHours,
    //     ];
    // }
}
