<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head } from "@inertiajs/vue3";
import { computed } from "vue";
import FlexButton from "@/Components/FlexButton.vue";
import { onBeforeMount } from "vue";
import OrgTabs from "@/Components/Tabs/OrgTabs.vue";
import { getQueryVariable } from "@/Composables/getQueryVariable.js";
import dayjs from "dayjs";
import Card from "@/Components/Card.vue";
import ModifyIcon from "@/Components/Icons/ModifyIcon.vue";
import DescriptionList from "@/Components/DescriptionList/DescriptionList.vue";
import DT from "@/Components/DescriptionList/DT.vue";
import DD from "@/Components/DescriptionList/DD.vue";
import DescriptionListItem from "@/Components/DescriptionList/DescriptionListItem.vue";

const props = defineProps({
    globals: Object,
    href: String,
});

onBeforeMount(() => {
    if (getQueryVariable("reload") === "1") {
        dayjs.tz.setDefault(props.globals.timezone);
    }
});
const organizationIps = computed(() => {
    const v = props.globals?.ip;

    if (!v || !Array.isArray(v)) return "";

    return v.join(", ");
});
const weekendOffDays = computed(() => {
    const value = props.globals?.weekend_off_days;

    if (!value) return "";

    if (Array.isArray(value)) {
        return value
            .map((d) =>
                String(d)
                    .trim()
                    .replace(/^\w/, (c) => c.toUpperCase())
            )
            .join(", ");
    }

    if (typeof value === "string") {
        return value
            .split(",")
            .map((d) => d.trim().replace(/^\w/, (c) => c.toUpperCase()))
            .join(", ");
    }

    return "";
});
</script>

<template>
    <Head :title="__('Organization Data')" />
    <AuthenticatedLayout>
        <template #tabs>
            <OrgTabs />
        </template>
        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <div>
                        <div class="flex justify-between items-center mb-4">
                            <h1 class="card-header !mb-4">
                                {{ __("Organization Details") }}
                            </h1>
                            <div class="flex gap-4">
                                <FlexButton
                                    :text="__('Modify Organization Data')"
                                    :href="route('globals.edit')"
                                >
                                    <ModifyIcon />
                                </FlexButton>
                            </div>
                        </div>
                        <h2 class="card-subheader">{{ __("Basic Info") }}</h2>
                        <DescriptionList>
                            <DescriptionListItem colored>
                                <DT>{{ __("Organization Name") }}</DT>
                                <DD>{{ globals.organization_name }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem colored>
                                <DT>{{ __("Timezone") }}</DT>
                                <DD>{{ globals.timezone }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem>
                                <DT>{{ __("Organization IP Address") }}</DT>
                                <DD>{{
                                    (globals.is_ip_based
                                        ? __("[:status]", {
                                              status: __("Enabled"),
                                          })
                                        : __("[:status]", {
                                              status: __("Disabled"),
                                          })) +
                                    (organizationIps
                                        ? " " + organizationIps
                                        : "")
                                }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem>
                                <DT>{{ __("Email") }}</DT>
                                <DD>{{ globals.email }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem colored>
                                <DT>{{ __("Address") }}</DT>
                                <DD>{{ globals.organization_address }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem colored>
                                <DT>{{ __("Absence Limit (Per Year)") }}</DT>
                                <DD>{{
                                    globals.absence_limit + " " + __("Days")
                                }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem>
                                <DT>{{ __("Weekend Off Days") }}</DT>
                                <DD>{{ weekendOffDays }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem>
                                <DT>{{ __("Payroll Day") }}</DT>
                                <DD>{{
                                    globals.payroll_day +
                                    " " +
                                    __("of the month")
                                }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem colored>
                                <DT>{{ __("Income Tax Percentage") }}</DT>
                                <DD>{{ globals.income_tax + "%" }}</DD>
                            </DescriptionListItem>

                            <DescriptionListItem colored>
                                <DT></DT>
                                <DD></DD>
                            </DescriptionListItem>
                        </DescriptionList>
                    </div>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
