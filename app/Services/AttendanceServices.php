<?php

namespace App\Services;

use App\Models\Attendance;
use App\Models\Employee;
use App\Models\Globals;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AttendanceServices
{
    // private function validateIP($ip_to_check): bool
    // {
    //     // $org_ips = json_decode(Globals::first()->ip);
    //     $org_ips = json_decode(Globals::first()->ip, true);
    //     if (!is_array($org_ips)) {
    //         return false;
    //     }
    //     foreach ($org_ips as $org_ip) {
    //         if (str_contains($org_ip, '*')) {
    //             $org_ip_segment = explode('*', $org_ip)[0];
    //             $checker = 0;
    //             for ($i = 0; $i < strlen($org_ip_segment); $i++) {
    //                 if ($org_ip_segment[$i] == $ip_to_check[$i]) {
    //                     $checker++;
    //                 }
    //             }
    //             if ($checker == strlen($org_ip_segment)) {
    //                 return true;
    //             }
    //         } else if ($ip_to_check == $org_ip) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }
    private function validateIP(string $ip_to_check): bool
    {

        $globals = Globals::first();

        if (!(bool) $globals->is_ip_based) {
            return true;
        }

        $org_ips = $globals->ip;

        if (is_string($org_ips)) {
            $org_ips = json_decode($org_ips, true);
        }

        if (!is_array($org_ips)) {
            return false;
        }

        foreach ($org_ips as $org_ip) {

            // Wildcard support: 192.168.1.*
            if (str_contains($org_ip, '*')) {
                $prefix = rtrim($org_ip, '*');

                if (str_starts_with($ip_to_check, $prefix)) {
                    return true;
                }
            }

            // Exact match
            else {
                if ($ip_to_check === $org_ip) {
                    return true;
                }
            }
        }

        return false;
    }

    private function validateRequest($request)
    {
        /***
         *
         * validateRequest() function is used to:
         * 1. Authorize the request,to make sure that the employee is signing in for themselves.
         * 2. check if today is off or not,
         * 3. Validate the request's IP (if IP-based attendance is enabled).
         *
         */

        //-- Check if today is a holiday or not --//
        $commonServices = new CommonServices();
        $isTodayOff = $commonServices->isTodayOff();
        if ($isTodayOff) {
            return [
                'day_off' => 'No Attendance for today! <br/> Maybe spend some quality time with your cat?',
            ];
        }

        //-- Check IP, If IP-based Attendance is enabled --//
        $globals = Globals::first();

        // Checks if ip is enabled but no IPs in the database. This should never happen.
        if ($globals->is_ip_based && is_null($globals->ip)) {
            return [
                'no_ip' => 'IP-based attendance is enabled, but there are no IPs in the database.
                            <br/>Please contact your system administrator and inform them of them error.',
            ];
        }
        if (!auth()->user()->is_remote && $globals->is_ip_based && !$this->validateIP($request->ip())) {
            return [
                'ip_error' => 'You are probably not inside the organization.<br/> Attendance can be only taken from inside.<br/>Please contact your system administrator if you think this was a mistake.',
            ];
        }

        // Check if employee is signing in for themselves
        if ($request->id != auth()->user()->id) {
            return [
                'authorization_error' => 'You are not authorized to perform this action. <br/>Please contact your system administrator if you think this was a mistake.',
            ];
        }
    }
    public function createAttendance($res, $commonServices): \Illuminate\Http\JsonResponse|\Illuminate\Http\RedirectResponse
    {
        $isDayOff = $commonServices->isDayOff($res['date']);
        if ($isDayOff) {
            return response()->json(['message' => 'Cannot create attendance for a day off.']);
        }

        for ($i = 0; $i < count($res['employee_id']); $i++) {
            $employee = Employee::find($res['employee_id'][$i]);

            $signIn = Carbon::createFromTime(
                $res['sign_in_time'][$i]['hours'],
                $res['sign_in_time'][$i]['minutes'],
                $res['sign_in_time'][$i]['seconds']
            )->format('H:i:s');

            $signOut = Carbon::createFromTime(
                $res['sign_off_time'][$i]['hours'],
                $res['sign_off_time'][$i]['minutes'],
                $res['sign_off_time'][$i]['seconds']
            )->format('H:i:s');

            [$workingMinutes, $overtimeMinutes] =
                $this->calculateMinutes(
                    $employee,
                    $res['date'],
                    $signIn,
                    $signOut,
                    $res['status'][$i]
                );
            // Logic for updating needs to happen here
            $empAtt = Employee::find($res['employee_id'][$i])->attendances()->where('date', $res['date'])->get();
            // If there is an attendance record for the employee on the date, update it
            if (count($empAtt) > 0) {
                $empAtt[0]->update([
                    'status' => $res['status'][$i],
                    'sign_in_time' => $signIn,
                    'sign_off_time' => $signOut,
                    // 'sign_in_time' => Carbon::createFromTime($res['sign_in_time'][$i]['hours'], $res['sign_in_time'][$i]['minutes'], $res['sign_in_time'][$i]['seconds'])->format('H:i:s'),
                    // 'sign_off_time' => Carbon::createFromTime($res['sign_off_time'][$i]['hours'], $res['sign_off_time'][$i]['minutes'], $res['sign_off_time'][$i]['seconds'])->format('H:i:s'),
                    'notes' => $res['notes'][$i],
                    'working_minutes' => $workingMinutes,
                    'overtime_minutes' => $overtimeMinutes,
                ]);
                // In case there are more than 1 attendance records for the employee on the date, delete them
                for ($j = 1; $j < count($empAtt); $j++) {
                    $empAtt[$j]->delete();
                }
                continue;
            }

            // If there is no attendance record for the employee on the date, create it
            Attendance::create([
                'date' => $res['date'],
                'employee_id' => $res['employee_id'][$i],
                'status' => $res['status'][$i],
                'sign_in_time' => $signIn,
                'sign_off_time' => $signOut,
                // 'sign_in_time' => Carbon::createFromTime($res['sign_in_time'][$i]['hours'], $res['sign_in_time'][$i]['minutes'], $res['sign_in_time'][$i]['seconds'])->format('H:i:s'),
                // 'sign_off_time' => Carbon::createFromTime($res['sign_off_time'][$i]['hours'], $res['sign_off_time'][$i]['minutes'], $res['sign_off_time'][$i]['seconds'])->format('H:i:s'),
                'notes' => $res['notes'][$i],
                'working_minutes' => $workingMinutes,
                'overtime_minutes' => $overtimeMinutes,
            ]);
        }

        return to_route('attendances.index');
    }
    public function deleteDayAttendance($res): \Illuminate\Http\JsonResponse|\Illuminate\Http\RedirectResponse
    {

        $date = Carbon::createFromFormat('Y-m-d', urldecode($res['date']))->startOfDay();
        if ($date->isAfter(Carbon::today())) {
            return response()->json(['message' => 'Date cannot be in the future. Go back and choose a date before today.']);
        }
        Attendance::where('date', $res['date'])->delete();
        return to_route('attendances.index');
    }

    public function selfSignInAttendance($request): \Illuminate\Http\RedirectResponse
    {

        // Validate first
        $res = $this->validateRequest($request);
        if ($res) { // if there is a response, then there is an error. RETURN.
            return redirect()->back()->withErrors($res);
        }

        $today = \Illuminate\Support\Carbon::today()->toDateString();
        // If employee is late for less than 15 minutes, status will be on_time, otherwise, they will be accounted late.
        $lateMargin = 15; // 15 minutes
        $currentTimestamp = Carbon::now();
        $shiftStartTime = Carbon::createFromFormat('H:i:s', Employee::find($request->id)->activeShift()->start_time);
        $status = ($shiftStartTime->diffInMinutes($currentTimestamp) <= $lateMargin) ? 'on_time' : 'late';

        // If there is an attendance record for the employee on the date, update it
        Attendance::firstOrCreate(
            [
                "employee_id" => $request->id,
                "date" => $today,
            ],
            [
                "sign_in_time" => $currentTimestamp,
                "sign_off_time" => null,
                "status" => $status,
                "notes" => "Sign-in Manually filled by employee",
                "is_manually_filled" => true,
            ]
        );
        return to_route('dashboard.index');
    }

    public function selfSignOffAttendance($request)
    {
        // Validate first
        $res = $this->validateRequest($request);
        if ($res) {
            return redirect()->back()->withErrors($res);
        }

        $today = \Illuminate\Support\Carbon::today()->toDateString();
        $attendance = Attendance::where('employee_id', $request->id)->where('date', $today)->first();

        if ($attendance) {
            $employee = Employee::find($request->id);

            [$workingMinutes, $overtimeMinutes] =
                $this->calculateMinutes(
                    $employee,
                    $attendance->date,
                    $attendance->sign_in_time,
                    Carbon::now()->format('H:i:s'),
                    $attendance->status
                );

            $attendance->update([
                "sign_off_time" => Carbon::now(),
                "notes" => "Manually filled by employee",

                "working_minutes" => $workingMinutes,
                "overtime_minutes" => $overtimeMinutes,
            ]);
        } else {
            return response()->json(['Error' => 'No Sign in record was found.'], 400);
        }
    }
    public function calculateMinutes(
        Employee $employee,
        string $attendanceDate,
        $signIn,
        $signOut,
        ?string $status
    ): array {
        $status = $status ?: 'missed';
        // Missed day
        if ($status === 'missed' || !$signIn || !$signOut) {
            return [0, 0];
        }

        // Expected minutes from shift
        $shift = $employee->activeShift();

        $shiftStart = Carbon::parse($attendanceDate . ' ' . $shift->start_time);
        $shiftEnd   = Carbon::parse($attendanceDate . ' ' . $shift->end_time);

        if ($shiftEnd->lessThanOrEqualTo($shiftStart)) {
            $shiftEnd->addDay();
        }

        $expectedDailyMinutes = $shiftStart->diffInMinutes($shiftEnd);


        $workedMinutes =
            Carbon::parse($signIn)->diffInMinutes(Carbon::parse($signOut));

        // Partial present (half day)
        if ($status === 'partial_present') {
            return [
                (int) ($expectedDailyMinutes / 2),
                0
            ];
        }
        // if ($status === 'partial_present') {
        //     $workingMinutes  = min($workedMinutes, (int) ($expectedDailyMinutes / 2));
        //     $overtimeMinutes = max(0, $workedMinutes - (int) ($expectedDailyMinutes / 2));

        //     return [$workingMinutes, $overtimeMinutes];
        // }
        $workingMinutes  = min($workedMinutes, $expectedDailyMinutes);
        $overtimeMinutes = max(0, $workedMinutes - $expectedDailyMinutes);

        return [$workingMinutes, $overtimeMinutes];
    }
    public function recalcMinutes(Attendance $attendance): void
    {
        [$working, $overtime] = $this->calculateMinutes(
            $attendance->employee,
            $attendance->date,
            $attendance->sign_in_time,
            $attendance->sign_off_time,
            $attendance->status ?: 'missed'
        );

        $attendance->update([
            'working_minutes'  => $working,
            'overtime_minutes' => $overtime,
        ]);
    }
}
