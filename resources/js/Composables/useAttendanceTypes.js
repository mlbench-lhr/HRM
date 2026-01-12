import { __ } from "@/Composables/useTranslations.js";

export const attendance_types = {
    on_time: __("On Time"),
    late: __("Late"),
    missed: __("Missed"),
    leave: __("Paid Leave"),
    unpaid_leave: __("Unpaid Leave"),
    partial_present: __("Half Day"),
    incomplete: __("Incomplete"),
};
