<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('peer_feedback_evaluations', function (Blueprint $table) {
            $table->id();

            // Relations
            $table->foreignId('evaluator_id')->constrained('employees')->cascadeOnDelete();
            $table->foreignId('employee_id')->constrained('employees')->cascadeOnDelete();

            // Evaluator snapshot
            $table->string('evaluator_name');
            $table->string('evaluator_designation')->nullable();

            // Ratings (1–5)
            $table->tinyInteger('collaboration')->nullable();
            $table->tinyInteger('supportiveness')->nullable();
            $table->tinyInteger('respect')->nullable();
            $table->tinyInteger('communication')->nullable();
            $table->tinyInteger('responsiveness')->nullable();
            $table->tinyInteger('openness_to_feedback')->nullable();
            $table->tinyInteger('attitude')->nullable();
            $table->tinyInteger('conflict_handling')->nullable();
            $table->tinyInteger('dependability')->nullable();
            $table->tinyInteger('accountability')->nullable();
            $table->tinyInteger('professionalism')->nullable();
            $table->tinyInteger('team_impact')->nullable();
            $table->tinyInteger('overall_team_member')->nullable();
            $table->tinyInteger('work_again')->nullable();

            // Calculated
            $table->decimal('avg_rating', 3, 2)->nullable();

            // Comments
            $table->text('peer_comments')->nullable();

            $table->timestamps();

            // ADD THESE COLUMNS
            $table->integer('year');
            $table->integer('month');


            // Fix the Unique Constraint to use year/month instead of created_at
            $table->unique(['evaluator_id', 'employee_id', 'year', 'month'], 'eval_unique_monthly');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('peer_feedback_evaluations');
    }
};
