<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->enum('type', ['Complaint', 'Payment', 'Leave',  'Other', 'Remote Work'])->default('Other')->change();

            $table->date('start_date')->nullable()->change();

            $table->date('half_leave_date')->nullable()->change();
            $table->decimal('leave_duration', 4, 1)->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->enum('type', ['Complaint', 'Payment', 'Leave',  'Other', 'Remote Work'])->default('Other')->change();


            $table->date('end_date')->nullable(false)->change();
            $table->date('half_leave_date')->nullable(false)->change();
            $table->decimal('leave_duration', 4, 1)->nullable(false)->change();
        });
    }
};
