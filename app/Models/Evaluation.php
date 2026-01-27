<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evaluation extends Model
{
    protected $fillable = [
        'evaluator_id',
        'employee_id',
        'evaluator_name',
        'evaluator_designation',
        'work_done',
        'quality_of_work',
        'timeliness',
        'reliability',
        'communication_skills',
        'daily_status',
        'problem_solving',
        'ownership',
        'team_collaboration',
        'adaptability',
        'client_handling',
        'learning_skill',
        'attendance',
        'final_comments',
        'strong_points',
        'weak_points',
        'avg_rating',
    ];

    public function evaluator()
    {
        return $this->belongsTo(Employee::class, 'evaluator_id');
    }
    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }
}
