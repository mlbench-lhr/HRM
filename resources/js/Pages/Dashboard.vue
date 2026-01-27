<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm, usePage } from "@inertiajs/vue3";
import { computed, ref } from "vue";
import { daysUntilNthDayOfMonth } from "@/Composables/daysUntilNthDayOfMonthCalculator.js";
import { daysBetweenNthDates } from "@/Composables/daysBetweenNthDatesCalculator.js";
import NavLink from "@/Components/NavLink.vue";
import GoBackNavLink from "@/Components/GoBackNavLink.vue";
import Card from "@/Components/Card.vue";
import BlockQuote from "@/Components/BlockQuote.vue";
import IconCard from "@/Components/IconCard.vue"; // Restored
import ProgressBar from "@/Components/ProgressBar.vue";
import ToolTip from "@/Components/ToolTip.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Swal from "sweetalert2";
import HorizontalRule from "@/Components/HorizontalRule.vue";
import MoneyIcon from "@/Components/Icons/MoneyIcon.vue"; // Restored
import CalendarIcon from "@/Components/Icons/CalendarIcon.vue"; // Restored
import TableIcon from "@/Components/Icons/TableIcon.vue"; // Restored
import MessageIcon from "@/Components/Icons/MessageIcon.vue"; // Restored
import { __ } from "@/Composables/useTranslations.js";

const props = defineProps({
    salary: Object,
    payroll_day: Number,
    employee_stats: Object,
    attendance_status: Number,
    is_today_off: Boolean,
});

// --- DATE & PAYROLL LOGIC ---
const days_remaining = computed(() => {
    return daysUntilNthDayOfMonth(props.payroll_day);
});

const pay_day_percentage = computed(() => {
    return Math.floor(
        ((daysBetweenNthDates(props.payroll_day) - days_remaining.value) /
            daysBetweenNthDates(props.payroll_day)) *
        100
    );
});

const isSalaryVisible = ref(false);

const dayNth = computed(() => {
    return props.payroll_day === 1 ? __("st") : props.payroll_day === 2 ? __("nd") : props.payroll_day === 3 ? __("rd") : __("th");
});

const today = new Date().toLocaleDateString(usePage().props.locale, {
    weekday: "long",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
});

// --- ATTENDANCE LOGIC ---
const isUserSignedOut = computed(() => props.attendance_status === 0);

const msg = computed(() => {
    return isUserSignedOut.value ? __("Check In") : __("Check Out");
});

// Show badge if User is Signed In AND backend provided a time
const showSignInBadge = computed(() => {
    return !isUserSignedOut.value && props.employee_stats?.today_sign_in_time;
});

const form = useForm({});

const submit = () => {
    const postRoute = isUserSignedOut.value
        ? "attendance.dashboardSignIn"
        : "attendance.dashboardSignOff";

    const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
            cancelButton: "mx-4 text-white bg-red-700 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900",
            confirmButton: "text-white bg-purple-700 hover:bg-purple-800 focus:outline-none focus:ring-4 focus:ring-purple-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mb-2 dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900",
        },
        buttonsStyling: false,
    });
    swalWithBootstrapButtons.fire({
        title: __("Confirm :signType for attendance for :today?", {
            signType: isUserSignedOut.value ? __("Check In") : __("Check Out"),
            today: today,
        }),
        html: isUserSignedOut.value
            ? "<b>" + __("Notes") + "</b><br>" +
            __("1. Attendance for non-remote employees can only be taken from inside the organization.") +
            "<br>" +
            __("2. You need to register sign-Out here again before leaving, otherwise, your attendance will not be accounted.")
            : "",
        icon: "info",
        showCancelButton: true,
        confirmButtonText: __("Confirm"),
        cancelButtonText: __("Cancel"),
        reverseButtons: true,
    }).then((result) => {
        if (result.isConfirmed) {
            form.post(route(postRoute, { id: usePage().props.auth.user.id }), {
                preserveScroll: true,
                onSuccess: () => {
                    Swal.fire(
                        __("Action Registered"),
                        isUserSignedOut.value ? __("Don't forget to sign-Out before you leave!") : "",
                        "success"
                    );
                },
                onError: () => {
                    Swal.fire(__("Error"), __("Something went wrong."), "error");
                }
            });
        }
    });
};

// --- QUOTE OF THE DAY LOGIC (Offline & Reliable) ---
const quote = computed(() => {
    const quotesList = [
        { content: "The only way to do great work is to love what you do.", author: "Steve Jobs" },
        { content: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill" },
        { content: "Believe you can and you're halfway there.", author: "Theodore Roosevelt" },
        { content: "Your time is limited, so don't waste it living someone else's life.", author: "Steve Jobs" },
        { content: "It always seems impossible until it's done.", author: "Nelson Mandela" },
        { content: "Act as if what you do makes a difference. It does.", author: "William James" },
        { content: "Quality is not an act, it is a habit.", author: "Aristotle" },
        { content: "Whatever you are, be a good one.", author: "Abraham Lincoln" },
        { content: "If you cannot do great things, do small things in a great way.", author: "Napoleon Hill" },
        { content: "Opportunities don't happen, you create them.", author: "Chris Grosser" }
    ];
    const now = new Date();
    const start = new Date(now.getFullYear(), 0, 0);
    const diff = now - start;
    const oneDay = 1000 * 60 * 60 * 24;
    const dayOfYear = Math.floor(diff / oneDay);
    return quotesList[dayOfYear % quotesList.length];
});
</script>

<template>

    <Head :title="__('Dashboard')" />
    <AuthenticatedLayout>
        <template #tabs>
            <GoBackNavLink />
            <NavLink :href="route('dashboard.index')" :active="route().current('dashboard.index')">
                {{ __("Dashboard") }}
            </NavLink>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex justify-between gap-4">
                    <Card class="w-full md:w-3/4 !mt-0">
                        <h1 class="!card-header !mb-0">
                            {{ __("Welcome, :name", { name: $page.props.auth.user.name }) }}!
                        </h1>
                    </Card>
                    <Card class="w-full md:w-1/4 !mt-0" vl :fancy-p="false">
                        <form @submit.prevent="submit" class="w-full h-full"
                            v-if="attendance_status !== 2 && !is_today_off">
                            <PrimaryButton class="w-full h-full flex flex-col justify-center items-center">
                                <span class="text-xl">{{ __("Attendance :msg", { msg: msg }) }}</span>
                                <span class="text-xs text-gray-200 mt-1">{{ __("For") }} {{ today }}</span>

                                <span v-if="showSignInBadge"
                                    class="text-xs font-bold text-yellow-300 mt-1 bg-purple-900 px-2 py-0.5 rounded-full">
                                    {{ __("Signed In at:") }} {{ employee_stats.today_sign_in_time }}
                                </span>
                            </PrimaryButton>
                        </form>
                        <PrimaryButton v-else
                            class="w-full h-full flex justify-center !border-0 bg-gradient-to-r from-green-500 to-green-400 cursor-not-allowed"
                            disabled>
                            <span v-if="is_today_off" class="text-sm">{{ __("Today is Out! 🕺🕺") }}<br /></span>
                            <span v-else class="text-sm">{{ __("Attendance Taken Today! 🎉") }}<br /></span>
                        </PrimaryButton>
                    </Card>
                </div>

                <div class="flex flex-col md:flex-row justify-between md:gap-4">
                    <Card class="w-full md:w-3/4">
                        <h1 class="text-2xl">{{ __("Quote of the day") }}</h1>
                        <div class="flex justify items-center">
                            <BlockQuote class="mb-0" :style="2" :quote="quote.content" :author="quote.author" />
                        </div>
                    </Card>

                    <Card class="w-full md:w-1/4 overflow-hidden border-none shadow-sm" vl>
                        <div class="flex items-center justify-between mb-6">
                            <div class="w-6"></div>
                            <h1 class="text-lg font-bold text-gray-800 uppercase dark:text-gray-200 tracking-wider">
                                {{ __("Your Salary") }}
                            </h1>
                            <button @click="isSalaryVisible = !isSalaryVisible"
                                class="p-1.5 rounded-full hover:bg-gray-100 text-gray-400 hover:text-primary transition-all duration-200 focus:outline-none"
                                :title="isSalaryVisible ? __('Hide Salary') : __('Show Salary')">
                                <svg v-if="isSalaryVisible" xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"></path>
                                    <path
                                        d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68">
                                    </path>
                                    <path d="M6.61 6.61A13.52 13.52 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61">
                                    </path>
                                    <line x1="2" y1="2" x2="22" y2="22"></line>
                                </svg>
                                <svg v-else xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"></path>
                                    <circle cx="12" cy="12" r="3"></circle>
                                </svg>
                            </button>
                        </div>

                        <div class="space-y-4">
                            <p class="text-xl text-center">
                                {{ salary[0] }}
                                <span class="font-bold font-mono dark:text-gray-200"
                                    :class="{ 'text-gray-400 dark:text-gray-200': !isSalaryVisible }">
                                    {{ isSalaryVisible ? new Intl.NumberFormat().format(salary[1]) : '••••••••' }}
                                </span>
                            </p>

                            <HorizontalRule class="!bg-neutral-300" />
                            <p class="text-center text-gray-700 text-sm">
                                {{ __("Last Updated: :salary", { salary: salary[2] }) }}
                            </p>
                        </div>
                    </Card>
                </div>

                <div class="flex flex-col md:flex-row justify-between md:gap-4">
                    <Card class="w-full md:w-1/4 bg-gradient-to-r from-indigo-700 to-purple-800 glow-element">
                        <h1 class="text-2xl text-white">{{ __("Pay Day") }}</h1>
                        <div class="mt-4 text-white">
                            <p class="text-white">
                                <span class="font-medium">{{ __("Pay Day") }}: </span>{{ props.payroll_day }}<sup>{{
                                    dayNth
                                }}</sup>
                                {{ __("of every month") }}.
                            </p>
                            <p class="mt-1 text-white">
                                <span class="font-medium">{{ __("Days Remaining") }}: </span>{{ days_remaining }} {{
                                    __("Days")
                                }}.
                            </p>
                            <div class="w-full bg-gray-200 rounded-full dark:bg-gray-700 mt-2">
                                <div class="bg-amber-400 text-xs font-medium text-indigo-700 text-center p-0.5 leading-none rounded-full"
                                    :style="'width:' + (pay_day_percentage > 100 ? 100 : pay_day_percentage) + '%'">
                                    {{ pay_day_percentage.toFixed(0) + "%" }}
                                </div>
                            </div>
                        </div>
                    </Card>

                    <Card class="w-full md:w-1/4">
                        <h1 class="text-2xl">
                            {{ __("Data of :month", {
                                month: new Date().toLocaleString($page.props.locale, {
                                    month:
                                        "long"
                                })
                            })
                            }}
                        </h1>
                        <div class="mt-4 w-full flex flex-col">
                            <div class="flex justify-between align-middle mb-6 sm:mb-2">
                                <p class="font-medium">{{ __("Work Days") }}:</p>
                                <p>{{ employee_stats["attendableThisMonth"] }} {{ __("Days") }}</p>
                            </div>
                            <div class="flex justify-between align-middle mb-6 sm:mb-2">
                                <p class="font-medium">{{ __("Weekends") }}:</p>
                                <p>{{ employee_stats["weekendsThisMonth"] }} {{ __("Days") }}</p>
                            </div>
                            <div class="flex justify-between align-middle mb-6 sm:mb-2">
                                <p class="font-medium">{{ __("Holidays") }}:</p>
                                <p>{{ employee_stats["holidaysThisMonth"] }} {{ __("Days") }}</p>
                            </div>
                        </div>
                    </Card>

                    <Card class="w-full md:w-2/4">
                        <h1 class="text-2xl">{{ __("Your Attendance This Month") }}</h1>
                        <div class="mt-4 grid grid-rows-3">
                            <div class="flex flex-col lg:flex-row justify-between align-middle mb-6 sm:mb-2">
                                <p class="w-full sm:w-1/3">
                                    {{ __("Attended") }} {{ employee_stats["totalAttendanceSoFar"] }}
                                </p>
                                <ProgressBar class="col-span-3 h-6" color="bg-green-500" no-text
                                    :percentage="(employee_stats['totalAttendanceSoFar'] / employee_stats['attendableThisMonth']) * 100" />
                            </div>

                            <div class="flex flex-col lg:flex-row justify-between align-middle mb-6 sm:mb-2">
                                <p class="w-full sm:w-1/3">
                                    {{ __("Absented:") }} {{ employee_stats["absentedThisMonth"] }}
                                </p>
                                <ProgressBar no-text color="bg-red-500"
                                    :percentage="(employee_stats['totalAbsenceSoFar'] / employee_stats['YearStats']['absence_limit']) * 100" />
                            </div>

                            <div class="flex flex-col lg:flex-row justify-between align-middle mb-6 sm:mb-2">
                                <p class="w-full sm:w-1/3">
                                    {{ __("Hours:") }}
                                    <ToolTip direction="bottom">
                                        {{ __(`This value will be accounted for in the payroll...`) }}
                                    </ToolTip>
                                    {{ employee_stats["hoursDifferenceSoFar"].toFixed(0) + __("h") }}
                                </p>

                                <div
                                    class="col-span-3 w-full h-6 bg-gray-200 rounded-full dark:bg-gray-700 relative overflow-hidden">
                                    <div class="h-6 rounded-full transition-all duration-500"
                                        :class="employee_stats['hoursDifferenceSoFar'] >= 0 ? 'bg-green-500' : 'bg-red-500'"
                                        :style="'width:' + Math.abs(employee_stats['hoursDifferenceSoFar']) + '%'">
                                    </div>
                                    <span
                                        class="absolute inset-0 flex items-center justify-center text-xs font-bold whitespace-nowrap z-10 text-gray-800 dark:text-white drop-shadow-sm">
                                        {{ employee_stats['hoursDifferenceSoFar'] }} {{ __("Hours") }}
                                        {{ employee_stats['hoursDifferenceSoFar'] > 0 ? __('extra') : __('late') }}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </Card>
                </div>

                <div class="flex flex-col md:flex-row justify-between md:gap-4">
                    <Card class="!p-2 w-full">
                        <h1 class="text-2xl">{{ __("Quick Actions") }}</h1>
                        <div class="flex flex-wrap justify-center gap-4">
                            <Card class="w-full lg:w-1/4 !shadow-none !overflow-visible flex-1" :fancy-p="false">
                                <IconCard :heading="__('Payrolls')" :cta-text="__('Go To Payments')"
                                    :href="route('payrolls.index')">
                                    <MoneyIcon class="!mb-4 !h-12 !w-12 text-purple-500" />
                                </IconCard>
                            </Card>

                            <Card class="w-full lg:w-1/4 !shadow-none !overflow-visible flex-1" :fancy-p="false">
                                <IconCard :heading="__('Attendance')" :cta-text="__('Go to Attendance')"
                                    :href="route('attendance.dashboard')">
                                    <TableIcon class="!mb-4 !h-12 !w-12 text-purple-500" />
                                </IconCard>
                            </Card>

                            <Card class="w-full lg:w-1/4 !shadow-none !overflow-visible flex-1" :fancy-p="false">
                                <IconCard :heading="__('Calendar')" :cta-text="__('Go to Calendar')"
                                    :href="route('calendar.index')">
                                    <CalendarIcon class="!mb-4 !h-12 !w-12 text-purple-500" />
                                </IconCard>
                            </Card>

                            <Card class="w-full lg:w-1/4 !shadow-none !overflow-visible flex-1" :fancy-p="false">
                                <IconCard :heading="__('Support')" :cta-text="__('Go To Requests')"
                                    :href="route('requests.index')">
                                    <MessageIcon class="!mb-4 !h-12 !w-12 text-purple-500" />
                                </IconCard>
                            </Card>
                        </div>
                    </Card>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
@keyframes glowing {
    0% {
        box-shadow: 0 0 5px indigo;
    }

    50% {
        box-shadow: 0 0 10px indigo, 0 0 15px indigo;
    }

    100% {
        box-shadow: 0 0 5px indigo;
    }
}

.glow-element {
    animation: glowing 7s infinite;
}
</style>
