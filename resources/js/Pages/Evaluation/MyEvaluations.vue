<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";
import { ref, watch } from "vue";

// 1. Evaluations is now an Object because of Pagination
const props = defineProps({
    evaluations: Object,
    filters: Object,
});

const selectedMonth = ref(props.filters?.month || '');

watch(selectedMonth, (value) => {
    router.get(route('evaluations.mine'), { month: value }, {
        preserveState: true,
        preserveScroll: true,
        replace: true
    });
});

const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString(undefined, options);
};
</script>

<template>

    <Head :title="__('My Evaluations')" />

    <AuthenticatedLayout>
        <template #tabs></template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">

                    <div class="flex flex-col sm:flex-row justify-between items-center mb-6">
                        <div class="flex items-center gap-2">
                            <h1 class="card-header !mb-0">{{ __('My Performance Evaluations') }}</h1>
                            <span class="bg-gray-100 text-gray-600 text-xs font-bold px-2 py-1 rounded-full">
                                {{ evaluations.total }}
                            </span>
                        </div>

                        <div class="mt-4 sm:mt-0 flex items-center gap-2">
                            <label class="text-sm text-gray-600">{{ __('Filter by Month:') }}</label>
                            <input type="month" v-model="selectedMonth"
                                class="border-gray-300 focus:border-purple-500 focus:ring-purple-500 rounded-md shadow-sm text-sm">
                            <button v-if="selectedMonth" @click="selectedMonth = ''"
                                class="text-xs text-red-500 hover:text-red-700 underline ml-2">
                                {{ __('Clear') }}
                            </button>
                        </div>
                    </div>

                    <div v-if="evaluations.data.length === 0"
                        class="text-center py-10 text-gray-500 bg-gray-50 rounded-lg border border-dashed border-gray-300">
                        <p v-if="selectedMonth">
                            {{ __('No evaluations found for this month.') }}
                        </p>
                        <p v-else>
                            {{ __('You have not received any evaluations yet.') }}
                        </p>
                    </div>

                    <div v-else class="overflow-x-auto relative rounded-lg border border-gray-200">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 border-b">
                                <tr>
                                    <th scope="col" class="py-3 px-6">{{ __('Date') }}</th>
                                    <th scope="col" class="py-3 px-6">{{ __('Evaluator') }}</th>
                                    <th scope="col" class="py-3 px-6">{{ __('Avg Rating') }}</th>
                                    <th scope="col" class="py-3 px-6">{{ __('Designation') }}</th>
                                    <th scope="col" class="py-3 px-6 text-right">{{ __('Action') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="evalItem in evaluations.data" :key="evalItem.id"
                                    class="bg-white border-b hover:bg-gray-50">
                                    <td class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">
                                        {{ formatDate(evalItem.created_at) }}
                                    </td>
                                    <td class="py-4 px-6">
                                        {{ evalItem.evaluator ? evalItem.evaluator.name : 'Unknown' }}
                                    </td>

                                    <td class="py-4 px-6">
                                        <span class="text-xs font-bold px-2 py-1 rounded border" :class="{
                                            'bg-green-100 text-green-800 border-green-200': evalItem.avg_score >= 4,
                                            'bg-yellow-100 text-yellow-800 border-yellow-200': evalItem.avg_score >= 2.5 && evalItem.avg_score < 4,
                                            'bg-red-100 text-red-800 border-red-200': evalItem.avg_score < 2.5
                                        }">
                                            {{ evalItem.avg_rating || evalItem.avg_score || 0 }} ★
                                        </span>
                                    </td>

                                    <td class="py-4 px-6">
                                        <span
                                            class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded">
                                            {{ evalItem.evaluator_designation || 'N/A' }}
                                        </span>
                                    </td>
                                    <td class="py-4 px-6 text-right">
                                        <Link :href="route('evaluations.show', evalItem.id)"
                                            class="font-medium text-purple-600 hover:text-purple-800 hover:underline">
                                            {{ __('View Report') }}
                                        </Link>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <div v-if="evaluations.links.length > 3"
                            class="px-6 py-4 flex items-center justify-between border-t border-gray-200 bg-gray-50">
                            <div class="flex-1 flex justify-between sm:hidden">
                                <Link v-if="evaluations.prev_page_url" :href="evaluations.prev_page_url"
                                    class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                    Previous </Link>
                                <Link v-if="evaluations.next_page_url" :href="evaluations.next_page_url"
                                    class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                    Next </Link>
                            </div>
                            <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-center">
                                <div>
                                    <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                                        aria-label="Pagination">
                                        <template v-for="(link, key) in evaluations.links" :key="key">
                                            <div v-if="link.url === null"
                                                class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 cursor-default"
                                                v-html="link.label" />
                                            <Link v-else :href="link.url"
                                                class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium hover:bg-gray-50"
                                                :class="{
                                                    'z-10 bg-indigo-50 border-indigo-500 text-indigo-600': link.active,
                                                    'text-gray-500': !link.active
                                                }">
                                                <span v-html="link.label"></span>
                                            </Link>

                                        </template>
                                    </nav>
                                </div>
                            </div>
                        </div>

                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
