<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

defineProps({
    interviews: Object // Pagination Object
});

const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString("en-US", {
        year: 'numeric', month: 'short', day: 'numeric'
    });
};

const getScoreClass = (score) => {
    // Max score is 25.
    // >20 (80%) is Good (Green), >12 (50%) is Average (Yellow), else Red
    if (score >= 20) return "bg-emerald-100 text-emerald-700 border-emerald-200";
    if (score >= 13) return "bg-amber-100 text-amber-700 border-amber-200";
    return "bg-rose-100 text-rose-700 border-rose-200";
};
</script>

<template>

    <Head :title="__('Interview Records')" />
    <AuthenticatedLayout>
        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800 dark:text-white">{{ __("Interview Records") }}</h1>
                    <Link :href="route('interviews.create')"
                        class="px-4 py-2 bg-indigo-600 text-white rounded-lg text-sm font-bold hover:bg-indigo-700">
                        {{ __("+ New Interview") }}
                    </Link>
                </div>

                <Card class="!p-0 overflow-hidden shadow-xl border-none">
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-gray-50 dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
                            <tr>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400">{{ __("Date") }}</th>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400">{{ __("Candidate") }}
                                </th>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400">{{ __("Position") }}
                                </th>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400">{{ __("Interviewer") }}
                                </th>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400 text-center">{{
                                    __("Score") }}</th>
                                <th class="px-6 py-4 text-xs font-black uppercase text-gray-400 text-center">{{
                                    __("Result") }}</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50 dark:divide-gray-700 bg-white dark:bg-gray-800">
                            <tr v-for="item in interviews.data" :key="item.id"
                                class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                <td class="px-6 py-4 text-sm font-medium text-gray-500">
                                    {{ formatDate(item.interview_date) }}
                                </td>
                                <td class="px-6 py-4 font-bold text-gray-900 dark:text-white">
                                    {{ item.candidate_name }}
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">
                                    {{ item.position }}
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-500">
                                    {{ item.interviewer_name }}
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span
                                        :class="['px-2 py-1 rounded text-xs font-bold border', getScoreClass(item.total_score)]">
                                        {{ item.total_score }} / 25
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span v-if="item.is_recommended"
                                        class="text-emerald-600 font-bold text-xs uppercase bg-emerald-50 px-2 py-1 rounded">
                                        {{ __("Recommended") }}
                                    </span>
                                    <span v-else
                                        class="text-rose-600 font-bold text-xs uppercase bg-rose-50 px-2 py-1 rounded">
                                        {{ __("Rejected") }}
                                    </span>
                                </td>
                            </tr>
                            <tr v-if="interviews.data.length === 0">
                                <td colspan="6" class="px-6 py-8 text-center text-gray-400">
                                    {{ __("No interview records found.") }}
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div v-if="interviews.links.length > 3" class="px-6 py-4 border-t border-gray-100 bg-gray-50">
                        <div class="flex justify-center">
                            <Link v-for="(link, k) in interviews.links" :key="k" v-html="link.label"
                                :href="link.url || '#'" class="px-3 py-1 mx-1 border rounded text-sm"
                                :class="link.active ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-white text-gray-600 hover:bg-gray-100'" />
                        </div>
                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
