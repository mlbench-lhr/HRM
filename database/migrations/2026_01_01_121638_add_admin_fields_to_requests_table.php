<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->boolean('is_admin_created')
                ->default(false)
                ->after('status');

            $table->foreignId('created_by_admin_id')
                ->nullable()
                ->after('is_admin_created')
                ->constrained('employees')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->dropForeign(['created_by_admin_id']);
            $table->dropColumn([
                'is_admin_created',
                'created_by_admin_id',
            ]);
        });
    }
};
