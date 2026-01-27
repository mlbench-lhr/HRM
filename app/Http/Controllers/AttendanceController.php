<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\Employee;
use App\Services\AttendanceServices;
use App\Services\CommonServices;
use App\Services\ValidationServices;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AttendanceController extends Controller
{
    protected AttendanceServices $attendanceServices;
    protected ValidationServices $validationServices;
    protected CommonServices $commonServices;
    public function __construct()
    {
        $this->attendanceServices = new AttendanceServices;
        $this->validationServices = new ValidationServices;
        $this->commonServices = new CommonServices;
    }

    /**
     * Display a listing of the resource.
     */
    public function attendanceDashboard()
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();
        return Inertia::render('Attendance/AttendanceDashboard', [
            "EmployeeStats" => $user->myStats(),
        ]);
    }

    public function index(Request $request)
    {
        $request->validate([
            'term' => 'nullable|date_format:Y-m-d',
        ]);
        $dateParam = $request->input('term', '');

        if ($dateParam) {
            $date = Carbon::createFromFormat('Y-m-d', $dateParam)->startOfDay();
            if ($date->isAfter(Carbon::today()))
                return response()->json(['Error' => 'Date cannot be in the future. Go back and choose a date before today.']);

            $date = $date->toDateString();
        } else {
            $date = '';
        }

        $attendanceList = Attendance::select(
            'date',
            DB::raw('COUNT(CASE WHEN status IN (\'late\', \'on_time\') THEN 1 END) as attended_count'),
            DB::raw('COUNT(CASE WHEN status = \'on_time\' THEN 1 END) as on_time_count'),
            DB::raw('COUNT(CASE WHEN status = \'late\' THEN 1 END) as late_count'),
            DB::raw('COUNT(CASE WHEN status = \'missed\' THEN 1 END) as missed_count')
        )->groupBy('date')->orderByDesc('date');

        if ($date)
            $attendanceList->where('date', '=', $date);

        return Inertia::render('Attendance/Attendances', [
            "attendanceList" => $attendanceList->paginate(config('constants.data.pagination_count')),
            "dateParam" => $date,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        if ($request->term) {
            $request->validate([
                'term' => 'required|date_format:Y-m-d',
            ]);
            $date = Carbon::createFromFormat('Y-m-d', urldecode($request->term))->startOfDay();
            if ($date->isAfter(Carbon::today())) {
                return response()->json(['message' => 'Date cannot be in the future. Go back and choose a date before today.']);
            }
            $date = $date->toDateString();
        } else {
            $date = Carbon::today()->toDateString();
        }

        $attendanceList = Attendance::with('employee:employees.id,name')->where('date', $date)->orderBy('id')->get();
        $attendable = !$this->commonServices->isDayOff($date);

        return Inertia::render('Attendance/AttendanceCreate', [
            "dateParam" => $request->term ?? Carbon::today()->toDateString(),
            "employees" => Employee::select(['id', 'name'])->where('hired_on', '<=', $date)->orderBy('id')->get(),
            "attendances" => $attendanceList,
            "attendable" => $attendable,
        ]);
    }
    public function edit(Attendance $attendance)
    {
        // We load the employee name so we can show it in the header
        return Inertia::render('Attendance/AttendanceEdit', [
            'attendance' => $attendance->load('employee:id,name'),
        ]);
    }

    public function update(Request $request, Attendance $attendance)
    {
        $validated = $request->validate([
            'status' => 'required|string',
            'sign_in_time' => 'nullable',
            'sign_off_time' => 'nullable',
            'notes' => 'nullable|string',
        ]);

        $attendance->update($validated);

        // Redirecting back to the specific day view
        return redirect()->route('attendance.show', ['date' => $attendance->date])
            ->with('message', 'Attendance Updated Successfully');
    }
    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $res = $this->validationServices->validateMassAttendanceCreation($request);
        return $this->attendanceServices->createAttendance($res, $this->commonServices);
    }

    public function dayShow(Request $request, string $day) // Add Request $request here
    {
        $date = $this->validationServices->validateDayAttendanceDateParameter($day);
        if (!is_string($date)) return $date;

        $term = $request->input('term'); // Get the search term from the request

        $attendanceList = Attendance::where('date', $date)
            ->join('employees', 'attendances.employee_id', '=', 'employees.id')
            // ADD THIS: Filter by employee name if search term exists
            ->when($term, function ($query, $term) {
                $query->where('employees.name', 'like', '%' . $term . '%');
            })
            ->select([
                'attendances.id',
                'employees.name as employee_name',
                'attendances.status',
                'attendances.sign_in_time',
                'attendances.sign_off_time',
                'attendances.notes'
            ])
            ->orderByDesc('attendances.created_at')
            ->paginate(config('constants.data.pagination_count'))
            ->withQueryString(); // Keeps search term in pagination links

        return Inertia::render('Attendance/AttendanceDayView', [
            "attendanceList" => $attendanceList,
            "day" => $date,
            "filters" => $request->only(['term']) // Pass filters back to Vue
        ]);
    }
    public function dayDelete(Request $request)
    {
        $res = $request->validate([
            'date' => 'required|date_format:Y-m-d',
        ]);
        return $this->attendanceServices->deleteDayAttendance($res);
    }

    /***
     **************** SELF-TAKING ATTENDANCE SECTION ****************
     ***/

    public function dashboardSignInAttendance(Request $request)
    {
        return $this->attendanceServices->selfSignInAttendance($request);
    }

    public function dashboardSignOffAttendance(Request $request)
    {
        return $this->attendanceServices->selfSignOffAttendance($request);
    }
}
