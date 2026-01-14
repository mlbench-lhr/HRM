<script setup>
import NavLink from "@/Components/NavLink.vue";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";
import { __ } from "@/Composables/useTranslations.js";
</script>

<template>
    <GoBackNavLink />

    <div
        v-if="$page.props.auth.user.roles.includes('admin')"
        class="space-x-8 rtl:space-x-reverse sm:flex"
    >
        <NavLink
            :href="route('evaluations.index')"
            :active="route().current('evaluations.index')"
        >
            {{ __("Evaluation List") }}
        </NavLink>

        <NavLink
            :href="route('evaluations.create')"
            :active="route().current('evaluations.create')"
        >
            {{ __("New Evaluation") }}
        </NavLink>

        <NavLink
            :href="route('admin.evaluations')"
            :active="route().current('admin.evaluations')"
        >
            {{ __("All Records") }}
        </NavLink>
    </div>

    <div v-else class="space-x-8 sm:flex">
        <NavLink
            :href="route('evaluations.index')"
            :active="route().current('evaluations.index')"
        >
            {{ __("My Evaluations") }}
        </NavLink>

        <NavLink
            :href="route('evaluations.create')"
            :active="route().current('evaluations.create')"
        >
            {{ __("Submit Evaluation") }}
        </NavLink>
    </div>
</template>
