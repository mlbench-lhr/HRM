<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmployeeLeaveAllocation extends Model
{
    use HasFactory;
    protected $fillable = [
        'employee_id',
        'year',
        'total_leaves',
        'casual_leaves',
        'sick_leaves',
        'unpaid_leaves',
        'remaining_leaves',
        'used_leaves'
    ];
    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
