<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('employee_leave_allocations', function (Blueprint $table) {
            $table->decimal('used_leaves', 5, 2)->default(0);
            $table->decimal('remaining_leaves', 5, 2)->default(0);
        });
    }

    public function down()
    {
        Schema::table('employee_leave_allocations', function (Blueprint $table) {
            $table->dropColumn(['used_leaves', 'remaining_leaves']);
        });
    }
};
