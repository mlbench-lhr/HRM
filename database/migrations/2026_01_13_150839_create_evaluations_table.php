<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('evaluations', function (Blueprint $table) {
            $table->id();

            $table->foreignId('evaluator_id')->constrained('employees')->cascadeOnDelete();
            $table->foreignId('employee_id')->constrained('employees')->cascadeOnDelete();

            $table->string('evaluator_name');
            $table->string('evaluator_designation');

            $table->tinyInteger('work_done')->nullable();
            $table->tinyInteger('quality_of_work')->nullable();
            $table->tinyInteger('timeliness')->nullable();
            $table->tinyInteger('reliability')->nullable();
            $table->tinyInteger('communication_skills')->nullable();
            $table->tinyInteger('daily_status')->nullable();
            $table->tinyInteger('problem_solving')->nullable();
            $table->tinyInteger('ownership')->nullable();
            $table->tinyInteger('team_collaboration')->nullable();
            $table->tinyInteger('adaptability')->nullable();
            $table->tinyInteger('client_handling')->nullable();
            $table->tinyInteger('learning_skill')->nullable();
            $table->tinyInteger('attendance')->nullable();

            $table->text('final_comments')->nullable();
            $table->text('strong_points')->nullable();
            $table->text('weak_points')->nullable();

            $table->timestamps();

            // Generated columns
            $table->unsignedSmallInteger('eval_year')
                ->storedAs('YEAR(created_at)');
            $table->unsignedTinyInteger('eval_month')
                ->storedAs('MONTH(created_at)');

            // Unique constraint
            $table->unique(
                ['evaluator_id', 'employee_id', 'eval_year', 'eval_month'],
                'eval_once_per_month'
            );
        });
    }

    public function down()
    {
        Schema::dropIfExists('evaluations');
    }
};
