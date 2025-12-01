<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Create the leave_requests table
        Schema::create('leave_requests', function (Blueprint $table) {
            $table->id();

            $table->foreignId('request_id')
                ->constrained('requests')
                ->onDelete('cascade');

            // Leave-specific columns
            $table->string('leave_type')->nullable();
            $table->decimal('leave_duration', 4, 2)->nullable();
            $table->date('half_leave_date')->nullable();
            $table->string('half_leave_segment')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();

            // Remote work
            $table->date('remote_work_date')->nullable();

            $table->timestamps();
        });

        // 2. Drop leave-related columns from requests table
        Schema::table('requests', function (Blueprint $table) {
            $table->dropColumn([
                'end_date',
                'half_leave_date',
                'half_leave_segment',
                'leave_duration',
                'leave_type',
                'remote_work_date',
                'start_date',
            ]);
        });
    }

    public function down(): void
    {
        // Restore removed columns
        Schema::table('requests', function (Blueprint $table) {

            $table->date('end_date')->nullable();
            $table->date('half_leave_date')->nullable();
            $table->string('half_leave_segment')->nullable();
            $table->decimal('leave_duration', 4, 2)->nullable();
            $table->string('leave_type')->nullable();
            $table->date('remote_work_date')->nullable();
            $table->date('start_date')->nullable();
        });

        Schema::dropIfExists('leave_requests');
    }
};
