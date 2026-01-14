<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Spatie\Permission\Models\Role;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        foreach (['admin', 'team lead', 'employee', 'probation'] as $role) {
            Role::firstOrCreate(['name' => $role]);
        }
        // Localization Carbon
        \Carbon\Carbon::setLocale(config('app.locale'));
    }
}
