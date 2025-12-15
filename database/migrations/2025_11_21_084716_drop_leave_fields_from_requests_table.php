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

            // Drop foreign key only if column exists
            if (Schema::hasColumn('requests', 'leave_type_id')) {

                try {
                    $table->dropForeign(['leave_type_id']);
                } catch (\Throwable $e) {
                    // foreign key does not exist, ignore
                }

                $table->dropColumn('leave_type_id');
            }

            if (Schema::hasColumn('requests', 'leave_duration')) {
                $table->dropColumn('leave_duration');
            }

            if (Schema::hasColumn('requests', 'total_days')) {
                $table->dropColumn('total_days');
            }
        });
    }

    public function down(): void
    {
        // intentionally left empty
    }
};
