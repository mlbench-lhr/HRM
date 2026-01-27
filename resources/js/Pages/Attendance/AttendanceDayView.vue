<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm, router } from "@inertiajs/vue3";
import FlexButton from "@/Components/FlexButton.vue";
import AttendanceTabs from "@/Components/Tabs/AttendanceTabs.vue";
import { useToast } from "vue-toastification";
import Swal from "sweetalert2";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Card from "@/Components/Card.vue";
import TrashIcon from "@/Components/Icons/TrashIcon.vue";
import { __ } from "@/Composables/useTranslations.js";
import Table from "@/Components/Table/Table.vue";
import TableBodyHeader from "@/Components/Table/TableBodyHeader.vue";
import TableBody from "@/Components/Table/TableBody.vue";
import TableHead from "@/Components/Table/TableHead.vue";
import TableRow from "@/Components/Table/TableRow.vue";
import { attendance_types } from "@/Composables/useAttendanceTypes.js";
import TableBodyAction from "@/Components/Table/TableBodyAction.vue";

import { ref, watch } from "vue";

import SearchBar from "@/Components/SearchBar.vue";
const props = defineProps({
    attendanceList: Object,
    day: String,
    filters: Object,
});
const term = ref(props.filters?.term || '');

// 2. Create a manual debounce timer
let timeout = null;

const search = () => {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        // Change 'day' to 'date' here to match the route definition
        router.visit(route('attendance.show', { date: props.day, term: term.value }), {
            preserveState: true,
            preserveScroll: true,
            replace: true
        });
    }, 400);
};
// 3. Watch the term and run the manual search function
watch(term, search);
const statusStyles = {
    on_time: "bg-green-100 text-green-800 border-green-200",
    late: "bg-yellow-100 text-yellow-800 border-yellow-200",
    missed: "bg-red-100 text-red-800 border-red-200",
    leave: "bg-blue-100 text-blue-800 border-blue-200",
    unpaid_leave: "bg-purple-100 text-purple-800 border-purple-200",
    incomplete: "bg-gray-100 text-gray-800 border-gray-200", // Gray for forgot sign-out
    partial_present: "bg-orange-100 text-orange-800 border-orange-200", // Orange for Half-days
};
const destroy = () => {
    const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
            confirmButton:
                "mx-4 text-white bg-red-700 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900",
            cancelButton:
                "text-white bg-purple-700 hover:bg-purple-800 focus:outline-none focus:ring-4 focus:ring-purple-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mb-2 dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900",
        },
        buttonsStyling: false,
    });
    swalWithBootstrapButtons
        .fire({
            title: __("Are you sure?"),
            text: __("You won't be able to revert this!"),
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: __("Yes, Delete!"),
            cancelButtonText: __("No, Cancel!"),
            reverseButtons: true,
        })
        .then((result) => {
            if (result.isConfirmed) {
                useForm({}).delete(
                    route("attendance.destroy", { date: props.day }),
                    {
                        preserveScroll: true,
                        onError: () => {
                            useToast().error(__("Error Deleting Attendance"));
                        },
                        onSuccess: () => {
                            Swal.fire(__("Attendance Removed!"), "", "success");
                        },
                    }
                );
            }
        });
};
</script>

<template>

    <Head :title="__('Attendance View')" />
    <AuthenticatedLayout>
        <template #tabs>
            <AttendanceTabs />
        </template>
        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <h1 class="card-header !mb-6">
                        {{ __("Attendance List for :day", { day: day }) }}
                    </h1>
                    <div class="flex justify-between items-center pb-4 gap-4">
                        <div class="flex justify-center items-center inline">
                            <FlexButton :href="route('attendances.create')" :text="__('Retake/Update Attendance')">
                                <TrashIcon />
                            </FlexButton>
                        </div>
                        <div class="w-full md:flex-1 md:max-w-md">
                            <SearchBar>
                                <input type="text" v-model="term"
                                    class="w-full pl-10 border-gray-300 rounded-lg shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                                    :placeholder="__('Search employee attendance...')">
                            </SearchBar>
                        </div>
                        <form @submit.prevent="destroy" class="flex justify-center items-center">
                            <PrimaryButton class="bg-red-600 hover:bg-red-700 focus:bg-red-500 active:bg-red-900">
                                <TrashIcon />
                                {{ __("Delete Day Attendance") }}
                            </PrimaryButton>
                        </form>

                    </div>

                    <Table :links="attendanceList.links" :showingNumber="attendanceList.data.length"
                        :totalNumber="attendanceList.total">
                        <template #Head>
                            <TableHead>{{ __("ID") }}</TableHead>
                            <TableHead>{{ __("Employee") }}</TableHead>
                            <TableHead>{{ __("Status") }}</TableHead>
                            <TableHead>{{ __("Sign In Time") }}</TableHead>
                            <TableHead>{{ __("Sign Off Time") }}</TableHead>
                            <TableHead>{{ __("Notes") }}</TableHead>
                            <TableHead>{{ __("Action") }}</TableHead>
                        </template>

                        <!--Iterate Here-->
                        <template #Body>
                            <TableRow v-for="attendance in attendanceList.data" :key="attendance.id">
                                <TableBodyHeader>{{
                                    attendance.id
                                }}</TableBodyHeader>
                                <TableBodyHeader>{{
                                    attendance.employee_name
                                }}</TableBodyHeader>
                                <TableBody><span class="px-2.5 py-0.5 rounded-full text-xs font-medium border" :class="statusStyles[attendance.status] ||
                                    'bg-gray-100 text-gray-800'
                                    ">
                                        {{
                                            attendance_types[attendance.status]
                                        }}
                                    </span></TableBody>
                                <TableBody>{{
                                    attendance.sign_in_time
                                }}</TableBody>
                                <TableBody>{{
                                    attendance.sign_off_time ??
                                    __("Haven't Sign Off Yet")
                                }}</TableBody>
                                <TableBody>{{ attendance.notes }}</TableBody>
                                <TableBodyAction :href="route('attendances.edit', { attendance: attendance.id })">

                                    {{ __(" Edit") }}
                                </TableBodyAction>
                            </TableRow>
                        </template>
                    </Table>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
