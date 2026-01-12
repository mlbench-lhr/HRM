<?php

namespace App\Services;


use App\Mail\PayrollEmail;
use App\Models\Globals;
use App\Models\Payroll;
use Arr;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;

class PayrollServices
{

    private function quickPay($payroll, $res)
    {
        $payroll->additions->update([
            'status' => true,
        ]);
        $payroll->deductions->update([
            'status' => true,
        ]);
        $payroll->update([
            'performance_multiplier' => 1,
            'total_deductions' => 0,
            'total_additions' => 0,
            'total_payable' => $payroll->base,
            'is_reviewed' => true,
            'status' => true, // paid
        ]);
        if ($res['quick_pay_send_email']) {
            Mail::to($payroll->employee->email)->queue(new PayrollEmail($payroll));
        }
        return to_route('payrolls.show', ['payroll' => $payroll]);
    }

    // public function updatePayroll($res, $id)
    // {
    //     $payroll = Payroll::findOrFail($id);

    //     if ($res['quick_pay']) {
    //         return $this->quickPay($payroll, $res);
    //     }
    //     $payrollDate = Carbon::parse($payroll->due_date)->subMonthNoOverflow();

    //     $year  = $payrollDate->year;
    //     $month = $payrollDate->month;

    //     $shiftDifferentials = ($payroll->employee->activeShift()->shift_payment_multiplier - 1) * $payroll->base;
    //     $summary = $payroll->employee->payrollAttendanceSummary($year, $month);
    //     $daysInMonth = Carbon::create($year, $month, 1)->daysInMonth;
    //     $dailyRate   = $payroll->base / $daysInMonth;

    //     //  $unpaidDeduction = $summary['unpaid_days'] * $dailyRate;
    //     $unpaidDays = $summary['unpaid_days'];
    //     $unpaidDeduction = $unpaidDays * $dailyRate;
    //     // OPTIONAL: overtime logic if you still want it
    //     $overtime = 0;
    //     $undertime = 0;

    //     // $hours = $payroll->employee->monthHours(
    //     //     Carbon::parse($payroll->due_date)->subMonthNoOverflow()->year,
    //     //     Carbon::parse($payroll->due_date)->subMonthNoOverflow()->month
    //     // );
    //     // $overtime = $hours['hoursDifference'] > 0 ? $hours['hoursDifference'] * $res['extra_hour_rate'] : 0;
    //     // $undertime = $hours['hoursDifference'] < 0 ? $hours['hoursDifference'] * $res['negative_hour_rate'] * -1 : 0; // * -1 to get +ve value, as hoursDifference is -ve
    //     $income_tax = (Globals::first()->income_tax / 100) * $payroll->base;

    //     $payroll->additions->update([
    //         'rewards' => $res['rewards'],
    //         'incentives' => $res['incentives'],
    //         'reimbursements' => $res['reimbursements'],
    //         'shift_differentials' => $shiftDifferentials,
    //         'commissions' => $res['commissions'],
    //         'overtime' => $overtime,
    //         'extra_hour_rate' => $res['extra_hour_rate'],
    //         'status' => true,
    //     ]);
    //     $negativeHours = abs($summary['negative_hours'] ?? 0);
    //     $negativeHoursDeduction = $negativeHours * $res['negative_hour_rate'];
    //     $payroll->deductions->update([
    //         'income_tax' => $income_tax,
    //         'social_security_contributions' => $res['social_security_contributions'],
    //         'health_insurance' => $res['health_insurance'],
    //         'retirement_plan' => $res['retirement_plan'],
    //         'benefits' => $res['benefits'],
    //         'union_fees' => $res['union_fees'],

    //         'undertime' => $negativeHoursDeduction, // ✅ THIS IS THE FIX
    //         'negative_hour_rate' => $res['negative_hour_rate'], // metadata
    //         'unpaid_absence_deduction' => $unpaidDeduction,

    //         'status' => true,


    //     ]);
    //     $payroll->deductions->refresh();
    //     for ($i = 0; $i < count($payroll->evaluations); $i++) {
    //         $ev = $payroll->evaluations[$i];
    //         $grade = $ev->metric->findGrade($res['metrics'][$i]);
    //         $payroll->evaluations[$i]->where([
    //             'metric_id' => $res['metricsIDs'][$i],
    //             'payroll_id' => $payroll->id,
    //             'employee_id' => $payroll->employee_id,
    //         ])->update([
    //             // [GRADE - WEIGHT - STEP - WEIGHTED POINT]
    //             'score' => [
    //                 $grade,
    //                 $ev->metric->weight,
    //                 $ev->metric->step,
    //                 round(1 + (abs(1 - $res['metrics'][$i]) * $ev->metric->weight * ($res['metrics'][$i] > 1 ? 1 : -1)), 2)
    //             ],
    //         ]);
    //     }

    //     //  $paidSalary = $summary['paid_days'] * $dailyRate;

    //     $payroll->update([
    //         'performance_multiplier' => $res['performance_multiplier'],
    //         'total_deductions' => $payroll->deductions->getSum(),
    //         'total_additions' => $payroll->additions->getSum(),
    //         'total_payable' => round(
    //             ($payroll->base * $res['performance_multiplier'])
    //                 + $payroll->additions->getSum()
    //                 - $payroll->deductions->getSum(),
    //             2
    //         ),
    //         'is_reviewed' => true,
    //     ]);

    //     return to_route('payrolls.show', ['payroll' => $payroll]);
    // }
    public function updatePayroll($res, $id)
    {
        $payroll = Payroll::findOrFail($id);

        if ($res['quick_pay']) {
            return $this->quickPay($payroll, $res);
        }

        $payrollDate = Carbon::parse($payroll->due_date)->subMonthNoOverflow();
        $year  = $payrollDate->year;
        $month = $payrollDate->month;

        $shiftDifferentials =
            ($payroll->employee->activeShift()->shift_payment_multiplier - 1)
            * $payroll->base;

        // 🔒 SOURCE OF TRUTH: negative hours only
        $hours = $payroll->employee->monthHours($year, $month);
        $extraHours = $hours['hoursDifference'] > 0
            ? $hours['hoursDifference']
            : 0;

        $extraHoursAddition = $extraHours * $res['extra_hour_rate'];
        $negativeHours = $hours['hoursDifference'] < 0
            ? abs($hours['hoursDifference'])
            : 0;
        $negativeHoursDeduction = $negativeHours * $res['negative_hour_rate'];

        $income_tax = (Globals::first()->income_tax / 100) * $payroll->base;

        $payroll->additions->update([
            'rewards' => $res['rewards'],
            'incentives' => $res['incentives'],
            'reimbursements' => $res['reimbursements'],
            'shift_differentials' => $shiftDifferentials,
            'commissions' => $res['commissions'],

            // ✅ ONLY extra hours money
            'overtime' => $extraHoursAddition,

            // metadata
            'extra_hour_rate' => $res['extra_hour_rate'],

            'status' => true,
        ]);
        // 1. Only calculate 5% Gratuity if the status is 'employee'
        $isEmployee = $payroll->employee ? $payroll->employee->hasRole('employee') : false;

        $gratuity = $isEmployee ? round($payroll->base * 0.05, 2) : 0;

        $payroll->deductions->update([
            'income_tax' => $income_tax,
            'social_security_contributions' => $res['social_security_contributions'],
            'health_insurance' => $res['health_insurance'],

            // Assigned based on the check above
            'retirement_plan' => $gratuity,

            'benefits' => $res['benefits'],
            'union_fees' => $res['union_fees'],
            'undertime' => $negativeHoursDeduction,
            'negative_hour_rate' => $res['negative_hour_rate'],
            'unpaid_absence_deduction' => 0,
            'status' => true,
        ]);

        // refresh cached relation
        $payroll->deductions->refresh();

        $payroll->update([
            'performance_multiplier' => $res['performance_multiplier'],
            'total_deductions' => $payroll->deductions->getSum(),
            'total_additions' => $payroll->additions->getSum(),
            'total_payable' => round(
                ($payroll->base * $res['performance_multiplier'])
                    + $payroll->additions->getSum()
                    - $payroll->deductions->getSum(),
                2
            ),
            'is_reviewed' => true,
        ]);

        return to_route('payrolls.show', ['payroll' => $payroll]);
    }

    public function updatePayrollStatus($request, $id)
    {
        $request->validate([
            'status' => 'required|boolean',
            'sendEmail' => 'nullable|integer|in:0,1'
        ]);
        $payroll = Payroll::findOrFail($id);
        if (!$payroll->is_reviewed) {
            return response()->json(['Error' => 'Payroll must be reviewed before it can be paid.']);
        }
        $payroll->update([
            'status' => $request->status,
        ]);

        if ($request->sendEmail && $payroll->status) {
            Mail::to($payroll->employee->email)->queue(new PayrollEmail($payroll));
        }
    }
}
