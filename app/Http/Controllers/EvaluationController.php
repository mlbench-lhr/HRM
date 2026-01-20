<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Evaluation;
use App\Models\Team; // <--- Make sure to import the Team model
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class EvaluationController extends Controller
{
    /**
     * Employee evaluation page
     */
    public function evaluationForm()
    {
        $currentEmployee = Auth::user();
        $userRoles = $currentEmployee->roles->pluck('name');
        $employees = collect([]); // Default empty collection

        // LOGIC: Filter employees based on Role

        // 1. If Admin: See EVERYONE (except themselves)
        if ($userRoles->contains('admin')) {
            $employees = Employee::where('id', '!=', $currentEmployee->id)->get();
        }

        // 2. If Team Lead: See ONLY their team members
        elseif ($userRoles->contains('team lead')) {
            // Find the team this user leads
            $myTeam = Team::where('team_lead_id', $currentEmployee->id)->first();

            if ($myTeam) {
                // Fetch employees belonging to this team
                $employees = Employee::where('team_id', $myTeam->id)->get();
            }
        }

        // Check monthly restriction for the fetched employees
        foreach ($employees as $emp) {
            $emp->alreadyEvaluated = Evaluation::where('evaluator_id', $currentEmployee->id)
                ->where('employee_id', $emp->id)
                ->whereMonth('created_at', now()->month)
                ->whereYear('created_at', now()->year)
                ->exists();
        }

        return Inertia::render('Evaluation/EvaluationPage', [
            'employees' => $employees,
            'currentUser' => $currentEmployee,
        ]);
    }

    public function show($id)
    {
        $evaluation = Evaluation::with(['employee', 'evaluator'])->findOrFail($id);

        return Inertia::render('Evaluation/Show', [
            'evaluation' => $evaluation
        ]);
    }

    /**
     * Submit evaluation
     */
    public function store(Request $request)
    {
        /** @var \App\Models\Employee $evaluator */
        $evaluator = Auth::user();

        // VALIDATION: Ensure the employee actually belongs to the team lead (Security Check)
        $request->validate([
            'employee_id' => [
                'required',
                'exists:employees,id',
                function ($attribute, $value, $fail) use ($evaluator) {
                    // If Admin, skip check
                    if ($evaluator->hasRole('admin')) return;

                    // If Team Lead, check if target user is in their team
                    if ($evaluator->hasRole('team lead')) {
                        $targetEmployee = Employee::find($value);
                        $myTeam = Team::where('team_lead_id', $evaluator->id)->first();

                        if (!$myTeam || $targetEmployee->team_id !== $myTeam->id) {
                            $fail('You are not authorized to evaluate this employee.');
                        }
                    }
                },
            ],
            'work_done' => 'nullable|integer|min:1|max:5',
            'quality_of_work' => 'nullable|integer|min:1|max:5',
            'timeliness' => 'nullable|integer|min:1|max:5',
            'reliability' => 'nullable|integer|min:1|max:5',
            'communication_skills' => 'nullable|integer|min:1|max:5',
            'daily_status' => 'nullable|integer|min:1|max:5',
            'problem_solving' => 'nullable|integer|min:1|max:5',
            'ownership' => 'nullable|integer|min:1|max:5',
            'team_collaboration' => 'nullable|integer|min:1|max:5',
            'adaptability' => 'nullable|integer|min:1|max:5',
            'client_handling' => 'nullable|integer|min:1|max:5',
            'learning_skill' => 'nullable|integer|min:1|max:5',
            'attendance' => 'nullable|integer|min:1|max:5',
            'final_comments' => 'nullable|string',
            'strong_points' => 'nullable|string',
            'weak_points' => 'nullable|string',
        ]);

        // 1. Get the Role
        $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';

        // 2. Get the Position
        try {
            $positionModel = $evaluator->employeePositions()
                ->whereNull('end_date')
                ->with('position')
                ->first();

            $positionName = $positionModel ? $positionModel->position->name : 'General';
        } catch (\Exception $e) {
            $positionName = 'Staff';
        }

        // Check monthly restriction
        $alreadyEvaluated = Evaluation::where('evaluator_id', $evaluator->id)
            ->where('employee_id', $request->employee_id)
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->exists();

        if ($alreadyEvaluated) {
            return back()->withErrors(['employee_id' => __('You have already evaluated this employee this month.')]);
        }

        // Prepare Data
        $data = $request->all();
        $data['evaluator_id'] = $evaluator->id;
        $data['evaluator_name'] = $evaluator->name;
        $data['evaluator_designation'] = ucfirst($roleName) . ' | ' . $positionName;

        Evaluation::create($data);

        return back()->with('success', __('Evaluation submitted successfully.'));
    }

    /**
     * Admin view
     */
    public function adminIndex()
    {
        $evaluations = Evaluation::with(['employee', 'evaluator'])
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Evaluation/AdminEvaluationPage', [
            'evaluations' => $evaluations
        ]);
    }
}
