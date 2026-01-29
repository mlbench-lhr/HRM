<?php

namespace App\Http\Controllers;

use App\Models\Interview;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class InterviewController extends Controller
{
    /**
     * Display a listing of the resource.
     * Only Admins can see the list.
     */
    public function index()
    {
        /** @var \App\Models\Employee $user */
        $user = Auth::user();

        // 1. SAFE ROLE CHECK using Pluck
        $userRoles = $user->roles->pluck('name');

        if (!$userRoles->contains('admin')) {
            abort(403, 'Unauthorized. Only Admins can view interview records.');
        }

        // Fetch interviews with pagination
        $interviews = Interview::orderBy('created_at', 'desc')->paginate(10);

        return Inertia::render('Interviews/Index', [
            'interviews' => $interviews
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        /** @var \App\Models\Employee $user */
        $user = Auth::user();
        $userRoles = $user->roles->pluck('name');

        // Allow ONLY Admin and Team Lead
        if (!$userRoles->contains('admin') && !$userRoles->contains('team lead')) {
            abort(403, 'Unauthorized. Only Team Leads and Admins can conduct interviews.');
        }

        return Inertia::render('Interviews/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        /** @var \App\Models\Employee $user */
        $user = Auth::user();

        // 1. SAFE ROLE CHECK
        $userRoles = $user->roles->pluck('name');
        $isAdmin = $userRoles->contains('admin');

        // 2. Validation
        // These 'required' rules ensure backend enforcement of your frontend form.
        $rules = [
            'candidate_name' => 'required|string|max:255',
            'position' => 'required|string|max:255',
            'interview_date' => 'required|date',
            // Ratings MUST be 1-5
            'skill_depth' => 'required|integer|min:1|max:5',
            'problem_solving' => 'required|integer|min:1|max:5',
            'practical_experience' => 'required|integer|min:1|max:5',
            'communication_clarity' => 'required|integer|min:1|max:5',
            'ownership_initiative' => 'required|integer|min:1|max:5',

            'final_comment' => 'required|string',
            'is_recommended' => 'required|boolean',
        ];

        // If Admin, name is required manually.
        if ($isAdmin) {
            $rules['interviewer_name'] = 'required|string|max:255';
        }

        $validated = $request->validate($rules);

        // 3. Prepare Data
        if ($isAdmin) {
            $validated['interviewer_name'] = $request->interviewer_name;
        } else {
            // Force Team Lead's name
            $validated['interviewer_name'] = $user->name;
        }
        $validated['interviewer_id'] = $user->id;

        // 4. CALCULATE TOTAL SCORE (Obtained Marks)
        $validated['total_score'] =
            $request->skill_depth +
            $request->problem_solving +
            $request->practical_experience +
            $request->communication_clarity +
            $request->ownership_initiative;

        Interview::create($validated);

        // Redirect Admin to Index, Team Lead to Dashboard
        if ($isAdmin) {
            return redirect()->route('interviews.index')->with('success', 'Interview saved successfully.');
        }

        return redirect()->route('dashboard.index')->with('success', 'Interview saved successfully.');
    }
}
