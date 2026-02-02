<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class Deduction extends Model
{
    use HasFactory, LogsActivity;
    protected $guarded = [];
    // protected $fillable = [
    //     'payroll_id',
    //     'due_date',
    //     'income_tax',
    //     'social_security_contributions',
    //     'health_insurance',
    //     'retirement_plan',
    //     'benefits',
    //     'union_fees',
    //     'undertime',
    //     'negative_hour_rate',
    //     'unpaid_absence_deduction',
    //     'status',
    // ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['name', 'text']);
    }

    public function getSum()
    {
        return
            $this->income_tax +
            $this->social_security_contributions +
            $this->health_insurance +
            $this->retirement_plan +
            $this->benefits +
            $this->union_fees +
            // $this->overtime +
            $this->undertime;
    }
    public function payroll(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Payroll::class);
    }
}
