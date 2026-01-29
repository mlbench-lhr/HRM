<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('interviews', function (Blueprint $table) {
            $table->id();

            // Interviewer Info
            $table->foreignId('interviewer_id')->nullable()->constrained('employees');
            $table->string('interviewer_name');

            // Candidate Info
            $table->string('candidate_name');
            $table->string('position');
            $table->date('interview_date');

            // 5 Rating Fields (1-5)
            $table->unsignedTinyInteger('skill_depth');
            $table->unsignedTinyInteger('problem_solving');
            $table->unsignedTinyInteger('practical_experience');
            $table->unsignedTinyInteger('communication_clarity');
            $table->unsignedTinyInteger('ownership_initiative');

            // NEW: Store Total Score (Max 25)
            $table->unsignedTinyInteger('total_score')->default(0);

            // Final Result
            $table->text('final_comment')->nullable();
            $table->boolean('is_recommended')->default(false);

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('interviews');
    }
};
