<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, router } from '@inertiajs/vue3';
// IMPORT THE TABS COMPONENT HERE
import TeamTabs from "@/Components/Tabs/TeamTabs.vue";
import SearchBar from "@/Components/SearchBar.vue";
import FlexButton from "@/Components/FlexButton.vue";
import { ref, watch } from "vue";
import debounce from "lodash.debounce";
import Table from "@/Components/Table/Table.vue";
import TableHead from "@/Components/Table/TableHead.vue";
import TableBody from "@/Components/Table/TableBody.vue";
import TableBodyHeader from "@/Components/Table/TableBodyHeader.vue";
import TableBodyAction from "@/Components/Table/TableBodyAction.vue";
import TableRow from "@/Components/Table/TableRow.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";

// Props coming from the Controller
const props = defineProps({
    teams: Object,
});

// Search and Sort Logic
const term = ref('');
const sort = ref('id');
const sort_dir = ref(true);

const search = debounce(() => {
    router.visit(route('teams.index', { term: term.value, sort: sort.value, sort_dir: sort_dir.value }),
        { preserveState: true, preserveScroll: true })
}, 400);

watch(term, search);
watch(sort, search);
watch(sort_dir, search);
</script>

<template>

    <Head :title="__('Teams')" />
    <AuthenticatedLayout>
        <template #tabs>
            <TeamTabs />
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <h1 class="card-header !mb-4">{{ __('Manage Teams') }}</h1>

                    <div class="flex justify-between items-center gap-4 pb-4">
                        <FlexButton :href="route('teams.create')" :text="__('Create New Team')">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                stroke="currentColor" class="w-5 h-5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                            </svg>
                        </FlexButton>

                        <SearchBar>
                            <input type="text" v-model="term" class="input-class" :placeholder="__('Search teams...')">
                        </SearchBar>
                    </div>

                    <Table :links="teams.links" :showingNumber="teams.data.length" :totalNumber="teams.total">
                        <template #Head>
                            <TableHead @click="sort = 'id'; sort_dir = !sort_dir;" sortable>{{ __('ID') }} ↕</TableHead>
                            <TableHead @click="sort = 'name'; sort_dir = !sort_dir;" sortable>{{ __('Team Name') }} ↕
                            </TableHead>
                            <TableHead>{{ __('Team Lead') }}</TableHead>
                            <TableHead>{{ __('Members') }}</TableHead>
                            <TableHead>{{ __('Action') }}</TableHead>
                        </template>

                        <template #Body>
                            <TableRow v-for="team in teams.data" :key="team.id">

                                <TableBodyHeader :href="route('teams.show', { id: team.id })">
                                    {{ team.id }}
                                </TableBodyHeader>

                                <TableBodyHeader :href="route('teams.show', { id: team.id })">
                                    {{ team.name }}
                                </TableBodyHeader>

                                <TableBody :href="route('teams.show', { id: team.id })">
                                    <span v-if="team.leader"
                                        class="px-2 py-1 bg-purple-100 text-purple-800 rounded-full text-xs">
                                        {{ team.leader.name }}
                                    </span>
                                    <span v-else class="text-gray-400 italic">
                                        {{ __('No Lead') }}
                                    </span>
                                </TableBody>

                                <TableBody :href="route('teams.show', { id: team.id })">
                                    {{ team.members_count || 0 }} {{ __('Members') }}
                                </TableBody>

                                <TableBodyAction :href="route('teams.edit', { team: team.id })"
                                    class="text-indigo-600 hover:text-indigo-900">
                                    {{ __('Edit') }}
                                </TableBodyAction>

                            </TableRow>
                        </template>
                    </Table>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
