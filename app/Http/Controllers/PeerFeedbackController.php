<?php

namespace App\Http\Controllers;

use App\Models\PeerFeedback;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class PeerFeedbackController extends Controller
{
    // public function create()
    // {
    //     /** @var \App\Models\Employee $evaluator */
    //     $evaluator = Auth::user();

    //     // 1. Get Role and Position Logic (consistent with your EvaluationController)
    //     $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';

    //     try {
    //         $positionModel = $evaluator->employeePositions()
    //             ->whereNull('end_date')
    //             ->with('position')
    //             ->first();
    //         $positionName = $positionModel ? $positionModel->position->name : 'General';
    //     } catch (\Exception $e) {
    //         $positionName = 'Staff';
    //     }

    //     return Inertia::render('Peer Feedback Questionnaire/PeerFeedbackQuestionnaire', [
    //         'employees' => Employee::where('id', '!=', $evaluator->id)
    //             ->select('id', 'name')
    //             ->orderBy('name')
    //             ->get(),
    //         'currentUser' => [
    //             'id' => $evaluator->id,
    //             'name' => $evaluator->name,
    //             'designation' => ucfirst($roleName) . ' | ' . $positionName,
    //         ],
    //     ]);
    // }
    public function create()
    {
        /** @var \App\Models\Employee $evaluator */
        $evaluator = Auth::user(); // Using Auth::user() with the hint above stops the red lines

        // 1. Get Role & Position (Formatted like your EvaluationController)
        $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';
        try {
            $positionModel = $evaluator->employeePositions()->whereNull('end_date')->with('position')->first();
            $positionName = $positionModel ? $positionModel->position->name : 'General';
        } catch (\Exception $e) {
            $positionName = 'Staff';
        }

        $designation = ucfirst($roleName) . ' | ' . $positionName;

        // 2. Get Employees and check monthly restriction
        $employees = Employee::where('id', '!=', $evaluator->id)
            ->select('id', 'name')
            ->orderBy('name')
            ->get()
            ->map(function ($emp) use ($evaluator) {
                $emp->alreadyEvaluated = PeerFeedback::where('evaluator_id', $evaluator->id)
                    ->where('employee_id', $emp->id)
                    ->where('month', now()->month)
                    ->where('year', now()->year)
                    ->exists();
                return $emp;
            });

        return Inertia::render('Peer Feedback Questionnaire/PeerFeedbackQuestionnaire', [
            'employees' => $employees,
            'currentUser' => [
                'id' => $evaluator->id,
                'name' => $evaluator->name,
                'designation' => $designation,
            ],
        ]);
    }
    public function store(Request $request)
    {
        /** @var \App\Models\Employee $evaluator */
        $evaluator = Auth::user(); // Using Auth::user() with the hint above stops the red lines

        // Validate exactly what Vue is sending
        $validated = $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'ratings' => 'required|array',
            'ratings.collaboration' => 'required|integer|min:1|max:5',
            'ratings.supportiveness' => 'required|integer|min:1|max:5',
            'ratings.respect' => 'required|integer|min:1|max:5',
            'ratings.communication' => 'required|integer|min:1|max:5',
            'ratings.responsiveness' => 'required|integer|min:1|max:5',
            'ratings.openness_to_feedback' => 'required|integer|min:1|max:5',
            'ratings.attitude' => 'required|integer|min:1|max:5',
            'ratings.conflict_handling' => 'required|integer|min:1|max:5',
            'ratings.dependability' => 'required|integer|min:1|max:5',
            'ratings.accountability' => 'required|integer|min:1|max:5',
            'ratings.professionalism' => 'required|integer|min:1|max:5',
            'ratings.team_impact' => 'required|integer|min:1|max:5',
            'ratings.overall_team_member' => 'required|integer|min:1|max:5',
            'ratings.work_again' => 'required|integer|min:1|max:5',
            'peer_comments' => 'nullable|string',
        ]);

        $year = now()->year;
        $month = now()->month;

        // Monthly restriction check
        $alreadySubmitted = PeerFeedback::where('evaluator_id', $evaluator->id)
            ->where('employee_id', $validated['employee_id'])
            ->where('year', $year)
            ->where('month', $month)
            ->exists();

        if ($alreadySubmitted) {
            return back()->withErrors([
                'employee_id' => __('You have already evaluated this employee this month.')
            ]);
        }

        // Fetch Role/Position for the record snapshot
        $roleName = $evaluator->getRoleNames()->first() ?? 'Employee';
        try {
            $positionModel = $evaluator->employeePositions()->whereNull('end_date')->with('position')->first();
            $positionName = $positionModel ? $positionModel->position->name : 'General';
        } catch (\Exception $e) {
            $positionName = 'Null';
        }

        // Prepare the data by flattening the ratings array
        $avgRating = collect($validated['ratings'])->avg();

        $saveData = array_merge($validated['ratings'], [
            'evaluator_id' => $evaluator->id,
            'employee_id' => $validated['employee_id'],
            'evaluator_name' => $evaluator->name,
            'evaluator_designation' => ucfirst($roleName) . ' | ' . $positionName,
            'avg_rating' => round($avgRating, 2),
            'peer_comments' => $validated['peer_comments'],
            'year' => $year,
            'month' => $month,
        ]);

        PeerFeedback::create($saveData);

        return back()->with('success', __('Peer evaluation submitted successfully.'));
    }
    // public function adminIndex()
    // {
    //     $evaluations = PeerFeedback::with(['employee:id,name', 'evaluator:id,name'])
    //         ->latest()
    //         ->paginate(10);

    //     return Inertia::render('Peer Feedback Questionnaire/AdminFeedbackpage', [
    //         'evaluations' => $evaluations
    //     ]);
    // }
    public function index()
    {
        $peerFeedbacks = PeerFeedback::with(['employee', 'evaluator'])
            ->latest()
            ->paginate(15); // pagination

        return Inertia::render('Peer Feedback Questionnaire/AdminFeedbackpage', [
            'peerFeedbacks' => $peerFeedbacks
        ]);
    }
    public function show($id)
    {
        $peerFeedback = PeerFeedback::with(['employee', 'evaluator'])->findOrFail($id);

        return Inertia::render('Peer Feedback Questionnaire/PeerFeedbackShow', [
            'peerFeedback' => $peerFeedback,
        ]);
    }
}
