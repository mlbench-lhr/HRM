<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm } from "@inertiajs/vue3";
import { useToast } from "vue-toastification";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import ReqTabs from "@/Components/Tabs/ReqTabs.vue";
import VueDatePicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";
import dayjs from "dayjs";
import Card from "@/Components/Card.vue";
import { inject, watch, computed } from "vue";
import { __ } from "@/Composables/useTranslations.js";

defineProps({
    types: Array,
});

const form = useForm({
    type: "",
    message: "",
    leave_type: "",
    leave_duration: "",
    half_leave_segment: "",
    half_leave_date: null,
    start_date: null,
    end_date: null,
    remote_work_date: null,
});

// Reset leave fields when request type changes
watch(
    () => form.type,
    (value) => {
        if (value !== "Leave") {
            form.leave_type = null;
            form.leave_duration = null;
            form.half_leave_date = null;
            form.half_leave_segment = "";
            form.start_date = null;
            form.end_date = null;
        }
        if (value !== "Remote Work") {
            form.remote_work_date = null;
        }
    }
);

// Computed properties to convert JS Dates to strings for Laravel
// const halfLeaveDateStr = computed(() =>
//     form.half_leave_date
//         ? dayjs(form.half_leave_date).format("YYYY-MM-DD")
//         : null
// );
// const startDateStr = computed(() =>
//     form.start_date ? dayjs(form.start_date).format("YYYY-MM-DD") : null
// );
// const endDateStr = computed(() =>
//     form.end_date ? dayjs(form.end_date).format("YYYY-MM-DD") : null
// );

const submitForm = () => {
    // let leave_duration_numeric = null;

    // if (form.type === "Leave") {
    //     if (form.leave_duration === "half") {
    //         leave_duration_numeric = 0.5;
    //     } else if (
    //         form.leave_duration === "full" &&
    //         form.start_date &&
    //         form.end_date
    //     ) {
    //         leave_duration_numeric =
    //             dayjs(form.end_date).diff(dayjs(form.start_date), "day") + 1;
    //     }
    // }

    // Send string formatted date to Laravel, not Date object
    const payload = {
        type: form.type,
        message: form.message || null,

        // Leave
        leave_type: form.leave_type || null,
        leave_duration: form.leave_duration || null, // "half" | "full"
        half_leave_date: form.half_leave_date
            ? dayjs(form.half_leave_date).format("YYYY-MM-DD")
            : null,
        half_leave_segment: form.half_leave_segment || null,
        start_date: form.start_date
            ? dayjs(form.start_date).format("YYYY-MM-DD")
            : null,
        end_date: form.end_date
            ? dayjs(form.end_date).format("YYYY-MM-DD")
            : null,

        // Remote work
        remote_work_date: form.remote_work_date
            ? dayjs(form.remote_work_date).format("YYYY-MM-DD")
            : null,
    };

    form.post(route("requests.store"), payload, {
        preserveScroll: true,
        onError: (errors) => {
            if (errors.past_leave) {
                useToast().error(errors.past_leave);
            } else {
                useToast().error(Object.values(errors)[0]);
            }
        },
        onSuccess: () => {
            useToast().success(__("Request Created Successfully"));
            form.reset();
        },
    });
};
</script>

<template>
    <Head :title="__('Request Create')" />
    <AuthenticatedLayout>
        <template #tabs>
            <ReqTabs />
        </template>
        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card class="!mt-0">
                    <h1 class="card-header !mb-4">
                        {{ __("Create a Request") }}
                        hello
                    </h1>
                    <form @submit.prevent="submitForm">
                        <!-- REQUEST TYPE -->
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <InputLabel value="Type" />
                                <select
                                    class="fancy-selector"
                                    v-model="form.type"
                                >
                                    <option value="">
                                        {{ __("Choose Request Type") }}
                                    </option>
                                    <option
                                        v-for="type in types"
                                        :key="type"
                                        :value="type"
                                    >
                                        {{ type }}
                                    </option>
                                </select>
                                <InputError :message="form.errors.type" />
                            </div>
                        </div>

                        <!-- LEAVE FIELDS -->
                        <div
                            v-if="form.type === 'Leave'"
                            class="grid grid-cols-2 gap-4 mt-4"
                        >
                            <!-- LEAVE TYPE -->
                            <div>
                                <InputLabel value="Leave Type" />
                                <select
                                    class="fancy-selector"
                                    v-model="form.leave_type"
                                >
                                    <option value="">
                                        {{ __("Select Leave Type") }}
                                    </option>
                                    <option value="sick">
                                        {{ __("Sick Leave") }}
                                    </option>
                                    <option value="casual">
                                        {{ __("Casual Leave") }}
                                    </option>
                                </select>
                                <InputError :message="form.errors.leave_type" />
                            </div>

                            <!-- LEAVE DURATION -->
                            <div>
                                <InputLabel value="Duration" />
                                <select
                                    class="fancy-selector"
                                    v-model="form.leave_duration"
                                >
                                    <option value="">
                                        {{ __("Select Duration") }}
                                    </option>
                                    <option value="full">
                                        {{ __("Full Day") }}
                                    </option>
                                    <option value="half">
                                        {{ __("Half Day") }}
                                    </option>
                                </select>
                                <InputError
                                    :message="form.errors.leave_duration"
                                />
                            </div>
                            <!-- HALF-DAY SEGMENT -->
                            <div v-if="form.leave_duration === 'half'">
                                <InputLabel value="Half Segment" />
                                <select
                                    class="fancy-selector"
                                    v-model="form.half_leave_segment"
                                >
                                    <option value="">Select Half</option>
                                    <option value="first half">
                                        First Half
                                    </option>
                                    <option value="second half">
                                        Second Half
                                    </option>
                                </select>
                                <InputError
                                    :message="form.errors.half_leave_segment"
                                />
                            </div>
                            <!-- HALF DAY DATE -->
                            <div v-if="form.leave_duration === 'half'">
                                <InputLabel value="Date" />
                                <VueDatePicker
                                    v-model="form.half_leave_date"
                                    :enable-time-picker="false"
                                    :format="'yyyy-MM-dd'"
                                    :min-date="new Date()"
                                    :dark="inject('isDark').value"
                                    placeholder="Select Date"
                                />
                                <InputError
                                    :message="form.errors.half_leave_date"
                                />
                            </div>

                            <!-- FULL DAY START DATE -->
                            <div v-if="form.leave_duration === 'full'">
                                <InputLabel value="Start Date" />
                                <VueDatePicker
                                    v-model="form.start_date"
                                    :enable-time-picker="false"
                                    :format="'yyyy-MM-dd'"
                                    :min-date="new Date()"
                                    :dark="inject('isDark').value"
                                    placeholder="Select Start Date"
                                />
                                <InputError :message="form.errors.start_date" />
                            </div>

                            <!-- FULL DAY END DATE -->
                            <div v-if="form.leave_duration === 'full'">
                                <InputLabel value="End Date" />
                                <VueDatePicker
                                    v-model="form.end_date"
                                    :enable-time-picker="false"
                                    :format="'yyyy-MM-dd'"
                                    :min-date="form.start_date || new Date()"
                                    :dark="inject('isDark').value"
                                    placeholder="Select End Date"
                                />
                                <InputError :message="form.errors.end_date" />
                            </div>
                        </div>
                        <!-- REMOTE WORK DATE -->
                        <div v-if="form.type === 'Remote Work'" class="mt-4">
                            <InputLabel value="Remote Work Date" />
                            <VueDatePicker
                                v-model="form.remote_work_date"
                                :enable-time-picker="false"
                                :format="'yyyy-MM-dd'"
                                :min-date="new Date()"
                                :dark="inject('isDark').value"
                                placeholder="Select Date"
                            />
                            <InputError
                                :message="form.errors.remote_work_date"
                            />
                        </div>
                        <!-- MESSAGE FIELD -->
                        <div class="grid grid-cols-1 gap-4 mt-4">
                            <div>
                                <InputLabel value="Message" />
                                <TextInput
                                    type="text"
                                    class="block w-full"
                                    v-model="form.message"
                                    autocomplete="off"
                                    :placeholder="
                                        __(
                                            'I will be absent for 3 days because I\'m sick.'
                                        )
                                    "
                                />
                                <InputError :message="form.errors.message" />
                            </div>
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <PrimaryButton :disabled="form.processing">
                                {{ __("Initiate Request") }}
                            </PrimaryButton>
                        </div>
                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
