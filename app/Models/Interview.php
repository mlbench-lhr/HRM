<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Interview extends Model
{
    use HasFactory;

    protected $fillable = [
        'interviewer_id',
        'interviewer_name',
        'candidate_name',
        'position',
        'interview_date',
        'skill_depth',
        'problem_solving',
        'practical_experience',
        'communication_clarity',
        'ownership_initiative',
        'total_score', // <--- Added this
        'final_comment',
        'is_recommended',
    ];

    protected $casts = [
        'interview_date' => 'date',
        'is_recommended' => 'boolean',
    ];
}
