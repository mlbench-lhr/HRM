<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PeerFeedback extends Model
{
    use HasFactory;

    protected $table = 'peer_feedback_evaluations';

    protected $fillable = [
        'evaluator_id',
        'employee_id',

        'evaluator_name',
        'evaluator_designation',

        'collaboration',
        'supportiveness',
        'respect',
        'communication',
        'responsiveness',
        'openness_to_feedback',
        'attitude',
        'conflict_handling',
        'dependability',
        'accountability',
        'professionalism',
        'team_impact',
        'overall_team_member',
        'work_again',

        'avg_rating',
        'peer_comments',

        'year',
        'month',
    ];

    protected $casts = [
        'avg_rating' => 'float',
        'year' => 'integer',
        'month' => 'integer',
    ];

    /**
     * Employee being evaluated
     */
    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }

    /**
     * Evaluator (peer)
     */
    public function evaluator()
    {
        return $this->belongsTo(Employee::class, 'evaluator_id');
    }
}
