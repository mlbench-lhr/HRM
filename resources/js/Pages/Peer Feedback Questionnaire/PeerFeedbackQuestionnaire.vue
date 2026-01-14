<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm } from "@inertiajs/vue3";
import EvaluationTabs from "@/Components/Tabs/EvaluationTabs.vue";
import { useToast } from "vue-toastification";
import InputLabel from "@/Components/InputLabel.vue";
import InputError from "@/Components/InputError.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

const toast = useToast();

const props = defineProps({
    employees: Array,
});

const questions = [
    {
        id: "collaboration",
        text: "How effectively did the employee collaborate with you and other team members?",
    },
    {
        id: "supportiveness",
        text: "How willing was the employee to support teammates when needed?",
    },
    {
        id: "respect",
        text: "How respectful was the employee toward different opinions and working styles?",
    },
    {
        id: "communication",
        text: "How clear and effective was the employee’s communication?",
    },
    {
        id: "responsiveness",
        text: "How timely was the employee in responding to messages, emails, or requests?",
    },
    {
        id: "openness_to_feedback",
        text: "How open was the employee to feedback and suggestions?",
    },
    {
        id: "attitude",
        text: "How would you rate the employee’s attitude during the project?",
    },
    {
        id: "conflict_handling",
        text: "How well did the employee handle disagreements or challenging situations?",
    },
    {
        id: "dependability",
        text: "How dependable was the employee in completing assigned tasks?",
    },
    {
        id: "accountability",
        text: "How accountable was the employee for their responsibilities and outcomes?",
    },
    {
        id: "professionalism",
        text: "How professionally did the employee conduct themselves in meetings and discussions?",
    },
    {
        id: "team_impact",
        text: "How positive was the employee’s overall impact on the team environment?",
    },
    {
        id: "overall_team_member",
        text: "How would you rate this employee as a team member overall?",
    },
    {
        id: "work_again",
        text: "How likely would you be to work with this employee again?",
    },
];

const form = useForm({
    employee_id: "",
    ratings: {
        collaboration: null,
        supportiveness: null,
        respect: null,
        communication: null,
        responsiveness: null,
        openness_to_feedback: null,
        attitude: null,
        conflict_handling: null,
        dependability: null,
        accountability: null,
        professionalism: null,
        team_impact: null,
        overall_team_member: null,
        work_again: null,
    },
    peer_comments: "", // Changed from feedback_text
});

const submitForm = () => {
    form.post(route("peer-feedback.store"), {
        preserveScroll: true,
        onSuccess: () => {
            toast.success(__("Feedback submitted successfully"));
            form.reset();
        },
    });
};

const scale = [
    { val: 1, label: "Very Poor" },
    { val: 2, label: "Poor" },
    { val: 3, label: "Average" },
    { val: 4, label: "Good" },
    { val: 5, label: "Excellent" },
];
</script>

<template>
    <Head :title="__('Peer Feedback')" />
    <AuthenticatedLayout>
        <!-- <template #tabs>
            <EvaluationTabs />
        </template> -->

        <div class="py-12 bg-gray-50 dark:bg-gray-950 min-h-screen">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mb-8 text-center">
                    <h1
                        class="text-3xl font-extrabold text-gray-900 dark:text-white tracking-tight"
                    >
                        {{ __("Peer Feedback Questionnaire") }}
                    </h1>
                    <p class="mt-2 text-gray-600 dark:text-gray-400">
                        Project Collaboration Evaluation
                    </p>
                </div>

                <div class="mb-8 flex flex-wrap justify-center gap-4">
                    <div
                        v-for="item in scale"
                        :key="item.val"
                        class="flex items-center space-x-1"
                    >
                        <span
                            class="text-xs font-bold w-5 h-5 flex items-center justify-center rounded bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 shadow-sm"
                            >{{ item.val }}</span
                        >
                        <span
                            class="text-xs text-gray-500 uppercase tracking-wider"
                            >{{ item.label }}</span
                        >
                    </div>
                </div>

                <form @submit.prevent="submitForm" class="space-y-6">
                    <Card
                        class="p-6 border-none shadow-sm ring-1 ring-gray-200 dark:ring-gray-800"
                    >
                        <InputLabel
                            :value="__('Who are you evaluating?')"
                            class="text-lg font-semibold mb-4"
                        />
                        <select
                            v-model="form.employee_id"
                            class="w-full rounded-xl border-gray-200 dark:border-gray-800 dark:bg-gray-900 focus:ring-blue-500 transition-all"
                            required
                        >
                            <option value="" disabled>
                                {{ __("Select a team member") }}
                            </option>
                            <option
                                v-for="emp in employees"
                                :key="emp.id"
                                :value="emp.id"
                                :disabled="emp.alreadyEvaluated"
                            >
                                {{ emp.name }}
                                {{
                                    emp.alreadyEvaluated
                                        ? `(${__("Already evaluated")})`
                                        : ""
                                }}
                            </option>
                        </select>
                        <InputError
                            :message="form.errors.employee_id"
                            class="mt-2"
                        />
                    </Card>

                    <div
                        v-for="(q, index) in questions"
                        :key="q.id"
                        class="bg-white dark:bg-gray-900 p-6 rounded-2xl shadow-sm border border-gray-100 dark:border-gray-800 transition-all hover:shadow-md"
                    >
                        <div class="flex items-start space-x-4">
                            <span
                                class="flex-shrink-0 w-8 h-8 flex items-center justify-center rounded-full bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 font-bold text-sm"
                            >
                                {{ index + 1 }}
                            </span>
                            <div class="flex-1">
                                <p
                                    class="text-gray-800 dark:text-gray-200 font-medium mb-6 leading-relaxed"
                                >
                                    {{ q.text }}
                                </p>

                                <div
                                    class="flex items-center justify-between max-w-md mx-auto sm:mx-0"
                                >
                                    <template v-for="n in 5" :key="n">
                                        <label
                                            class="relative cursor-pointer group"
                                        >
                                            <input
                                                type="radio"
                                                :name="q.id"
                                                :value="n"
                                                v-model="form.ratings[q.id]"
                                                class="sr-only peer"
                                                required
                                            />
                                            <div
                                                class="w-12 h-12 flex items-center justify-center rounded-xl border-2 border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/50 transition-all peer-checked:border-blue-500 peer-checked:bg-blue-500 peer-checked:text-white peer-hover:border-blue-300 dark:peer-hover:border-blue-700 text-gray-400 dark:text-gray-500 font-bold text-lg"
                                            >
                                                {{ n }}
                                            </div>
                                        </label>
                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>

                    <Card
                        class="p-6 border-none shadow-sm ring-1 ring-gray-200 dark:ring-gray-800"
                    >
                        <InputLabel
                            :value="
                                __('Additional Examples & Improvement Areas')
                            "
                            class="text-lg font-semibold mb-4"
                        />
                        <textarea
                            v-model="form.peer_comments"
                            rows="4"
                            class="w-full rounded-xl border-gray-200 dark:border-gray-800 dark:bg-gray-900 focus:ring-blue-500 placeholder-gray-400"
                            :placeholder="
                                __(
                                    'Share specific examples of strengths or areas where they can grow...'
                                )
                            "
                        ></textarea>
                    </Card>

                    <div class="flex justify-center pt-8 pb-12">
                        <PrimaryButton
                            class="px-12 py-4 rounded-full bg-blue-600 hover:bg-blue-700 shadow-lg shadow-blue-500/30 transition-all transform hover:-translate-y-1 active:scale-95 text-lg font-bold"
                            :disabled="form.processing"
                        >
                            {{
                                form.processing
                                    ? __("Submitting...")
                                    : __("Complete Evaluation")
                            }}
                        </PrimaryButton>
                    </div>
                </form>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
/* Smooth transition for the rating buttons */
input:checked + div {
    box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.3);
}
</style>
