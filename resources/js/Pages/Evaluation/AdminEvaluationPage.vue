<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import OrgTabs from "@/Components/Tabs/OrgTabs.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

const props = defineProps({ evaluations: Array });

// Helper to calculate the average of all 13 rating metrics
const calculateAverage = (item) => {
    const keys = [
        "work_done",
        "quality_of_work",
        "timeliness",
        "reliability",
        "problem_solving",
        "ownership",
        "communication_skills",
        "team_collaboration",
        "daily_status",
        "adaptability",
        "client_handling",
        "learning_skill",
        "attendance",
    ];

    // Sum up the values that exist
    const total = keys.reduce((sum, key) => sum + (Number(item[key]) || 0), 0);
    const average = total / keys.length;

    return average.toFixed(1); // Returns 1 decimal place (e.g., 4.2)
};

// Helper to color-code the average score
const getScoreClass = (score) => {
    if (score >= 4.5)
        return "bg-emerald-100 text-emerald-700 border border-emerald-200";
    if (score >= 3.5)
        return "bg-[#EDEBFE] text-[#5521B5] border border-[#5521B5]/20";
    if (score >= 2.5)
        return "bg-amber-100 text-amber-700 border border-amber-200";
    return "bg-rose-100 text-rose-700 border border-rose-200";
};
</script>

<template>
    <Head :title="__('Employee Evaluations')" />
    <AuthenticatedLayout>
        <template #tabs> </template>

        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mb-6 flex justify-between items-center">
                    <h1
                        class="text-2xl font-bold text-gray-800 dark:text-white tracking-tight"
                    >
                        {{ __("Performance Reviews") }}
                    </h1>
                </div>

                <Card
                    class="overflow-hidden !p-0 border-none shadow-xl rounded-2xl"
                >
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr
                                class="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700"
                            >
                                <th
                                    class="px-6 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400"
                                >
                                    {{ __("Employee") }}
                                </th>
                                <th
                                    class="px-6 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400"
                                >
                                    {{ __("Evaluator") }}
                                </th>
                                <th
                                    class="px-6 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400 text-center"
                                >
                                    {{ __("Avg. Rating") }}
                                </th>
                                <th
                                    class="px-6 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400"
                                >
                                    {{ __("Review Date") }}
                                </th>
                                <th
                                    class="px-6 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400 text-right"
                                >
                                    {{ __("Actions") }}
                                </th>
                            </tr>
                        </thead>
                        <tbody
                            class="divide-y divide-gray-50 dark:divide-gray-700 bg-white dark:bg-gray-800"
                        >
                            <tr
                                v-for="item in evaluations"
                                :key="item.id"
                                class="hover:bg-[#EDEBFE]/30 dark:hover:bg-gray-700/50 transition-colors group"
                            >
                                <td class="px-6 py-4">
                                    <div
                                        class="font-bold text-gray-900 dark:text-white group-hover:text-[#5521B5] transition-colors"
                                    >
                                        {{ item.employee?.name }}
                                    </div>
                                    <div
                                        class="text-xs font-medium text-gray-400"
                                    >
                                        ID: {{ item.employee?.id }}
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div
                                        class="text-sm font-semibold text-gray-700 dark:text-gray-300"
                                    >
                                        {{ item.evaluator_name }}
                                    </div>
                                    <div class="text-xs text-gray-400 italic">
                                        {{ item.evaluator_designation }}
                                    </div>
                                </td>

                                <td class="px-6 py-4 text-center">
                                    <span
                                        :class="[
                                            'px-3 py-1 rounded-lg text-xs font-black tracking-tighter',
                                            getScoreClass(
                                                calculateAverage(item)
                                            ),
                                        ]"
                                    >
                                        {{ calculateAverage(item) }} / 5.0
                                    </span>
                                </td>

                                <td
                                    class="px-6 py-4 text-sm font-medium text-gray-500"
                                >
                                    {{
                                        new Date(
                                            item.created_at
                                        ).toLocaleDateString("en-US", {
                                            month: "short",
                                            day: "numeric",
                                            year: "numeric",
                                        })
                                    }}
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <Link
                                        :href="
                                            route('admin.evaluations.show', {
                                                id: item.id,
                                            })
                                        "
                                        class="inline-flex items-center px-4 py-2 bg-gray-50 dark:bg-gray-700 text-[#5521B5] dark:text-indigo-300 text-xs font-black uppercase tracking-widest rounded-xl hover:bg-[#5521B5] hover:text-white transition-all"
                                    >
                                        {{ __("View Detail") }}
                                    </Link>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div
                        v-if="evaluations.length === 0"
                        class="px-6 py-20 text-center"
                    >
                        <div
                            class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gray-50 mb-4 text-gray-300"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                class="w-8 h-8"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor font-bold"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                />
                            </svg>
                        </div>
                        <p
                            class="text-gray-400 font-bold uppercase tracking-widest text-xs"
                        >
                            {{ __("No evaluations found.") }}
                        </p>
                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
