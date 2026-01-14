<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

const props = defineProps({
    peerFeedbacks: Object,
});

// Helper to color-code the average rating
const getScoreClass = (score) => {
    if (score >= 4.5)
        return "bg-emerald-100 text-emerald-700 border border-emerald-200";
    if (score >= 3.5)
        return "bg-purple-50 text-purple-700 border border-purple-200";
    if (score >= 2.5)
        return "bg-amber-100 text-amber-700 border border-amber-200";
    return "bg-rose-100 text-rose-700 border border-rose-200";
};
</script>

<template>
    <Head title="Peer Feedback Overview" />

    <AuthenticatedLayout>
        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mb-6 flex justify-between items-center">
                    <h1
                        class="text-2xl font-bold text-gray-800 dark:text-white tracking-tight"
                    >
                        {{ __("Peer Feedback") }}
                    </h1>
                </div>

                <Card
                    class="overflow-hidden shadow-xl rounded-2xl border-none !p-0"
                >
                    <table class="w-full text-left border-collapse">
                        <thead
                            class="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700"
                        >
                            <tr>
                                <th
                                    class="px-6 py-3 text-xs font-black uppercase text-gray-400"
                                >
                                    Employee
                                </th>
                                <th
                                    class="px-6 py-3 text-xs font-black uppercase text-gray-400"
                                >
                                    Evaluator
                                </th>
                                <th
                                    class="px-6 py-3 text-xs font-black uppercase text-gray-400 text-center"
                                >
                                    Avg. Rating
                                </th>
                                <th
                                    class="px-6 py-3 text-xs font-black uppercase text-gray-400"
                                >
                                    Date
                                </th>
                                <th
                                    class="px-6 py-3 text-xs font-black uppercase text-gray-400 text-right"
                                >
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody
                            class="bg-white dark:bg-gray-800 divide-y divide-gray-100 dark:divide-gray-700"
                        >
                            <tr
                                v-for="item in peerFeedbacks.data"
                                :key="item.id"
                                class="hover:bg-purple-50 dark:hover:bg-gray-700/50 transition-colors group"
                            >
                                <!-- Employee -->
                                <td class="px-6 py-4">
                                    <div
                                        class="font-bold text-gray-900 dark:text-white group-hover:text-purple-700 transition-colors"
                                    >
                                        {{ item.employee?.name }}
                                    </div>
                                    <div
                                        class="text-xs font-medium text-gray-400"
                                    >
                                        ID:  {{ item.employee?.id }}
                                    </div>
                                </td>

                                <!-- Evaluator -->
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

                                <!-- Avg. Rating -->
                                <td class="px-6 py-4 text-center">
                                    <span
                                        :class="[
                                            'px-3 py-1 rounded-lg text-xs font-black tracking-tighter',
                                            getScoreClass(item.avg_rating),
                                        ]"
                                    >
                                        {{ item.avg_rating.toFixed(2) }} / 5.0
                                    </span>
                                </td>

                                <!-- Date -->
                                <td class="px-6 py-4 text-sm text-gray-500">
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

                                <!-- Actions -->
                                <td class="px-6 py-4 text-right">
                                    <Link
                                        :href="
                                            route('peer-feedback.show', {
                                                id: item.id,
                                            })
                                        "
                                        class="inline-flex items-center px-4 py-2 bg-gray-50 dark:bg-gray-700 text-purple-700 dark:text-purple-300 text-xs font-bold uppercase tracking-wide rounded-lg hover:bg-purple-700 hover:text-white transition-all"
                                    >
                                        View Detail
                                    </Link>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Empty state -->
                    <div
                        v-if="peerFeedbacks.data.length === 0"
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
                                stroke="currentColor"
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
                            {{ __("No peer feedback found.") }}
                        </p>
                    </div>

                    <!-- Pagination -->
                    <div class="px-6 py-4 flex justify-end space-x-2">
                        <button
                            v-if="peerFeedbacks.prev_page_url"
                            @click="$inertia.get(peerFeedbacks.prev_page_url)"
                            class="px-3 py-1 bg-gray-200 dark:bg-gray-700 rounded hover:bg-gray-300 dark:hover:bg-gray-600 transition"
                        >
                            Previous
                        </button>
                        <button
                            v-if="peerFeedbacks.next_page_url"
                            @click="$inertia.get(peerFeedbacks.next_page_url)"
                            class="px-3 py-1 bg-gray-200 dark:bg-gray-700 rounded hover:bg-gray-300 dark:hover:bg-gray-600 transition"
                        >
                            Next
                        </button>
                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
