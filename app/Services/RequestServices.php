<?php

namespace App\Services;


use App\Mail\RequestStatusUpdated;
use App\Models\Employee;
use Illuminate\Support\Arr;

use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;
use App\Models\LeaveRequest;
use App\Notifications\NewRequestSubmitted;
use App\Notifications\RequestReviewed;

use App\Models\Request as EmpRequest;
use App\Models\EmployeeLeaveAllocation;

class RequestServices
{

    public function createRequest($req, $request)
    {
        // CREATE THE PARENT REQUEST MODEL
        $parent = \App\Models\Request::create([
            'type'        => $req['type'],
            'message'     => $req['message'] ?? null,
            'employee_id' => $request->user()->id,
            'status'      => 0,
        ]);

        // CREATE LEAVE ENTRY
        if ($req['type'] === 'Leave') {

            if ($req['leave_duration'] === 'half') {
                $half = Carbon::parse($req['half_leave_date']);

                LeaveRequest::create([
                    'request_id'        => $parent->id,
                    'leave_type'        => $req['leave_type'],
                    'leave_duration'    => 0.5,
                    'half_leave_date'   => $half->format('Y-m-d'),
                    'half_leave_segment' => $req['half_leave_segment'],
                ]);
            }

            if ($req['leave_duration'] === 'full') {
                $start = Carbon::parse($req['start_date']);
                $end   = Carbon::parse($req['end_date']);

                LeaveRequest::create([
                    'request_id'      => $parent->id,
                    'leave_type'      => $req['leave_type'],
                    'leave_duration'  => $start->diffInDays($end) + 1,
                    'start_date'      => $start->format('Y-m-d'),
                    'end_date'        => $end->format('Y-m-d'),
                ]);
            }
        }

        // REMOTE WORK ENTRY
        if ($req['type'] === 'Remote Work') {

            LeaveRequest::create([
                'request_id'       => $parent->id,
                'remote_work_date' => Carbon::parse($req['remote_work_date'])->format('Y-m-d'),
            ]);
        }

        // SEND NOTIFICATION TO ADMIN (super@root.com)
        $admin = Employee::where('email', 'super@root.com')->first();

        if ($admin) {
            // USE $parent → THIS IS THE REQUEST MODEL !!!
            $parent->load('employee');
            $admin->notify(new NewRequestSubmitted($parent));
        }

        return to_route('requests.index');
    }



    public function updateRequest($request, $id)
    {
        $req = $request->validate([
            'status' => ['required', 'integer', 'in:1,2'], // 1=Approved, 2=Discarded
            'admin_response' => ['nullable', 'string'],
        ]);

        $empReq = EmpRequest::with('leaveRequest', 'employee')->findOrFail($id);

        $empReq->update([
            'status'         => $req['status'],
            'admin_response' => $req['admin_response'],
        ]);
        //  Send Email to Employee informing them of the status update.
        // Mail::to($empReq->employee->email)->send(new RequestStatusUpdated($empReq));
        // ALWAYS re-fetch the request fresh from database before sending
        $fresh = EmpRequest::with('employee', 'leaveRequest')->findOrFail($id);

        if ($fresh->employee) {
            $fresh->employee->notify(new RequestReviewed($fresh));
        }
        // ONLY WHEN APPROVED AND TYPE = LEAVE
        if ($req['status'] == 1 && $empReq->type === 'Leave') {

            $leave = $empReq->leaveRequest;
            if (!$leave) return; // safety check

            $used = (float) $leave->leave_duration;

            $allocation = EmployeeLeaveAllocation::where('employee_id', $empReq->employee_id)->first();
            if (!$allocation) return; // safety check


            // APPLY USED LEAVES
            $allocation->used_leaves += $used;


            // CALCULATE REMAINING + UNPAID
            $remaining = $allocation->total_leaves - $allocation->used_leaves;

            if ($remaining < 0) {
                // excess goes to unpaid
                $allocation->unpaid_leaves = abs($remaining);
                $allocation->remaining_leaves = 0;
            } else {
                $allocation->remaining_leaves = $remaining;
                $allocation->unpaid_leaves = 0;
            }

            $allocation->save();
        }
    }

}
