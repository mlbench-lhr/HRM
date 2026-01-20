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
        // Ensure you are targeting the correct table name (usually 'users' or 'employees')
        Schema::table('employees', function (Blueprint $table) {
            // This creates the column and links it to the 'id' in the 'teams' table
            // onDelete('set null') ensures that if a Team is deleted, the employee
            // isn't deleted; they just become "teamless".
            $table->foreignId('team_id')
                ->nullable()
                ->constrained('teams')
                ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            // 1. Drop the foreign key constraint first
            // Laravel naming convention for this index is: table_column_foreign
            $table->dropForeign(['team_id']);

            // 2. Drop the actual column
            $table->dropColumn('team_id');
        });
    }
};
