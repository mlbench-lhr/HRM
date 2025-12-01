<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head } from "@inertiajs/vue3";
import { computed } from "vue";
import EmployeeTabs from "@/Components/Tabs/EmployeeTabs.vue";
import FlexButton from "@/Components/FlexButton.vue";
import { useExtractPersonalDetails } from "@/Composables/useExtractPersonalDetails.js";
import { useAgeCalculator } from "@/Composables/useAgeCalculator.js";
import Card from "@/Components/Card.vue";
import ModifyIcon from "@/Components/Icons/ModifyIcon.vue";
import DescriptionList from "@/Components/DescriptionList/DescriptionList.vue";
import DT from "@/Components/DescriptionList/DT.vue";
import DD from "@/Components/DescriptionList/DescriptionListItem.vue";
import DescriptionListItem from "@/Components/DescriptionList/DescriptionListItem.vue";
import GenericModal from "@/Components/GenericModal.vue";
import Table from "@/Components/Table/Table.vue";
import TableBody from "@/Components/Table/TableBody.vue";
import TableHead from "@/Components/Table/TableHead.vue";
import TableRow from "@/Components/Table/TableRow.vue";
import ToolTip from "@/Components/ToolTip.vue";
import HistoryDescriptionList from "@/Components/DescriptionList/HistoryDescriptionList.vue";
import { __ } from "@/Composables/useTranslations.js";

let { extractPersonalDetails } = useExtractPersonalDetails();

const props = defineProps({
    employee: Object,
});

const leaves = computed(() => props.employee?.leave_requests ?? []);

const computedManages = computed(() => {
    const list = props.employee?.manages ?? [];

    const filtered = list
        .map((x) => ({
            department_id: x.department_id,
            branch_id: x.branch_id,
        }))
        .filter((x) => x.department_id || x.branch_id);

    const branches = filtered
        .map((x) => x.branch_id)
        .filter(Boolean)
        .join(", ");
    const departments = filtered
        .map((x) => x.department_id)
        .filter(Boolean)
        .join(", ");

    let r = "";
    if (branches) r += __("Branches") + `: #${branches}`;
    if (departments)
        r += (r ? " - " : "") + __("Departments") + `: #${departments}`;

    return r;
});
</script>

<template>
    <Head :title="__('Employee View')" />
    <AuthenticatedLayout>
        <template #tabs>
            <EmployeeTabs />
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <div class="flex justify-between items-center mb-4">
                        <h1 class="card-header">
                            {{
                                __("Employee View :ifAdmin", {
                                    ifAdmin: props.employee.manages?.length
                                        ? "(" + __("Manager") + ")"
                                        : "",
                                })
                            }}
                        </h1>

                        <div class="flex inline-flex gap-4">
                            <FlexButton
                                v-if="
                                    $page.props.auth.user.roles.includes(
                                        'admin'
                                    )
                                "
                                :text="__('Modify Employee Data')"
                                :href="
                                    route('employees.edit', {
                                        id: props.employee.id,
                                    })
                                "
                            >
                                <ModifyIcon />
                            </FlexButton>

                            <FlexButton
                                v-else
                                :text="__('Modify Data')"
                                :href="
                                    route('profile.edit', {
                                        id: props.employee.id,
                                    })
                                "
                            >
                                <ModifyIcon />
                            </FlexButton>
                        </div>
                    </div>

                    <h2 class="card-subheader">{{ __("Basic Info") }}</h2>
                    <DescriptionList>
                        <DescriptionListItem colored>
                            <DT>{{ __("Name") }}</DT>
                            <DD>{{ props.employee.name }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("ID") }}</DT>
                            <DD>{{ props.employee.id }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Phone") }}</DT>
                            <DD
                                ><a :href="'tel:' + props.employee.phone">{{
                                    props.employee.phone
                                }}</a></DD
                            >
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("National ID") }}</DT>
                            <DD>{{ props.employee.national_id }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Email") }}</DT>
                            <DD
                                ><a :href="'mailto:' + props.employee.email">{{
                                    props.employee.email
                                }}</a></DD
                            >
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Gender") }}</DT>
                            <DD>
                                {{
                                    extractPersonalDetails(
                                        props.employee.national_id
                                    ).isMale
                                        ? __("Male")
                                        : __("Female")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Bank Account Details") }}</DT>
                            <DD>{{
                                props.employee.bank_acc_no ?? __("N/A")
                            }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Birthday") }}</DT>
                            <DD>
                                {{
                                    extractPersonalDetails(
                                        props.employee.national_id
                                    ).date_localized +
                                    " - " +
                                    useAgeCalculator(
                                        extractPersonalDetails(
                                            props.employee.national_id
                                        ).date
                                    ) +
                                    " " +
                                    __("Years")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Hire Date") }}</DT>
                            <DD>{{ props.employee.hired_on }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Remote Worker?") }}</DT>
                            <DD>{{
                                props.employee.is_remote ? __("Yes") : __("No")
                            }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Address") }}</DT>
                            <DD>
                                <a
                                    :href="
                                        'https://www.google.com/maps/search/?api=1&query=' +
                                        props.employee.address
                                    "
                                    target="_blank"
                                >
                                    {{ props.employee.address }}
                                </a>
                            </DD>
                        </DescriptionListItem>
                    </DescriptionList>
                </Card>

                <Card>
                    <h2 class="mb-2 ml-1 font-semibold">
                        {{ __("Technical Info") }}
                    </h2>

                    <DescriptionList>
                        <DescriptionListItem colored>
                            <DT>{{ __("Branch") }}</DT>
                            <DD>{{
                                props.employee.branch?.name ?? __("N/A")
                            }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Department") }}</DT>
                            <DD>{{
                                props.employee.department?.name ?? __("N/A")
                            }}</DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Salary") }}</DT>
                            <DD>
                                {{
                                    props.employee.salaries?.length
                                        ? props.employee.salaries
                                              .at(-1)
                                              .salary.toLocaleString() +
                                          " " +
                                          props.employee.salaries.at(-1)
                                              .currency
                                        : __("N/A")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Position") }}</DT>
                            <DD>
                                {{
                                    props.employee.employee_positions?.length
                                        ? props.employee.employee_positions.at(
                                              -1
                                          ).position?.name ?? __("N/A")
                                        : __("N/A")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Shift") }}</DT>
                            <DD>
                                {{
                                    props.employee.employee_shifts?.length
                                        ? props.employee.employee_shifts
                                              .filter(
                                                  (x) => x.end_date === null
                                              )
                                              .map((x) => x.shift?.name)[0] ??
                                          __("N/A")
                                        : __("N/A")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem colored>
                            <DT>{{ __("Access Permissions") }}</DT>
                            <DD>
                                {{
                                    props.employee.roles?.length
                                        ? props.employee.roles
                                              .at(-1)
                                              .name.replace(/_/g, " ")
                                              .replace(/\b\w/g, (m) =>
                                                  m.toUpperCase()
                                              )
                                        : __("Not Assigned")
                                }}
                            </DD>
                        </DescriptionListItem>

                        <DescriptionListItem>
                            <DT>{{ __("Manages") }}</DT>
                            <DD>{{
                                props.employee.manages?.length
                                    ? computedManages
                                    : __("Nothing")
                            }}</DD>
                        </DescriptionListItem>
                    </DescriptionList>
                </Card>

                <Card>
                    <h2 class="mb-2 ml-1 font-semibold">
                        {{ __("Leave Allocations") }}
                    </h2>

                    <Table
                        :totalNumber="
                            props.employee.leave_allocations?.length || 0
                        "
                        :enablePaginator="false"
                    >
                        <template #Head>
                            <TableHead>{{ __("Total Leaves") }}</TableHead>
                            <TableHead>{{ __("Casual Leaves") }}</TableHead>
                            <TableHead>{{ __("Sick Leaves") }}</TableHead>
                            <TableHead>{{ __("Used Leaves") }}</TableHead>
                            <TableHead>{{ __("Remaining Leaves") }}</TableHead>
                            <TableHead>{{ __("Unpaid Leaves") }}</TableHead>
                            <TableHead>{{ __("Year") }}</TableHead>
                        </template>

                        <template #Body>
                            <TableRow
                                v-for="allocation in props.employee
                                    .leave_allocations ?? []"
                                :key="allocation.id"
                            >
                                <TableBody>{{
                                    allocation.total_leaves
                                }}</TableBody>
                                <TableBody>{{
                                    allocation.casual_leaves
                                }}</TableBody>
                                <TableBody>{{
                                    allocation.sick_leaves
                                }}</TableBody>
                                <TableBody>{{
                                    allocation.used_leaves
                                }}</TableBody>
                                <TableBody>{{
                                    allocation.remaining_leaves
                                }}</TableBody>
                                <TableBody>{{
                                    allocation.unpaid_leaves
                                }}</TableBody>
                                <TableBody>{{ allocation.year }}</TableBody>
                            </TableRow>
                        </template>
                    </Table>

                    <p
                        v-if="!props.employee.leave_allocations?.length"
                        class="text-center py-4"
                    >
                        {{ __("No leave allocations found") }}
                    </p>
                </Card>

                <Card>
                    <h2 class="mb-2 ml-1 font-semibold">Leave History</h2>

                    <template v-if="leaves?.length">
                        <Table
                            :totalNumber="leaves.length"
                            :enablePaginator="false"
                        >
                            <template #Head>
                                <TableHead>Type</TableHead>
                                <TableHead>From</TableHead>
                                <TableHead>To</TableHead>
                                <TableHead>Duration</TableHead>
                                <TableHead>Half</TableHead>
                                <TableHead>Status</TableHead>
                                <TableHead>Remaining</TableHead>
                                <TableHead>Unpaid</TableHead>
                            </template>

                            <template #Body>
                                <TableRow
                                    v-for="leave in leaves"
                                    :key="leave.id"
                                >
                                    <TableBody>{{
                                        leave.leave_type
                                    }}</TableBody>

                                    <TableBody>{{
                                        leave.start_date ?? "—"
                                    }}</TableBody>

                                    <TableBody>{{
                                        leave.end_date ?? "—"
                                    }}</TableBody>

                                    <TableBody>{{
                                        leave.leave_duration
                                    }}</TableBody>

                                    <TableBody>
                                        <span v-if="leave.half_leave_date">
                                            {{ leave.half_leave_date }} ({{
                                                leave.half_leave_segment
                                            }})
                                        </span>
                                        <span v-else>—</span>
                                    </TableBody>

                                    <TableBody>{{
                                        leave.request?.status ?? "Unknown"
                                    }}</TableBody>

                                    <TableBody>{{
                                        leave.remaining_after
                                    }}</TableBody>

                                    <TableBody>{{
                                        leave.unpaid_leave
                                    }}</TableBody>
                                </TableRow>
                            </template>
                        </Table>
                    </template>

                    <p v-else class="text-center py-4">
                        No leave history found
                    </p>
                </Card>

                <Card>
                    <h2 class="mb-2 ml-1 font-semibold">{{ __("History") }}</h2>

                    <HistoryDescriptionList>
                        <div class="px-4 py-3.5">
                            <dt class="text-sm font-medium">
                                {{ __("Previous Salaries") }}
                            </dt>

                            <GenericModal
                                modalId="Salaries Modal"
                                :title="__('Click Here To See Salary History')"
                                :modalHeader="__('Previous Salaries')"
                                :hasCancel="false"
                            >
                                <Table
                                    :totalNumber="
                                        props.employee.salaries?.length || 0
                                    "
                                    :enablePaginator="false"
                                >
                                    <template #Head>
                                        <TableHead>{{
                                            __("Currency")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Salary")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Starting From")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Ending At")
                                        }}</TableHead>
                                    </template>

                                    <template #Body>
                                        <TableRow
                                            v-for="salary in props.employee
                                                .salaries ?? []"
                                            :key="salary.id"
                                        >
                                            <TableBody>{{
                                                salary.currency
                                            }}</TableBody>
                                            <TableBody>{{
                                                salary.salary
                                            }}</TableBody>
                                            <TableBody>{{
                                                salary.start_date
                                            }}</TableBody>
                                            <TableBody>{{
                                                salary.end_date ?? __("Current")
                                            }}</TableBody>
                                        </TableRow>
                                    </template>
                                </Table>
                            </GenericModal>
                        </div>

                        <div class="px-4 py-3.5">
                            <dt class="text-sm font-medium">
                                {{ __("Previous Positions") }}
                            </dt>

                            <GenericModal
                                modalId="Positions Modal"
                                :title="
                                    __('Click Here To See Positions History')
                                "
                                :modalHeader="__('Previous Positions')"
                                :hasCancel="false"
                            >
                                <Table
                                    :totalNumber="
                                        props.employee.employee_positions
                                            ?.length || 0
                                    "
                                    :enablePaginator="false"
                                >
                                    <template #Head>
                                        <TableHead>{{
                                            __("Position")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Starting From")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Ending At")
                                        }}</TableHead>
                                    </template>

                                    <template #Body>
                                        <TableRow
                                            v-for="position in props.employee
                                                .employee_positions ?? []"
                                            :key="position.id"
                                        >
                                            <TableBody>{{
                                                position.position?.name ??
                                                __("DELETED POSITION")
                                            }}</TableBody>
                                            <TableBody>{{
                                                position.start_date
                                            }}</TableBody>
                                            <TableBody>{{
                                                position.end_date ??
                                                __("Current")
                                            }}</TableBody>
                                        </TableRow>
                                    </template>
                                </Table>
                            </GenericModal>
                        </div>

                        <div class="px-4 py-3.5">
                            <dt class="text-sm font-medium">
                                {{ __("Previous Shifts") }}
                            </dt>

                            <GenericModal
                                modalId="Shifts Modal"
                                :title="__('Click Here To See Shifts History')"
                                :modalHeader="__('Previous Shifts')"
                                :hasCancel="false"
                            >
                                <Table
                                    :totalNumber="
                                        props.employee.employee_shifts
                                            ?.length || 0
                                    "
                                    :enablePaginator="false"
                                >
                                    <template #Head>
                                        <TableHead>{{ __("Shift") }}</TableHead>
                                        <TableHead>{{
                                            __("Starting From")
                                        }}</TableHead>
                                        <TableHead>{{
                                            __("Ending At")
                                        }}</TableHead>
                                    </template>

                                    <template #Body>
                                        <TableRow
                                            v-for="shift in props.employee
                                                .employee_shifts ?? []"
                                            :key="shift.id"
                                        >
                                            <TableBody>{{
                                                shift.shift?.name ??
                                                __("DELETED SHIFT")
                                            }}</TableBody>
                                            <TableBody>{{
                                                shift.start_date
                                            }}</TableBody>
                                            <TableBody>{{
                                                shift.end_date ?? __("Current")
                                            }}</TableBody>
                                        </TableRow>
                                    </template>
                                </Table>
                            </GenericModal>
                        </div>
                    </HistoryDescriptionList>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
