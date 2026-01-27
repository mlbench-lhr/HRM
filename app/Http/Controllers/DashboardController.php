<?php

namespace App\Http\Controllers;

use App\Models\Globals;
use App\Services\CommonServices;
use Carbon\Carbon;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function index()
    {
        /** @var \App\Models\User $user */
        $user = Auth::user(); // We assign this to a variable to help the IDE

        $commonServices = new CommonServices();
        $isTodayOff = $commonServices->isTodayOff();

        // 1. Get Today's Attendance Record
        $attendanceChecker = $user->attendances()
            ->where('date', Carbon::today()->toDateString())
            ->first();

        // 2. Determine Attendance Status
        if (is_null($attendanceChecker)) {
            $attendanceStatus = 0; // Not checked in yet
        } else if ($attendanceChecker->sign_off_time == null) {
            $attendanceStatus = 1; // Currently checked in
        } else {
            $attendanceStatus = 2; // Checked out (Day finished)
        }

        // 3. Get Stats & Add Sign-In Time (This fixes the missing badge)
        $stats = $user->myStats();

        // Logic: If attendance exists and has a sign_in_time, format it.
        $stats['today_sign_in_time'] = ($attendanceChecker && $attendanceChecker->sign_in_time)
            ? Carbon::parse($attendanceChecker->sign_in_time)->format('h:i A') // e.g., "09:30 AM"
            : null;

        return Inertia::render('Dashboard', [
            'salary' => $user->salary(),
            'payroll_day' => Globals::first()->payroll_day,
            "employee_stats" => $stats, // Passing the updated stats array
            "attendance_status" => $attendanceStatus,
            "is_today_off" => $isTodayOff,
        ]);
    }
}
