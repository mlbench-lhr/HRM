<?php

namespace App\Http\Controllers;

use App\Models\ArchivedEmployee;
use App\Models\Branch;
use App\Models\Department;
use App\Models\Employee;
use App\Models\Position;
use App\Models\Shift;
use App\Services\EmployeeServices;
use App\Services\ValidationServices;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Inertia\Response;

class EmployeeController extends Controller
{
    protected EmployeeServices $employeeServices;
    protected ValidationServices $validationServices;
    public function __construct()
    {
        $this->employeeServices = new EmployeeServices;
        $this->validationServices = new ValidationServices;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $sortDir = 'asc';
        if ($request->has('sort')) {
            $request->validate([
                'sort' => 'in:id,name',
                'sort_dir' => 'required|boolean',
            ]);
            $sortDir = $request->sort_dir ? 'asc' : 'desc';
        }

        return Inertia::render('Employee/Employees', [
            'employees' => Employee::when($request->term, function ($query, $term) {
                $query->where('normalized_name', 'LIKE', '%' . normalizeArabic($term) . '%')
                    ->orWhere('email', 'LIKE', '%' . $term . '%')
                    ->orWhere('id', 'LIKE', '%' . $term . '%')
                    ->orWhere('phone', 'LIKE', '%' . $term . '%')
                    ->orWhere('national_id', 'LIKE', '%' . $term . '%');
            })->orderBy($request->sort ?? 'id', $sortDir)->select(['id', 'name', 'email', 'phone', 'national_id'])
                ->paginate(config('constants.data.pagination_count')),
        ]);
    }

    public function archivedIndex(Request $request)
    {
        $sortDir = 'asc';
        if ($request->has('sort')) {
            $request->validate([
                'sort' => 'in:id,name',
                'sort_dir' => 'required|boolean',
            ]);
            $sortDir = $request->sort_dir ? 'asc' : 'desc';
        }

        return Inertia::render('Employee/ArchievedEmployees', [
            'employees' => ArchivedEmployee::when($request->term, function ($query, $term) {
                $query->where('name', 'LIKE', '%' . $term . '%')
                    ->orWhere('email', 'LIKE', '%' . $term . '%')
                    ->orWhere('id', 'LIKE', '%' . $term . '%')
                    ->orWhere('phone', 'LIKE', '%' . $term . '%')
                    ->orWhere('national_id', 'LIKE', '%' . $term . '%');
            })->orderBy($request->sort ?? 'released_on', $sortDir)
                ->select(['id', 'name', 'email', 'phone', 'national_id', 'hired_on', 'released_on'])
                ->paginate(config('constants.data.pagination_count')),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): Response
    {
        return Inertia::render('Employee/EmployeeCreate', [
            'departments' => Department::select(['id', 'name'])->get(),
            'branches' => Branch::select(['id', 'name'])->get(),
            'positions' => Position::select(['id', 'name'])->get(),
            'roles' => DB::select('SELECT name FROM roles'),
            'shifts' => Shift::get(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validate Input Firsts
        $res = $this->validationServices->validateEmployeeCreationDetails($request);
        // Employee Registration
        return $this->employeeServices->createEmployee($res);
    }

    // A function without parameters
    public function showMyProfile()
    {
        return $this->show(auth()->user()->id);
    }

    // public function show($id)
    // {
    //     $employee = Employee::with([
    //         'leaveAllocations',
    //         'leaveRequests',             // this loads leave_request rows
    //         'leaveRequests.request',     // load parent request row
    //         'requests',                  // ALL requests (optional)
    //         'employeePositions.position',
    //         'employeeShifts.shift',
    //         'salaries',
    //         'roles',
    //         'manages',
    //         'branch',
    //         'department'
    //     ])->findOrFail($id);

    //     $allocation = $employee->leaveAllocations->last();

    //     if ($allocation) {

    //         // 1. compute total approved usage
    //         $approved_used = $employee->leaveRequests
    //             ->filter(fn($r) => $r->request && $r->request->status === 'Approved')
    //             ->sum(fn($item) => (float) $item->leave_duration);

    //         // 2. compute remaining and unpaid totals
    //         $total = $allocation->total_leaves;

    //         $remaining = $total - $approved_used;

    //         if ($remaining < 0) {
    //             $unpaid_total = abs($remaining);
    //             $remaining = 0;
    //         } else {
    //             $unpaid_total = 0;
    //         }

    //         // 3. update DB (fixes negative values permanently)
    //         $allocation->update([
    //             'used_leaves'      => $approved_used,
    //             'remaining_leaves' => $remaining,
    //             'unpaid_leaves'    => $unpaid_total,
    //         ]);

    //         // 4. compute per-request remaining_after
    //         $employee->leaveRequests->each(function ($leave) use ($employee, $allocation, $total) {

    //             if (!$leave->request || $leave->request->status !== 'Approved') {
    //                 $leave->remaining_after = $allocation->remaining_leaves;
    //                 $leave->unpaid_leave = 0;
    //                 return;
    //             }

    //             $used_before = $employee->leaveRequests
    //                 ->filter(fn($r) => $r->request && $r->request->status === 'Approved')
    //                 ->takeUntil($leave)
    //                 ->sum(fn($item) => (float) $item->leave_duration);

    //             $used_total = $used_before + (float) $leave->leave_duration;

    //             $remaining_after = $total - $used_total;

    //             if ($remaining_after < 0) {
    //                 $leave->unpaid_leave = abs($remaining_after);
    //                 $leave->remaining_after = 0;
    //             } else {
    //                 $leave->unpaid_leave = 0;
    //                 $leave->remaining_after = $remaining_after;
    //             }
    //         });
    //     }


    //     return Inertia::render('Employee/EmployeeView', [
    //         'employee' => $employee,
    //     ]);
    // }
    public function show($id)
    {
        $employee = Employee::with([

            'leaveAllocations',
            'leaveRequests.request.createdByAdmin',        // this loads leave_request rows
            'leaveRequests.request',     // load parent request row
            'requests',                  // ALL requests (optional)
            'employeePositions.position',
            'employeeShifts.shift',
            'salaries',
            'roles',
            'manages',
            'branch',
            'department'
        ])->findOrFail($id);

        // 1. Group allocations by year for easy lookup
        $allocations = $employee->leaveAllocations->keyBy('year');

        // 2. Sort ALL leave requests by date to calculate history correctly
        $sortedLeaves = $employee->leaveRequests->sortBy(function ($leave) {
            return $leave->start_date ?? $leave->half_leave_date;
        });

        // We need to keep track of "running used" for EACH year separately
        $runningUsedByYear = [];

        $sortedLeaves->each(function ($leave) use ($allocations, &$runningUsedByYear) {
            // Find the year of this specific leave
            $date = $leave->start_date ?? $leave->half_leave_date;
            $year = \Carbon\Carbon::parse($date)->year;

            // Initialize running used for this year if not exists
            if (!isset($runningUsedByYear[$year])) {
                $runningUsedByYear[$year] = 0;
            }

            $allocation = $allocations->get($year);

            // If no allocation exists for that year, we can't calculate balances
            if (!$allocation) {
                $leave->remaining_after = 0;
                $leave->unpaid_leave = 0;
                return;
            }

            if ($leave->request && $leave->request->status === 'Approved') {
                $duration = (float) $leave->leave_duration;

                // Add to the running total for THIS year
                $runningUsedByYear[$year] += $duration;

                $totalForYear = (float) $allocation->total_leaves;
                $balance = $totalForYear - $runningUsedByYear[$year];

                if ($balance < 0) {
                    $leave->remaining_after = 0;
                    $leave->unpaid_leave = abs($balance);
                } else {
                    $leave->remaining_after = $balance;
                    $leave->unpaid_leave = 0;
                }
            } else {
                // For Pending/Rejected, show current state or 0
                $leave->remaining_after = 0;
                $leave->unpaid_leave = 0;
            }
        });

        // 3. Final Step: Update the database totals for the Allocation cards
        foreach ($runningUsedByYear as $year => $totalUsed) {
            $allocation = $allocations->get($year);
            if ($allocation) {
                $remaining = max(0, $allocation->total_leaves - $totalUsed);
                $unpaid = ($totalUsed > $allocation->total_leaves) ? ($totalUsed - $allocation->total_leaves) : 0;

                $allocation->update([
                    'used_leaves' => $totalUsed,
                    'remaining_leaves' => $remaining,
                    'unpaid_leaves' => $unpaid
                ]);
            }
        }

        return Inertia::render('Employee/EmployeeView', [
            'employee' => $employee,
        ]);
    }
    public function edit(string $id)
    {
        $employee = Employee::with([
            'salaries',
            'roles',
            'employeeShifts.shift',
            'employeePositions.position',
            'leaveAllocations' => function ($query) {
                $query->where('year', date('Y'));
            }
        ])
            ->leftJoin('departments', 'employees.department_id', '=', 'departments.id')
            ->leftJoin('branches', 'employees.branch_id', '=', 'branches.id')
            ->where('employees.id', $id)
            ->select(
                'employees.id',
                'employees.name',
                'employees.phone',
                'employees.national_id',
                'employees.email',
                'employees.address',
                'employees.bank_acc_no',
                'employees.hired_on',
                'departments.name as department_name',
                'departments.id as department_id',
                'branches.id as branch_id',
                'branches.name as branch_name',
                'employees.is_remote'
            )
            ->first();

        return Inertia::render('Employee/EmployeeEdit', [
            'employee' => $employee,
            'departments' => Department::select(['id', 'name'])->get(),
            'branches' => Branch::select(['id', 'name'])->get(),
            'positions' => Position::select(['id', 'name'])->get(),
            'roles' => DB::select('SELECT name FROM roles'),
            'shifts' => Shift::get(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        // Validate Input Firsts
        $res = $this->validationServices->validateEmployeeUpdateDetails($request, $id);

        // Update Employee
        return $this->employeeServices->updateEmployee(Employee::findOrFail($id), $res);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        return $this->employeeServices->deleteEmployee($id);
    }

    public function find(Request $request)
    {
        return Inertia::render('Employee/EmployeeFind', [
            'employees' => Employee::when($request->term, function ($query, $term) {
                $query
                    ->where('name', 'LIKE', '%' . $term . '%')
                    ->orWhere('id', 'LIKE', '%' . $term . '%')
                    ->orWhere('email', 'LIKE', '%' . $term . '%')
                    ->orWhere('phone', 'LIKE', '%' . $term . '%')
                    ->orWhere('national_id', 'LIKE', '%' . $term . '%');
            })->get(),
        ]);
    }
}
