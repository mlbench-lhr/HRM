<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /** * Run the migrations. */ public function up()
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->enum('type', ['complaint', 'payment', 'leave',  'other', 'remote'])->default('other')->change();
            $table->enum('leave_type', ['half', 'full'])->nullable();
            $table->date('half_leave_date')->nullable();
            $table->decimal('leave_duration', 4, 1)->nullable();
        });
    }
    public function down()
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->enum('type', ['complaint', 'payment', 'leave', 'other', 'remote'])->default('other')->change();
            $table->dropColumn(['leave_type', 'half_leave_date', 'leave_duration']);
        });
    }
};
