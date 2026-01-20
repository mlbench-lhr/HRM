<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import Card from "@/Components/Card.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { __ } from "@/Composables/useTranslations.js";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";

const props = defineProps({
    teamLeads: Array,
    employees: Array,
});

const form = useForm({
    name: '',
    team_lead_id: '',
    members: [],
});

const submit = () => {
    form.post(route('teams.store'));
};
</script>

<template>

    <Head :title="__('Create Team')" />
    <AuthenticatedLayout>
        <template #tabs>
            <GoBackNavLink />
        </template>

        <div class="py-8">
            <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <h1 class="card-header !mb-6">{{ __('Create New Team') }}</h1>

                    <form @submit.prevent="submit" class="space-y-6">

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Team Name') }}</label>
                            <input v-model="form.name" type="text"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5"
                                required :placeholder="__('e.g. Marketing Squad')">
                            <div v-if="form.errors.name" class="text-red-500 text-sm mt-1">{{ form.errors.name }}</div>
                        </div>

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Assign Team Lead')
                            }}</label>
                            <select v-model="form.team_lead_id"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5"
                                required>
                                <option value="" disabled>{{ __('Select a leader...') }}</option>
                                <option v-for="lead in teamLeads" :key="lead.id" :value="lead.id">
                                    {{ lead.name }}
                                </option>
                            </select>
                            <div v-if="form.errors.team_lead_id" class="text-red-500 text-sm mt-1">{{
                                form.errors.team_lead_id
                            }}</div>
                        </div>

                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900">{{ __('Add Members') }}</label>
                            <p class="text-xs text-gray-500 mb-2">{{ __(`Hold Ctrl (Windows) or Cmd (Mac) to select
                                multiple
                                users.`) }}</p>

                            <select v-model="form.members" multiple
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-purple-500 focus:border-purple-500 block w-full p-2.5 h-48">
                                <option v-for="emp in employees" :key="emp.id" :value="emp.id">
                                    {{ emp.name }} ({{ emp.email }})
                                </option>
                            </select>
                            <p class="mt-1 text-sm text-gray-500">{{ __('Selected users:') }} {{ form.members.length }}
                            </p>
                        </div>

                        <div class="flex justify-end">
                            <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                {{ __('Save Team') }}
                            </PrimaryButton>
                        </div>
                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
