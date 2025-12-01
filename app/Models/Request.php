<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;
use App\Models\LeaveRequest;

class Request extends Model
{
    use LogsActivity;
    protected $guarded = [];
    protected $appends = ['raw_status'];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults();
    }

    public function employee(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }
    public function leaveRequest()
    {
        return $this->hasOne(LeaveRequest::class);
    }
    public function getRawStatusAttribute()
    {
        return $this->attributes['status']; // return the DB value directly
    }
    protected function status(): Attribute
    {
        return Attribute::make(
            get: fn (int $value) => match ($value) {
                0 => 'Pending',
                1 => 'Approved',
                2 => 'Rejected',
            },
        );
    }
}
