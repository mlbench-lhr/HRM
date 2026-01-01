<?php

namespace App\Http\Controllers;

use App\Services\RequestServices;
use App\Services\ValidationServices;
use Illuminate\Http\Request;
use Inertia\Inertia;


// Using \App\Models\Request instead of Request because Request is a class in Illuminate\Http\Request
class RequestController extends Controller
{
    protected RequestServices $requestServices;
    protected ValidationServices $validationServices;
    public function __construct()
    {
        $this->requestServices = new RequestServices;
        $this->validationServices = new ValidationServices;
    }

    /**
     * Display a listing of the resource.
     */
    // public function index()
    // {
    //     $requests = \App\Models\Request::join('employees', 'requests.employee_id', '=', 'employees.id')
    //         ->select(['requests.id', 'employees.name as employee_name', 'requests.type', 'requests.start_date',
    //             'requests.end_date', 'requests.status', 'requests.is_seen']);

    //     if (!isAdmin()) {
    //         $requests->where('requests.employee_id', auth()->user()->id);
    //     }
    //     return Inertia::render('Request/Requests', [
    //         'requests' => $requests->orderBy('requests.status')
    //             ->paginate(config('constants.data.pagination_count')),
    //     ]);
    // }
    public function index()
    {
        $requests = \App\Models\Request::query()
            ->join('employees', 'requests.employee_id', '=', 'employees.id')
            ->leftJoin('leave_requests', 'leave_requests.request_id', '=', 'requests.id')
            ->select([
                'requests.id',
                'employees.name as employee_name',
                'requests.type',
                'requests.status',
                'requests.is_seen',

                // unified date handling
                'leave_requests.start_date',
                'leave_requests.end_date',
                'leave_requests.half_leave_date',
                'leave_requests.remote_work_date',
            ]);

        if (!isAdmin()) {
            $requests->where('requests.employee_id', auth()->user()->id);
        }

        return Inertia::render('Request/Requests', [
            'requests' => $requests
                ->orderByRaw("
                    CASE requests.status
                        WHEN 0 THEN 1
                        WHEN 1 THEN 2
                        WHEN 2 THEN 3
                        ELSE 4
                    END
                ")
                ->orderBy('requests.id', 'desc')
                ->paginate(config('constants.data.pagination_count'))
                ->through(function ($row) {

                    return [
                        'id'            => $row->id,
                        'employee_name' => $row->employee_name,
                        'type'          => $row->type,
                        'status'        => $row->status,
                        'is_seen'       => $row->is_seen,

                        // final normalized fields Vue expects
                        'start_date' => $row->start_date
                            ?? $row->half_leave_date
                            ?? $row->remote_work_date
                            ?? null,

                        'end_date'   => $row->end_date
                            ?? $row->half_leave_date
                            ?? null,
                    ];
                }),
        ]);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('Request/RequestCreate', [
            'types' => ['Complaint', 'Payment', 'Leave', 'Remote Work', 'Other'],
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $req = $this->validationServices->validateRequestCreationDetails($request);
        return $this->requestServices->createRequest($req, $request);
    }


    public function show(string $id)
    {

        $request = \App\Models\Request::with([
            'employee',
            'leaveRequest'
        ])->findOrFail($id);

        authenticateIfNotAdmin(auth()->user()->id, $request->employee_id);

        if (auth()->user()->id == $request->employee_id && $request->status !== 'Pending') {
            $request->update(['is_seen' => true]);
        }

        return Inertia::render('Request/RequestView', [
            'request' => [
                'id'             => $request->id,
                'type'           => $request->type,
                'message'        => $request->message,
                'status'         => $request->status,
                'admin_response' => $request->admin_response,
                'created_at'     => $request->created_at->format('Y-m-d'),

                'employee' => [
                    'id'   => $request->employee->id,
                    'name' => $request->employee->name,
                ],

                // LEAVE or REMOTE data (normalized)
                'leave' => $request->leaveRequest ? [
                    'leave_type'         => $request->leaveRequest->leave_type,
                    'leave_duration'     => $request->leaveRequest->leave_duration,
                    'start_date'         => $request->leaveRequest->start_date,
                    'end_date'           => $request->leaveRequest->end_date,
                    'half_leave_date'    => $request->leaveRequest->half_leave_date,
                    'half_leave_segment' => $request->leaveRequest->half_leave_segment,
                    'remote_work_date'   => $request->leaveRequest->remote_work_date,
                ] : null,
            ],

            // You can keep this or remove it (frontend can import request_types)
            'requestTypes' => [
                'Complaint'   => 'Complaint',
                'Payment'     => 'Payment',
                'Leave'       => 'Leave',
                'Remote Work' => 'Remote Work',
                'Other'       => 'Other',
            ],
        ]);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $this->requestServices->updateRequest($request, $id);
    }
    public function adminAddLeave(Request $request, $employeeId)
    {
        abort_unless(isAdmin(), 403);

        $employee = \App\Models\Employee::findOrFail($employeeId);

        $data = $request->validate([
            // 'leave_type'      => 'required',
            // 'leave_duration'  => 'required|numeric',
            // 'start_date'      => 'nullable|date',
            // 'end_date'        => 'nullable|date',
            // 'half_leave_date' => 'nullable|date',
            // 'half_leave_segment' => 'nullable|string',


            //'type' => ['required', 'string', 'in:Complaint,Payment,Leave,Remote Work,Other'],

            // General
            // 'message' => ['nullable', 'string'],

            // Leave
            'leave_type' => ['required_if:type,Leave', 'nullable', 'in:sick,casual', 'string'],
            'leave_duration' => ['required_if:type,Leave', 'nullable', 'in:full,half', 'string'],
            'half_leave_date' => ['required_if:leave_duration,half', 'nullable', 'date'],
            'half_leave_segment' => ['nullable', 'string', 'required_if:leave_duration,half', 'in:first half,second half'],

            'start_date' => ['required_if:leave_duration,full', 'nullable', 'date'],
            'end_date' => ['required_if:leave_duration,full', 'nullable', 'date', 'after_or_equal:start_date'],

            // Remote work
            //  'remote_work_date' => ['required_if:type,Remote Work', 'nullable', 'date', 'after_or_equal:today'],
        ]);

        $this->requestServices
            ->createLeaveByAdmin($data, $employee, auth()->user());

        return back();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        \App\Models\Request::findOrFail($id)->delete();
        return to_route('requests.index');
    }
}
