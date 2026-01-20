<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
import Card from "@/Components/Card.vue";
import Table from "@/Components/Table/Table.vue";
import TableHead from "@/Components/Table/TableHead.vue";
import TableBody from "@/Components/Table/TableBody.vue";
import TableRow from "@/Components/Table/TableRow.vue";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";
import { __ } from "@/Composables/useTranslations.js";

const props = defineProps({
    team: Object, // Includes 'leader' and 'members'
});
</script>

<template>

    <Head :title="team.name" />
    <AuthenticatedLayout>
        <template #tabs>
            <GoBackNavLink />
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-3xl font-bold text-gray-800">{{ team.name }}</h1>
                </div>

                <div class="flex flex-col md:flex-row gap-6">

                    <div class="w-full md:w-1/3">
                        <Card class="!mt-0 border-t-4 border-purple-500">
                            <h2 class="text-xl font-bold mb-4 text-gray-700">{{ __('Team Lead') }}</h2>

                            <div v-if="team.leader" class="flex flex-col items-center text-center">
                                <div
                                    class="w-20 h-20 bg-purple-100 rounded-full flex items-center justify-center text-purple-600 text-2xl font-bold mb-3">
                                    {{ team.leader.name.charAt(0) }}
                                </div>
                                <h3 class="text-lg font-bold">{{ team.leader.name }}</h3>
                                <p class="text-gray-500">{{ team.leader.email }}</p>
                                <p class="text-sm text-gray-400 mt-1">{{ __('Leader') }}</p>
                            </div>

                            <div v-else class="text-center py-4 text-gray-500">
                                {{ __('No Team Lead Assigned') }}
                            </div>
                        </Card>
                    </div>

                    <div class="w-full md:w-2/3">
                        <Card class="!mt-0">
                            <h2 class="card-header !mb-4">{{ __('Team Members') }} ({{ team.members.length }})</h2>

                            <div class="overflow-x-auto">
                                <table class="w-full text-sm text-left text-gray-500">
                                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                        <tr>
                                            <th class="px-6 py-3">{{ __('Name') }}</th>
                                            <th class="px-6 py-3">{{ __('Email') }}</th>
                                            <th class="px-6 py-3">{{ __('View') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="member in team.members" :key="member.id"
                                            class="bg-white border-b hover:bg-gray-50">
                                            <td class="px-6 py-4 font-medium text-gray-900">{{ member.name }}</td>
                                            <td class="px-6 py-4">{{ member.email }}</td>
                                            <td class="px-6 py-4">
                                                <Link :href="route('employees.show', { id: member.id })"
                                                    class="text-purple-600 hover:underline">
                                                    {{ __('Profile') }}
                                                </Link>
                                            </td>
                                        </tr>
                                        <tr v-if="team.members.length === 0">
                                            <td colspan="3" class="px-6 py-4 text-center text-gray-400">
                                                {{ __('No members in this team yet.') }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </Card>
                    </div>

                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
