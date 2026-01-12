<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        DB::statement("
        ALTER TABLE attendances
        MODIFY status ENUM(
            'on_time',
            'late',
            'missed',
            'leave',
            'unpaid_leave',
            'partial_present',
            'incomplete'
        ) NOT NULL DEFAULT 'missed'
    ");
    }

    public function down()
    {
        DB::statement("
        ALTER TABLE attendances
        MODIFY status ENUM('on_time','late','missed') NOT NULL DEFAULT 'missed'
    ");
    }
};
