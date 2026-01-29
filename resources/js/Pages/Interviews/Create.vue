<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Card from "@/Components/Card.vue";
import { __ } from "@/Composables/useTranslations.js";
import { useToast } from "vue-toastification";
import { computed } from "vue";

const toast = useToast();
const page = usePage();

// Check Role
const userRoles = page.props.auth.user.roles || [];
const isAdmin = userRoles.includes('admin');

const form = useForm({
    interviewer_name: "",
    candidate_name: "",
    position: "",
    interview_date: new Date().toISOString().substr(0, 10),
    skill_depth: null,
    problem_solving: null,
    practical_experience: null,
    communication_clarity: null,
    ownership_initiative: null,
    final_comment: "",
    is_recommended: null,
});

const metrics = [
    { key: "skill_depth", label: "Skill Depth" },
    { key: "problem_solving", label: "Problem-solving Ability" },
    { key: "practical_experience", label: "Practical Experience" },
    { key: "communication_clarity", label: "Communication Clarity" },
    { key: "ownership_initiative", label: "Ownership & Initiative" },
];

const totalScore = computed(() => {
    return (Number(form.skill_depth) || 0) +
        (Number(form.problem_solving) || 0) +
        (Number(form.practical_experience) || 0) +
        (Number(form.communication_clarity) || 0) +
        (Number(form.ownership_initiative) || 0);
});

const submit = () => {
    form.post(route("interviews.store"), {
        preserveScroll: true,
        onSuccess: () => {
            toast.success(__("Interview saved successfully!"));
            form.reset();
        },
        onError: () => toast.error(__("Please check fields.")),
    });
};
</script>

<template>

    <Head :title="__('Interview Assessment')" />
    <AuthenticatedLayout>
        <div class="py-12 bg-gray-50 dark:bg-gray-900 min-h-screen">
            <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
                <Card class="overflow-hidden shadow-xl border-t-4 border-indigo-500">

                    <div class="p-6 border-b border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800">
                        <div class="flex justify-between items-center">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800 dark:text-white">
                                    {{ __("New Interview") }}
                                </h1>
                                <p class="text-sm text-gray-500 mt-1">
                                    {{ __("Assessment Form") }}
                                </p>
                            </div>
                            <div class="text-center bg-indigo-50 px-4 py-2 rounded-lg border border-indigo-100">
                                <span class="block text-xs text-indigo-400 font-bold uppercase tracking-wider">
                                    {{ __("Total Score") }}
                                </span>
                                <span class="text-2xl font-black text-indigo-600">
                                    {{ totalScore }} <span class="text-gray-400 text-lg">/ 25</span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <form @submit.prevent="submit" class="p-6 space-y-8">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                            <div v-if="isAdmin">
                                <InputLabel :value="__('Interviewer Name')"
                                    class="mb-1 after:content-['*'] after:ml-0.5 after:text-red-500" />
                                <TextInput v-model="form.interviewer_name" class="w-full" placeholder="Enter Name"
                                    required />
                                <InputError :message="form.errors.interviewer_name" class="mt-2" />
                            </div>

                            <div>
                                <InputLabel :value="__('Interview Date')"
                                    class="mb-1 after:content-['*'] after:ml-0.5 after:text-red-500" />
                                <TextInput type="date" v-model="form.interview_date" class="w-full" required />
                            </div>

                            <div>
                                <InputLabel :value="__('Candidate Name')"
                                    class="mb-1 after:content-['*'] after:ml-0.5 after:text-red-500" />
                                <TextInput v-model="form.candidate_name" class="w-full" placeholder="Candidate Name"
                                    required />
                                <InputError :message="form.errors.candidate_name" class="mt-2" />
                            </div>

                            <div>
                                <InputLabel :value="__('Position')"
                                    class="mb-1 after:content-['*'] after:ml-0.5 after:text-red-500" />
                                <TextInput v-model="form.position" class="w-full" placeholder="Applied Position"
                                    required />
                                <InputError :message="form.errors.position" class="mt-2" />
                            </div>
                        </div>

                        <div class="bg-indigo-50/50 dark:bg-indigo-900/10 p-6 rounded-xl border border-indigo-100">
                            <h3 class="text-lg font-bold text-indigo-800 dark:text-indigo-300 mb-6">
                                {{ __("Skill Assessment (Rate 1-5)") }}
                            </h3>

                            <div class="space-y-6">
                                <div v-for="m in metrics" :key="m.key"
                                    class="grid grid-cols-1 sm:grid-cols-3 items-center gap-4 pb-4 border-b border-indigo-200/50 last:border-0 last:pb-0">

                                    <div
                                        class="font-medium text-gray-700 dark:text-gray-300 after:content-['*'] after:ml-0.5 after:text-red-500">
                                        {{ __(m.label) }}
                                    </div>

                                    <div
                                        class="sm:col-span-2 flex justify-between items-center bg-white dark:bg-gray-800 px-4 py-2 rounded-lg shadow-sm">
                                        <span class="text-[10px] text-gray-400 font-bold">1</span>
                                        <div class="flex gap-4">
                                            <label v-for="n in 5" :key="n" class="cursor-pointer">
                                                <input type="radio" :name="m.key" :value="n" v-model="form[m.key]"
                                                    required class="peer sr-only" />
                                                <div
                                                    class="w-8 h-8 flex items-center justify-center rounded-full text-sm font-bold text-gray-400 border-2 border-gray-200 transition-all
                                                    peer-checked:bg-indigo-600 peer-checked:text-white peer-checked:border-indigo-600 hover:border-indigo-400">
                                                    {{ n }}
                                                </div>
                                            </label>
                                        </div>
                                        <span class="text-[10px] text-gray-400 font-bold">5</span>
                                    </div>
                                    <InputError :message="form.errors[m.key]" class="col-span-3 mt-1" />
                                </div>
                            </div>
                        </div>

                        <div>
                            <InputLabel :value="__('Final Comment')"
                                class="mb-2 after:content-['*'] after:ml-0.5 after:text-red-500" />
                            <textarea v-model="form.final_comment" required
                                class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-indigo-500 focus:border-indigo-500 min-h-[100px]"
                                placeholder="Summary..."></textarea>
                            <InputError :message="form.errors.final_comment" class="mt-2" />

                            <div class="mt-6 pt-6 border-t border-gray-100">
                                <p
                                    class="font-bold text-gray-800 dark:text-gray-200 mb-3 after:content-['*'] after:ml-0.5 after:text-red-500">
                                    {{ __("Hiring Recommendation?") }}
                                </p>
                                <div class="flex gap-6">
                                    <label
                                        class="flex items-center gap-3 cursor-pointer p-4 border rounded-xl w-full transition-all"
                                        :class="form.is_recommended === true ? 'border-emerald-500 bg-emerald-50 dark:bg-emerald-900/20 ring-1 ring-emerald-500' : 'border-gray-200 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700'">
                                        <input type="radio" :value="true" v-model="form.is_recommended" required
                                            class="w-5 h-5 text-emerald-600" />
                                        <span class="font-bold text-gray-700 dark:text-gray-200">{{ __("Yes, Hire")
                                            }}</span>
                                    </label>

                                    <label
                                        class="flex items-center gap-3 cursor-pointer p-4 border rounded-xl w-full transition-all"
                                        :class="form.is_recommended === false ? 'border-rose-500 bg-rose-50 dark:bg-rose-900/20 ring-1 ring-rose-500' : 'border-gray-200 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700'">
                                        <input type="radio" :value="false" v-model="form.is_recommended" required
                                            class="w-5 h-5 text-rose-600" />
                                        <span class="font-bold text-gray-700 dark:text-gray-200">{{ __("No, Reject")
                                            }}</span>
                                    </label>
                                </div>
                                <InputError :message="form.errors.is_recommended" class="mt-2" />
                            </div>
                        </div>

                        <div class="flex justify-end pt-4">
                            <PrimaryButton
                                class="px-8 py-3 bg-indigo-600 hover:bg-indigo-700 shadow-lg shadow-indigo-500/30"
                                :disabled="form.processing">
                                {{ __("Submit Assessment") }}
                            </PrimaryButton>
                        </div>

                    </form>
                </Card>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
