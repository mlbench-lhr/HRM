<script setup>
import NavLink from "@/Components/NavLink.vue";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";
import { __ } from "@/Composables/useTranslations.js";
</script>

<template>
    <GoBackNavLink />

    <div v-if="$page.props.auth.user.roles.includes('admin')" class="space-x-8 rtl:space-x-reverse sm:flex">
        <NavLink :href="route('teams.index')"
            :active="route().current('teams.index') || route().current('teams.show') || route().current('teams.edit')">
            {{ __('All Teams') }}
        </NavLink>
        <NavLink :href="route('teams.create')" :active="route().current('teams.create')">
            {{ __('Create New Team') }}
        </NavLink>
    </div>

    <div v-else class="space-x-8 rtl:space-x-reverse sm:flex">
        <NavLink :href="route('teams.index')" :active="route().current('teams.index') || route().current('teams.show')">
            {{ __('Teams List') }}
        </NavLink>
    </div>
</template>
