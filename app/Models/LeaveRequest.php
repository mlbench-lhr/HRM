<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;



class LeaveRequest extends Model
{
    use HasFactory;
    protected $fillable = [
        'request_id',
        'leave_type',
        'leave_duration',
        'half_leave_date',
        'half_leave_segment',
        'start_date',
        'end_date',
        'remote_work_date'
    ];

    public function request()
    {
        return $this->belongsTo(Request::class, 'request_id', 'id');
    }
}
