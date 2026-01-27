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
        Schema::table('evaluations', function (Blueprint $table) {
            // Allows values like 4.5, 5.0 (3 digits total, 1 after decimal)
            $table->decimal('avg_rating', 3, 1)->default(0.0)->after('attendance');
        });
    }

    public function down()
    {
        Schema::table('evaluations', function (Blueprint $table) {
            $table->dropColumn('avg_rating');
        });
    }
};
