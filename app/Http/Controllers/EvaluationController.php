<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Evaluation;
use App\Models\Team;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class EvaluationController extends Controller
{
    public function evaluationForm()
    {
        $currentEmployee = Auth::user();
        $userRoles = $currentEmployee->roles->pluck('name');
        $employees = collect([]);

        if ($userRoles->contains('admin')) {
            $employees = Employee::where('id', '!=', $currentEmployee->id)->get();
        } elseif ($userRoles->contains('team lead')) {
            $myTeam = Team::where('team_lead_id', $currentEmployee->id)->first();
            if ($myTeam) {
                $employees = Employee::where('team_id', $myTeam->id)->get();
            }
        }

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

    public function store(Request $request)
    {
        /** @var \App\Models\Employee $evaluator */
        $evaluator = Auth::user();


        // 1. VALIDATION: All fields set to REQUIRED
        // $request->validate([
        //     'employee_id' => [
        //         'required',
        //         'exists:employees,id',
        //         function ($attribute, $value, $fail) use ($evaluator) {
        //             if ($evaluator->hasRole('admin')) return;
        //             if ($evaluator->hasRole('team lead')) {
        //                 $target = Employee::find($value);
        //                 $team = Team::where('team_lead_id', $evaluator->id)->first();
        //                 // --- 🛑 PASTE THIS BLOCK TO TEST ---
        //                 if ($team) {
        //                     dd([
        //                         'Employee Team ID' => $target->team_id,
        //                         'Type of Employee Team ID' => gettype($target->team_id),

        //                         'Lead Team ID' => $team->id,
        //                         'Type of Lead Team ID' => gettype($team->id),

        //                         'Do IDs Match? (Strict ===)' => $target->team_id === $team->id,
        //                         'Do IDs Match? (Loose ==)' => $target->team_id == $team->id,
        //                     ]);
        //                 }
        //                 // --- END DEBUG BLOCK ---
        //                 if (!$team || $target->team_id !== $team->id) $fail('Unauthorized.');
        //             }
        //         },
        //     ],
        $request->validate([
            'employee_id' => [
                'required',
                'exists:employees,id',
                function ($attribute, $value, $fail) use ($evaluator) {
                    // Admin bypass
                    if ($evaluator->hasRole('admin')) return;

                    if ($evaluator->hasRole('team lead')) {
                        $target = Employee::find($value);

                        // 1. Get the Team THIS employee belongs to
                        $targetTeam = Team::find($target->team_id);

                        // 2. Check if the team exists AND if the current user is the leader
                        // We use '!=' (Loose comparison) to solve the String vs Integer issue
                        if (!$targetTeam || $targetTeam->team_lead_id != $evaluator->id) {
                            $fail('Unauthorized: You are not the Team Lead for this employee.');
                        }
                    }
                },
            ],
            'work_done' => 'required|integer|min:1|max:5',
            'quality_of_work' => 'required|integer|min:1|max:5',
            'timeliness' => 'required|integer|min:1|max:5',
            'reliability' => 'required|integer|min:1|max:5',
            'communication_skills' => 'required|integer|min:1|max:5',
            'daily_status' => 'required|integer|min:1|max:5',
            'problem_solving' => 'required|integer|min:1|max:5',
            'ownership' => 'required|integer|min:1|max:5',
            'team_collaboration' => 'required|integer|min:1|max:5',
            'adaptability' => 'required|integer|min:1|max:5',
            'client_handling' => 'required|integer|min:1|max:5',
            'learning_skill' => 'required|integer|min:1|max:5',
            'attendance' => 'required|integer|min:1|max:5',

            'final_comments' => 'required|string|max:1000',
            'strong_points' => 'required|string|max:1000',
            'weak_points' => 'required|string|max:1000',
        ]);

        $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';

        // Get Position logic...
        try {
            $pos = $evaluator->employeePositions()->whereNull('end_date')->with('position')->first();
            $positionName = $pos ? $pos->position->name : 'General';
        } catch (\Exception $e) {
            $positionName = 'Staff';
        }

        // Check already evaluated
        $exists = Evaluation::where('evaluator_id', $evaluator->id)
            ->where('employee_id', $request->employee_id)
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)->exists();

        if ($exists) return back()->withErrors(['employee_id' => __('Already evaluated this month.')]);

        // 2. PREPARE DATA & CALCULATE AVERAGE
        $data = $request->all();
        $data['evaluator_id'] = $evaluator->id;
        $data['evaluator_name'] = $evaluator->name;
        $data['evaluator_designation'] = ucfirst($roleName) . ' | ' . $positionName;

        // Sum up the 13 required fields
        $sum = $request->work_done + $request->quality_of_work + $request->timeliness +
            $request->reliability + $request->communication_skills + $request->daily_status +
            $request->problem_solving + $request->ownership + $request->team_collaboration +
            $request->adaptability + $request->client_handling + $request->learning_skill +
            $request->attendance;

        // Calculate Average (Round to 1 decimal)
        $data['avg_rating'] = round($sum / 13, 1);

        Evaluation::create($data);

        return back()->with('success', __('Evaluation submitted successfully.'));
    }

    public function myEvaluations(Request $request)
    {
        $user = Auth::user();

        $query = Evaluation::where('employee_id', $user->id)->with('evaluator');

        if ($request->filled('month')) {
            $date = Carbon::parse($request->month);
            $query->whereYear('created_at', $date->year)
                ->whereMonth('created_at', $date->month);
        }

        // 3. PAGINATION (10 per page)
        // No manual calculation here. We read 'avg_rating' from DB.
        $evaluations = $query->orderBy('created_at', 'desc')->paginate(10);

        return Inertia::render('Evaluation/MyEvaluations', [
            'evaluations' => $evaluations,
            'filters' => $request->only(['month']),
        ]);
    }

    public function adminIndex(Request $request)
    {
        // $evaluations = Evaluation::with(['employee', 'evaluator'])
        //     ->orderBy('created_at', 'desc')
        //     ->paginate(15);

        // return Inertia::render('Evaluation/AdminEvaluationPage', [
        //     'evaluations' => $evaluations
        // ]);

        $query = Evaluation::with(['employee', 'evaluator']);

        // 2. Apply Month Filter
        if ($request->filled('month')) {
            $date = Carbon::parse($request->month);
            $query->whereYear('created_at', $date->year)
                ->whereMonth('created_at', $date->month);
        }


        $evaluations = $query->orderBy('created_at', 'desc')->paginate(15);

        return Inertia::render('Evaluation/AdminEvaluationPage', [
            'evaluations' => $evaluations,
            'filters' => $request->only(['month']),
        ]);
    }
}
