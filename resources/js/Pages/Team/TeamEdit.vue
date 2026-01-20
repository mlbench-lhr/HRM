<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import Card from "@/Components/Card.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { __ } from "@/Composables/useTranslations.js";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";

const props = defineProps({
    team: Object,         // The Team Object
    teamLeads: Array,     // All Leads
    employees: Array,     // Available Employees + Current Members
    currentMembers: Array // Array of IDs [1, 5, 8] passed from controller
});

// Pre-fill the form with existing data
const form = useForm({
    name: props.team.name,
    team_lead_id: props.team.team_lead_id,
    members: props.currentMembers, // This pre-selects the items in the multi-select
});

const submit = () => {
    form.put(route('teams.update', props.team.id));
};
</script>

<template>

    <Head :title="__('Edit Team')" />
    <AuthenticatedLayout>
        <template #tabs>
            <GoBackNavLink />
        </template>

        <div class="py-8">
            <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <h1 class="card-header !mb-6">{{ __('Edit Team') }}: {{ team.name }}</h1>

                    <form @submit.prevent="submit" class="space-y-6">

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Team Name') }}</label>
                            <input v-model="form.name" type="text"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5"
                                required>
                            <div v-if="form.errors.name" class="text-red-500 text-sm mt-1">{{ form.errors.name }}</div>
                        </div>

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Assign Team Lead')
                                }}</label>
                            <select v-model="form.team_lead_id"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5"
                                required>
                                <option v-for="lead in teamLeads" :key="lead.id" :value="lead.id">
                                    {{ lead.name }}
                                </option>
                            </select>
                            <div v-if="form.errors.team_lead_id" class="text-red-500 text-sm mt-1">{{
                                form.errors.team_lead_id
                                }}</div>
                        </div>

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Manage Members')
                                }}</label>
                            <p class="text-xs text-gray-500 mb-2">
                                {{ __(`Hold Ctrl/Cmd to select multiple. Unselecting a user removes them from the
                                team.`) }}
                            </p>

                            <select v-model="form.members" multiple
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5 h-64">
                                <option v-for="emp in employees" :key="emp.id" :value="emp.id">
                                    {{ emp.name }}
                                    <span v-if="emp.team_id === team.id"> ({{ __('Current Member') }})</span>
                                </option>
                            </select>
                            <p class="mt-1 text-sm text-gray-500">{{ __('Selected users:') }} {{ form.members.length }}
                            </p>
                        </div>

                        <div class="flex justify-end gap-4">
                            <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                {{ __('Update Team') }}
                            </PrimaryButton>
                        </div>
                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
