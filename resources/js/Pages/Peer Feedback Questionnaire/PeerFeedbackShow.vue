<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

const props = defineProps({ peerFeedback: Object });

// Group ratings into categories
const collaborationMetrics = [
    { label: "Collaboration", key: "collaboration" },
    { label: "Supportiveness", key: "supportiveness" },
    { label: "Respect", key: "respect" },
    { label: "Communication", key: "communication" },
    { label: "Responsiveness", key: "responsiveness" },
    { label: "Openness to Feedback", key: "openness_to_feedback" },
];

const behaviorMetrics = [
    { label: "Attitude", key: "attitude" },
    { label: "Conflict Handling", key: "conflict_handling" },
    { label: "Dependability", key: "dependability" },
    { label: "Accountability", key: "accountability" },
    { label: "Professionalism", key: "professionalism" },
    { label: "Team Impact", key: "team_impact" },
    { label: "Overall Team Member", key: "overall_team_member" },
    { label: "Would Work Again", key: "work_again" },
];

// Color code avg rating
const getScoreClass = (score) => {
    if (score >= 4.5)
        return "bg-emerald-100 text-emerald-700 border border-emerald-200";
    if (score >= 3.5)
        return "bg-indigo-100 text-indigo-700 border border-indigo-200";
    if (score >= 2.5)
        return "bg-amber-100 text-amber-700 border border-amber-200";
    return "bg-rose-100 text-rose-700 border border-rose-200";
};
function printReport() {
    if (typeof window !== "undefined") {
        window.print();
    }
}
</script>

<template>
    <Head :title="__('Peer Feedback Report')" />
    <AuthenticatedLayout>
        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center mb-8">
                    <Link
                        :href="route('admin.peer-feedback.index')"
                        class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-indigo-600 transition-colors group"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="w-4 h-4 mr-1 transform group-hover:-translate-x-1 transition-transform"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M15 19l-7-7 7-7"
                            />
                        </svg>
                        {{ __("Back to Peer Feedback") }}
                    </Link>

                    <!-- <button
                        @click="printReport"
                        class="text-sm text-indigo-600 font-medium hover:underline print:hidden"
                    >
                        {{ __("Print Report") }}
                    </button> -->
                </div>

                <Card class="!p-0 overflow-hidden shadow-xl border-none">
                    <div
                        class="bg-gradient-to-br from-indigo-800 to-slate-700 p-8 border-b border-white/10 shadow-lg"
                    >
                        <div
                            class="flex flex-col md:flex-row justify-between items-start md:items-end gap-4"
                        >
                            <div>
                                <span
                                    class="inline-block px-2 py-1 mb-3 text-[10px] font-bold tracking-[0.15em] text-indigo-300 uppercase bg-indigo-500/20 border border-indigo-500/30 rounded shadow-sm"
                                >
                                    {{ __("Peer Feedback Record") }}
                                </span>
                                <h2
                                    class="text-4xl font-extrabold text-white tracking-tight italic"
                                >
                                    {{ peerFeedback.employee?.name }}
                                </h2>
                                <p
                                    class="text-indigo-200/60 mt-1 font-medium text-sm tracking-wide"
                                >
                                    {{ __("Peer Feedback Evaluation") }}
                                </p>
                            </div>

                            <div
                                class="text-left md:text-right border-l-2 md:border-l-0 md:border-r-2 border-indigo-500/40 pl-4 md:pl-0 md:pr-4 py-1"
                            >
                                <p
                                    class="text-[10px] text-indigo-300 uppercase font-black tracking-widest opacity-70"
                                >
                                    {{ __("Submitted On") }}
                                </p>
                                <p
                                    class="text-xl font-medium text-white font-mono"
                                >
                                    {{
                                        new Date(
                                            peerFeedback.created_at
                                        ).toLocaleDateString("en-US", {
                                            month: "long",
                                            day: "numeric",
                                            year: "numeric",
                                        })
                                    }}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="p-8 space-y-10">
                        <div
                            class="flex flex-wrap gap-8 mb-10 pb-8 border-b border-gray-100 dark:border-gray-700"
                        >
                            <div>
                                <p
                                    class="text-xs text-gray-400 uppercase font-bold mb-1"
                                >
                                    {{ __("Evaluator") }}
                                </p>
                                <p
                                    class="text-gray-900 dark:text-white font-medium"
                                >
                                    {{ peerFeedback.evaluator_name }}
                                </p>
                            </div>
                            <div>
                                <p
                                    class="text-xs text-gray-400 uppercase font-bold mb-1"
                                >
                                    {{ __("Designation") }}
                                </p>
                                <p
                                    class="text-gray-900 dark:text-white font-medium"
                                >
                                    {{ peerFeedback.evaluator_designation }}
                                </p>
                            </div>
                            <div>
                                <p
                                    class="text-xs text-gray-400 uppercase font-bold mb-1"
                                >
                                    {{ __("Average Rating") }}
                                </p>
                                <span
                                    :class="[
                                        'px-3 py-1 rounded-lg text-xs font-black tracking-tighter',
                                        getScoreClass(peerFeedback.avg_rating),
                                    ]"
                                >
                                    {{ peerFeedback.avg_rating }}/5
                                </span>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                            <div>
                                <h3
                                    class="text-sm font-black text-purple-600 uppercase tracking-tighter mb-6 flex items-center"
                                >
                                    <span
                                        class="w-8 h-[2px] bg-purple-600 mr-2"
                                    ></span>
                                    {{ __("Collaboration Metrics") }}
                                </h3>
                                <div class="space-y-5">
                                    <div
                                        v-for="metric in collaborationMetrics"
                                        :key="metric.key"
                                        class="group"
                                    >
                                        <div class="flex justify-between mb-2">
                                            <span
                                                class="text-sm font-medium text-gray-700 dark:text-gray-300"
                                                >{{ __(metric.label) }}</span
                                            >
                                            <span
                                                class="text-sm font-bold text-purple-600"
                                                >{{
                                                    peerFeedback[metric.key]
                                                }}/5</span
                                            >
                                        </div>
                                        <div
                                            class="w-full bg-gray-100 dark:bg-gray-700 h-2 rounded-full overflow-hidden"
                                        >
                                            <div
                                                class="bg-purple-500 h-full rounded-full transition-all duration-1000"
                                                :style="{
                                                    width:
                                                        (peerFeedback[
                                                            metric.key
                                                        ] /
                                                            5) *
                                                            100 +
                                                        '%',
                                                }"
                                            ></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <h3
                                    class="text-sm font-black text-indigo-600 uppercase tracking-tighter mb-6 flex items-center"
                                >
                                    <span
                                        class="w-8 h-[2px] bg-indigo-600 mr-2"
                                    ></span>
                                    {{ __("Behavior & Teamwork") }}
                                </h3>
                                <div class="space-y-5">
                                    <div
                                        v-for="metric in behaviorMetrics"
                                        :key="metric.key"
                                        class="group"
                                    >
                                        <div class="flex justify-between mb-2">
                                            <span
                                                class="text-sm font-medium text-gray-700 dark:text-gray-300"
                                                >{{ __(metric.label) }}</span
                                            >
                                            <span
                                                class="text-sm font-bold text-indigo-600"
                                                >{{
                                                    peerFeedback[metric.key]
                                                }}/5</span
                                            >
                                        </div>
                                        <div
                                            class="w-full bg-gray-100 dark:bg-gray-700 h-2 rounded-full overflow-hidden"
                                        >
                                            <div
                                                class="bg-indigo-500 h-full rounded-full transition-all duration-1000"
                                                :style="{
                                                    width:
                                                        (peerFeedback[
                                                            metric.key
                                                        ] /
                                                            5) *
                                                            100 +
                                                        '%',
                                                }"
                                            ></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div
                            v-if="peerFeedback.peer_comments"
                            class="mt-12 pt-10 border-t border-gray-100 dark:border-gray-700"
                        >
                            <label
                                class="text-[10px] font-black text-purple-600 uppercase tracking-widest block mb-2"
                                >{{ __("Peer Comments") }}</label
                            >
                            <p
                                class="text-lg text-gray-800 dark:text-gray-200 font-medium leading-relaxed italic"
                            >
                                "{{ peerFeedback.peer_comments }}"
                            </p>
                        </div>
                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
@media print {
    .bg-gray-50 {
        background-color: white !important;
    }
    .max-w-5xl {
        max-width: 100% !important;
        margin: 0 !important;
    }
    .shadow-xl {
        box-shadow: none !important;
    }
}
</style>
