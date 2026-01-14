<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Notification;


use Illuminate\Support\Facades\Route;
use App\Tasks\DailyAttendanceHandle;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::group(['middleware' => ['role:admin', 'auth']], function () {

    Route::get('employees/find', [\App\Http\Controllers\EmployeeController::class, 'find'])->name('employees.find');
    Route::get('employees/archived', [\App\Http\Controllers\EmployeeController::class, 'archivedIndex'])->name('employees.archived');
    Route::resource('employees', \App\Http\Controllers\EmployeeController::class);
    Route::resource('branches', \App\Http\Controllers\BranchController::class);
    Route::resource('departments', \App\Http\Controllers\DepartmentController::class);
    Route::resource('positions', \App\Http\Controllers\PositionController::class);
    Route::resource('shifts', \App\Http\Controllers\ShiftController::class);
    Route::resource('metrics', \App\Http\Controllers\MetricsController::class);
    Route::resource('requests', \App\Http\Controllers\RequestController::class);
    //   Route::get('/admin/evaluations', [\App\Http\Controllers\EvaluationController::class, 'adminIndex'])->name('admin.evaluations');
    Route::get('/admin/evaluations', [\App\Http\Controllers\EvaluationController::class, 'adminIndex'])->name('admin.evaluations');
    Route::get('/admin/evaluations/{id}', [\App\Http\Controllers\EvaluationController::class, 'show'])->name('admin.evaluations.show');
    Route::get('/admin/peer-feedback', [\App\Http\Controllers\PeerFeedbackController::class, 'index'])
        ->name('admin.peer-feedback.index');
    Route::get('/peer-evaluations/{id}', [\App\Http\Controllers\PeerFeedbackController::class, 'show'])->name('peer-feedback.show');


    Route::post(
        'employees/{employee}/leave',
        [\App\Http\Controllers\RequestController::class, 'adminAddLeave']
    )->name('admin.leave.add');
    // Payroll
    Route::put('payrolls/{id}/updateStatus', [\App\Http\Controllers\PayrollController::class, 'updateStatus'])->name('payrolls.updateStatus');
    Route::resource('payrolls', \App\Http\Controllers\PayrollController::class);

    Route::get('attendance/{date}', [\App\Http\Controllers\AttendanceController::class, 'dayShow'])->name('attendance.show');
    Route::delete('attendance', [\App\Http\Controllers\AttendanceController::class, 'dayDelete'])->name('attendance.destroy');
    Route::resource('attendances', \App\Http\Controllers\AttendanceController::class);

    // Globals
    Route::get('globals', [\App\Http\Controllers\GlobalsController::class, 'index'])->name('globals.index');
    Route::get('globals/edit', [\App\Http\Controllers\GlobalsController::class, 'edit'])->name('globals.edit');
    Route::put('globals/edit', [\App\Http\Controllers\GlobalsController::class, 'update'])->name('globals.update');

    // Logs
    Route::get('logs', [\App\Http\Controllers\LogsController::class, 'index'])->name('logs.index');

    // Calendar
    Route::get('calendar', [\App\Http\Controllers\CalendarController::class, 'calendarIndex'])->name('calendar.index');
    Route::resource('calendars', \App\Http\Controllers\CalendarController::class);
});


// Logged
Route::group(['middleware' => ['auth']], function () {

    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');

    Route::get('dashboard', [\App\Http\Controllers\DashboardController::class, 'index'])->name('dashboard.index');

    Route::get('my-profile', [\App\Http\Controllers\EmployeeController::class, 'showMyProfile'])->name('my-profile');
    Route::resource('requests', \App\Http\Controllers\RequestController::class)->only(['index', 'show', 'create', 'store']);
    Route::resource('payrolls', \App\Http\Controllers\PayrollController::class)->only(['index', 'show']);
    Route::get('calendar', [\App\Http\Controllers\CalendarController::class, 'calendarIndex'])->name('calendar.index');

    Route::get('my-attendance', [\App\Http\Controllers\AttendanceController::class, 'attendanceDashboard'])->name('attendance.dashboard');
    Route::post('attendance/signin', [\App\Http\Controllers\AttendanceController::class, 'dashboardSignInAttendance'])->name('attendance.dashboardSignIn');
    Route::post('attendance/signoff', [\App\Http\Controllers\AttendanceController::class, 'dashboardSignOffAttendance'])->name('attendance.dashboardSignOff');
    Route::group(['middleware' => ['role:team lead']], function () {
        Route::get('/evaluations', [\App\Http\Controllers\EvaluationController::class, 'evaluationForm'])->name('evaluations.form');
        Route::post('/evaluations', [\App\Http\Controllers\EvaluationController::class, 'store'])->name('evaluations.store');
    });
    Route::middleware(['auth'])->group(function () {
        Route::get('/peer-evaluations', [\App\Http\Controllers\PeerFeedbackController::class, 'create'])
            ->name('peer-evaluations.create');

        Route::post('/peer-evaluations', [\App\Http\Controllers\PeerFeedbackController::class, 'store'])
            ->name('peer-feedback.store');
    });
});

Route::post('/notifications/{id}/read', function ($id) {
    /** @var \App\Models\Employee $user */
    $user = auth()->user();
    $notification = $user->notifications()->findOrFail($id);
    $notification->markAsRead();
    return back();
})->name('notifications.read');



// Route::get('/run-task', function () {
//     (new DailyAttendanceHandle)();
//     return "Attendance Task Completed Successfully!";
// });
// Route::get('/_debug/generate-attendance', function () {

//     abort_unless(app()->environment('local'), 403);

//     $start = \Carbon\Carbon::parse('2025-12-01');
//     $end   = \Carbon\Carbon::parse('2026-01-05');

//     while ($start->lte($end)) {
//         (new \App\Tasks\DailyAttendanceHandle())(
//             $start->toDateString()
//         );
//         $start->addDay();
//     }

//     return 'Attendance generated from 2025-12-01 to 2026-01-05';
// });
Route::redirect('/', '/dashboard')->middleware('auth');

// Language Switching
Route::get('language/{language}', function ($language) {
    Session()->put('locale', $language);
    return redirect()->back();
})->name('language');

require __DIR__ . '/auth.php';
