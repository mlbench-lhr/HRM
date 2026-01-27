<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm } from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";
import { attendance_types } from "@/Composables/useAttendanceTypes.js";
import TextInput from "@/Components/TextInput.vue";
import InputLabel from "@/Components/InputLabel.vue";
import InputError from "@/Components/InputError.vue";

const props = defineProps({
    attendance: Object,
});

const form = useForm({
    status: props.attendance.status,
    sign_in_time: props.attendance.sign_in_time || '',
    sign_off_time: props.attendance.sign_off_time || '',
    notes: props.attendance.notes || '',
});

const submit = () => {
    form.put(route("attendances.update", { attendance: props.attendance.id }), {
        preserveScroll: true,
    });
};
</script>

<template>

    <Head :title="__('Edit Attendance')" />

    <AuthenticatedLayout>
        <div class="py-8">
            <div class="max-w-3xl mx-auto sm:px-6 lg:px-8">
                <Card>
                    <h1 class="card-header !mb-6">
                        {{ __("Edit Attendance for :name", { name: attendance.employee.name }) }}
                    </h1>

                    <form @submit.prevent="submit" class="space-y-6">
                        <div>
                            <InputLabel for="status" :value="__('Status')" />
                            <select id="status" v-model="form.status"
                                class="mt-1 block w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm"
                                required>
                                <option v-for="(label, value) in attendance_types" :key="value" :value="value">
                                    {{ label }}
                                </option>
                            </select>
                            <InputError :message="form.errors.status" class="mt-2" />
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <InputLabel for="sign_in" :value="__('Sign In Time')" />
                                <TextInput id="sign_in" type="time" class="mt-1 block w-full"
                                    v-model="form.sign_in_time" />
                                <InputError :message="form.errors.sign_in_time" class="mt-2" />
                            </div>

                            <div>
                                <InputLabel for="sign_off" :value="__('Sign Off Time')" />
                                <TextInput id="sign_off" type="time" class="mt-1 block w-full"
                                    v-model="form.sign_off_time" />
                                <InputError :message="form.errors.sign_off_time" class="mt-2" />
                            </div>
                        </div>

                        <div>
                            <InputLabel for="notes" :value="__('Notes')" />
                            <textarea id="notes" v-model="form.notes"
                                class="mt-1 block w-full border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm"
                                rows="3"></textarea>
                            <InputError :message="form.errors.notes" class="mt-2" />
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                {{ __("Update Attendance") }}
                            </PrimaryButton>
                        </div>
                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
