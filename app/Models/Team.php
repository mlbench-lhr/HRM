<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Team extends Model
{
    use HasFactory;

    // 1. Allow these columns to be filled by the Controller
    protected $fillable = [
        'name',
        'team_lead_id',
    ];

    // 2. Relationship: A Team belongs to one Leader
    public function leader()
    {
        // 'team_lead_id' is the column in the 'teams' table
        return $this->belongsTo(Employee::class, 'team_lead_id');
    }

    // 3. Relationship: A Team has many Members
    public function members()
    {
        // 'team_id' is the column in the 'users' (or employees) table
        return $this->hasMany(Employee::class, 'team_id');
    }
}
