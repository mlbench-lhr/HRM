<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Evaluation;
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
        // In your case, Auth::user() returns an Employee model instance
        $currentEmployee = Auth::user();

        // Get all employees except the one currently logged in
        $employees = Employee::where('id', '!=', $currentEmployee->id)->get();

        // Check monthly restriction for each employee
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
        // Fetch the evaluation with relationships
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

        $validated = $request->validate([
            'employee_id' => 'required|exists:employees,id',
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

        // 1. Get the Role (using Spatie HasRoles)
        // This gets the first role assigned to the employee (e.g., 'admin', 'staff')
        $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';

        // 2. Get the Position (using your model's activePosition logic)
        // Based on your model, activePosition() returns a collection from a custom relationship
        try {
            $positionModel = $evaluator->employeePositions()
                ->whereNull('end_date')
                ->with('position') // Assuming EmployeePosition belongsTo Position
                ->first();

            $positionName = $positionModel ? $positionModel->position->name : 'General';
        } catch (\Exception $e) {
            $positionName = 'Staff';
        }

        // Check monthly restriction
        $alreadyEvaluated = Evaluation::where('evaluator_id', $evaluator->id)
            ->where('employee_id', $validated['employee_id'])
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->exists();

        if ($alreadyEvaluated) {
            return back()->withErrors(['employee_id' => __('You have already evaluated this employee this month.')]);
        }

        $validated['evaluator_id'] = $evaluator->id;
        $validated['evaluator_name'] = $evaluator->name;
        $validated['evaluator_designation'] = ucfirst($roleName) . ' | ' . $positionName;

        Evaluation::create($validated);

        return back()->with('success', __('Evaluation submitted successfully.'));
    }

    /**
     * Admin view
     */
    public function adminIndex()
    {
        // Ensure Evaluation model has 'employee' and 'evaluator' relationships
        // pointing to the Employee model
        $evaluations = Evaluation::with(['employee', 'evaluator'])
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Evaluation/AdminEvaluationPage', [
            'evaluations' => $evaluations
        ]);
    }
}
