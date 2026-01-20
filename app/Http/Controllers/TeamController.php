<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Team;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TeamController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // 1. Start the query
        $query = Team::query()->with(['leader']); // Eager load leader to avoid N+1 issues

        // 2. Handle Search (if 'term' is present)
        if ($request->has('term') && $request->term) {
            $query->where('name', 'LIKE', '%' . $request->term . '%');
        }

        // 3. Handle Sorting
        if ($request->has('sort') && $request->sort) {
            $query->orderBy($request->sort, $request->sort_dir ? 'desc' : 'asc');
        } else {
            $query->orderBy('id', 'desc');
        }

        // 4. Pagination
        $teams = $query->withCount('members')->paginate(10)->appends($request->query());

        return Inertia::render('Team/Team', [
            'teams' => $teams,
            'filters' => $request->only(['term', 'sort', 'sort_dir'])
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // Get Users with 'team lead' role
        $teamLeads = Employee::role('team lead')->get();

        // Get Employees who are NOT in a team yet
        $employees = Employee::role(['employee', 'probation'])
            ->whereNull('team_id')
            ->get();

        return Inertia::render('Team/TeamCreate', [
            'teamLeads' => $teamLeads,
            'employees' => $employees
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'team_lead_id' => 'required|exists:employees,id',
            'members' => 'array'
        ]);

        // 1. Create the Team
        $team = Team::create([
            'name' => $request->name,
            'team_lead_id' => $request->team_lead_id
        ]);

        // 2. Assign members (Update their team_id)
        if ($request->has('members')) {
            Employee::whereIn('id', $request->members)->update(['team_id' => $team->id]);
        }

        return redirect()->route('teams.index')
            ->with('success', 'Team created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(Team $team)
    {
        // Load the leader and members for the View page
        $team->load(['leader', 'members']);

        return Inertia::render('Team/TeamView', [
            'team' => $team
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Team $team)
    {
        // 1. Get all Team Leads
        $teamLeads = Employee::role('team lead')->get();

        // 2. Get Employees: We need those who have NO team OR belong to THIS team
        // If we don't include "where team_id = current", the current members will disappear from the list
        $employees = Employee::role(['employee', 'probation'])
            ->where(function ($query) use ($team) {
                $query->whereNull('team_id')
                    ->orWhere('team_id', $team->id);
            })
            ->get();

        // 3. Get IDs of current members to pre-fill the form
        $currentMembers = $team->members()->pluck('id');

        return Inertia::render('Team/TeamEdit', [
            'team' => $team,
            'teamLeads' => $teamLeads,
            'employees' => $employees,
            'currentMembers' => $currentMembers
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Team $team)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'team_lead_id' => 'required|exists:employees,id',
            'members' => 'array'
        ]);

        // 1. Update Team Details
        $team->update([
            'name' => $request->name,
            'team_lead_id' => $request->team_lead_id
        ]);

        // 2. Sync Members
        // Step A: Remove everyone from this team (Reset them)
        Employee::where('team_id', $team->id)->update(['team_id' => null]);

        // Step B: Add the selected ones back
        if ($request->has('members') && count($request->members) > 0) {
            Employee::whereIn('id', $request->members)->update(['team_id' => $team->id]);
        }

        return redirect()->route('teams.index')
            ->with('success', 'Team updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Team $team)
    {
        // Because we set 'onDelete set null' in migration,
        // employees will automatically be freed when team is deleted.
        $team->delete();

        return redirect()->route('teams.index')
            ->with('success', 'Team deleted successfully');
    }
}
