<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm } from "@inertiajs/vue3";
import OrgTabs from "@/Components/Tabs/OrgTabs.vue";
import { useToast } from "vue-toastification";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

const toast = useToast();

const props = defineProps({
    employees: Array,
    currentUser: Object,
});

const ratings = [
    { key: "work_done", label: "Work Done?" },
    { key: "quality_of_work", label: "Quality of Work?" },
    { key: "timeliness", label: "Timeliness?" },
    { key: "reliability", label: "Reliability?" },
    { key: "communication_skills", label: "Communication Skills?" },
    { key: "daily_status", label: "Daily Status?" },
    { key: "problem_solving", label: "Problem Solving?" },
    { key: "ownership", label: "Ownership?" },
    { key: "team_collaboration", label: "Team Collaboration?" },
    { key: "adaptability", label: "Adaptability?" },
    { key: "client_handling", label: "Client Handling?" },
    { key: "learning_skill", label: "Learning & Skill?" },
    { key: "attendance", label: "Attendance?" },
];

const evaluationForm = useForm({
    employee_id: "",
    work_done: null,
    quality_of_work: null,
    timeliness: null,
    reliability: null,
    communication_skills: null,
    daily_status: null,
    problem_solving: null,
    ownership: null,
    team_collaboration: null,
    adaptability: null,
    client_handling: null,
    learning_skill: null,
    attendance: null,
    final_comments: "",
    strong_points: "",
    weak_points: "",
});

const submitEvaluation = () => {
    evaluationForm.post(route("evaluations.store"), {
        preserveScroll: true,
        onError: () => toast.error(__("Error submitting evaluation")),
        onSuccess: () => {
            toast.success(__("Evaluation submitted successfully"));
            evaluationForm.reset();
        },
    });
};
// Updated Scale with your detailed descriptions
const scaleDescriptions = [
    {
        val: 5,
        label: "Excellent",
        desc: "Consistently delivers outstanding results, exceeds expectations, and shows strong ownership, quality, and teamwork",
    },
    {
        val: 4,
        label: "Very Good",
        desc: "Regularly meets and often exceeds expectations with high-quality work and dependable performance.",
    },
    {
        val: 3,
        label: "Average",
        desc: "Meets basic job requirements but needs improvement in consistency, quality, or initiative.",
    },
    {
        val: 2,
        label: "Poor",
        desc: "Frequently misses expectations, shows performance gaps, and requires close supervision and guidance.",
    },
    {
        val: 1,
        label: "Very Poor",
        desc: "Consistently fails to meet job requirements and requires immediate corrective action or performance improvement plan.",
    },
];
</script>

<template>

    <Head :title="__('Employee Evaluation')" />
    <AuthenticatedLayout>
        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-5xl mx-auto sm:px-6 lg:px-8">
                <Card class="overflow-hidden shadow-xl border-t-4 border-indigo-500">
                    <div class="p-6 border-b border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800">
                        <h1 class="text-2xl font-bold text-gray-800 dark:text-white">
                            {{ __("Employee Evaluation") }}
                        </h1>
                        <p class="text-sm text-gray-500 mt-1">
                            {{
                                __(
                                    `Please provide your overall feedback to evaluate the employee's performance during their
                            tenure with us`
                                )
                            }}
                        </p>
                    </div>

                    <div
                        class="mx-6 mt-6 p-4 bg-blue-50/50 dark:bg-blue-900/10 border-l-4 border-blue-500 rounded-r-xl">
                        <h3 class="text-sm font-bold text-blue-800 dark:text-blue-300 mb-3 uppercase tracking-wider">
                            {{ __("Rating Scale Definitions") }}
                        </h3>
                        <div class="space-y-2">
                            <div v-for="s in scaleDescriptions" :key="s.val" class="text-sm leading-relaxed">
                                <span class="font-bold text-blue-700 dark:text-blue-400">{{ s.val }}. {{ __(s.label)
                                    }}</span>
                                <span class="text-gray-600 dark:text-gray-400">
                                    — {{ __(s.desc) }}</span>
                            </div>
                        </div>
                    </div>

                    <form @submit.prevent="submitEvaluation" class="p-6">
                        <div class="mb-10 p-4 bg-indigo-50 dark:bg-indigo-900/20 rounded-xl">
                            <InputLabel class="mb-2 text-indigo-700 dark:text-indigo-300 font-semibold after:content-['*'] after:ml-0.5
                                        after:text-red-500" :value="__('Select Employee')" />
                            <select v-model="evaluationForm.employee_id"
                                class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-indigo-500 focus:border-indigo-500 transition-all"
                                required>
                                <option value="" disabled>
                                    {{ __("Choose an employee...") }}
                                </option>
                                <option v-for="emp in employees" :key="emp.id" :value="emp.id"
                                    :disabled="emp.alreadyEvaluated">
                                    {{ emp.name }}
                                    {{
                                        emp.alreadyEvaluated
                                            ? `(${__("Already evaluated")})`
                                            : ""
                                    }}
                                </option>
                            </select>
                            <InputError class="mt-2" :message="evaluationForm.errors.employee_id" />
                        </div>

                        <div class="mb-8">
                            <h2 class="text-lg font-semibold text-gray-700 dark:text-gray-300 mb-4 flex items-center">
                                <span
                                    class="w-8 h-8 rounded-full bg-indigo-100 dark:bg-indigo-800 text-indigo-600 dark:text-indigo-200 flex items-center justify-center mr-2 text-sm">1</span>
                                {{ __("Performance Metrics") }}
                            </h2>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-6">
                                <div v-for="item in ratings" :key="item.key"
                                    class="p-4 border border-gray-100 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors">
                                    <InputLabel :value="item.label" class="mb-3 font-medium after:content-['*'] after:ml-0.5
                                        after:text-red-500" />
                                    <div class="flex items-center justify-between space-x-2">
                                        <span class="text-xs text-gray-400 uppercase tracking-tighter">{{ __("Poor")
                                            }}</span>
                                        <div
                                            class="flex bg-gray-100 dark:bg-gray-700 p-1 rounded-lg w-full max-w-[200px] justify-between">
                                            <label v-for="n in 5" :key="n" class="relative flex-1 group">
                                                <input type="radio" :value="n" v-model="evaluationForm[item.key]
                                                    " class="sr-only peer" />
                                                <div
                                                    class="cursor-pointer text-center py-1 rounded-md transition-all peer-checked:bg-indigo-600 peer-checked:text-white hover:bg-indigo-200 dark:hover:bg-indigo-800 text-gray-600 dark:text-gray-300 font-bold">
                                                    {{ n }}
                                                </div>
                                            </label>
                                        </div>
                                        <span class="text-xs text-gray-400 uppercase tracking-tighter">{{ __("Great")
                                            }}</span>
                                    </div>
                                    <InputError class="mt-2" :message="evaluationForm.errors[item.key]
                                        " />
                                </div>
                            </div>
                        </div>

                        <div class="mt-12 space-y-6">
                            <h2 class="text-lg font-semibold text-gray-700 dark:text-gray-300 mb-4 flex items-center">
                                <span
                                    class="w-8 h-8 rounded-full bg-indigo-100 dark:bg-indigo-800 text-indigo-600 dark:text-indigo-200 flex items-center justify-center mr-2 text-sm">2</span>
                                {{ __("Qualitative Feedback") }}
                            </h2>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <InputLabel :value="__('Strong Points')" class=" after:content-['*'] after:ml-0.5
                                        after:text-red-500" />
                                    <textarea required v-model="evaluationForm.strong_points"
                                        class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-emerald-500 focus:border-emerald-500 min-h-[100px]"
                                        placeholder="What did they excel at this month?"></textarea>
                                </div>
                                <div class="space-y-2">
                                    <InputLabel :value="__('Weak Points')" class=" after:content-['*'] after:ml-0.5
                                        after:text-red-500" />
                                    <textarea required v-model="evaluationForm.weak_points"
                                        class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-rose-500 focus:border-rose-500 min-h-[100px]"
                                        placeholder="Areas needing improvement..."></textarea>
                                </div>
                            </div>

                            <div class="space-y-2">
                                <InputLabel :value="__('Final Comments')" class=" after:content-['*'] after:ml-0.5
                                        after:text-red-500" />
                                <textarea required v-model="evaluationForm.final_comments"
                                    class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-indigo-500 focus:border-indigo-500 min-h-[80px]"
                                    placeholder="Any additional thoughts or summary..."></textarea>
                            </div>
                        </div>

                        <div
                            class="flex items-center justify-end mt-10 pt-6 border-t border-gray-100 dark:border-gray-700">
                            <PrimaryButton
                                class="px-8 py-3 bg-indigo-600 hover:bg-indigo-700 transition-all transform hover:scale-105"
                                :class="{
                                    'opacity-25': evaluationForm.processing,
                                }" :disabled="evaluationForm.processing">
                                <span v-if="evaluationForm.processing">{{
                                    __("Submitting...")
                                    }}</span>
                                <span v-else>{{
                                    __("Submit Monthly Evaluation")
                                    }}</span>
                            </PrimaryButton>
                        </div>
                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
