import { usePage } from "@inertiajs/vue3";

export function useExtractPersonalDetails() {
    function extractPersonalDetails(nationalId) {
        // Remove dashes if the user entered them (XXXXX-XXXXXXX-X -> XXXXXXXXXXXXX)
        const cleanId = nationalId.toString().replace(/-/g, "");

        // 1. GENDER LOGIC (Last digit of CNIC)
        // Odd = Male, Even = Female
        const lastDigit = parseInt(cleanId.charAt(cleanId.length - 1));
        const isMale = lastDigit % 2 !== 0;

        // 2. PROVINCE LOGIC (First digit of CNIC)
        const provinceCode = cleanId.charAt(0);
        const provinces = {
            1: "Khyber Pakhtunkhwa",
            2: "FATA (Merged)",
            3: "Punjab",
            4: "Sindh",
            5: "Balochistan",
            6: "Islamabad (ICT)",
            7: "Gilgit-Baltistan",
        };

        const state = provinces[provinceCode] || "Unknown";

        // 3. BIRTH DATE LOGIC
        // IMPORTANT: Pakistani CNICs do NOT contain birth dates.
        // We return null or a placeholder to avoid showing "wrong" data.
        return {
            year: null,
            month: null,
            day: null,
            date: "Not available in CNIC",
            date_localized: "Not available in CNIC",
            state: state,
            isMale: isMale,
        };
    }
    return { extractPersonalDetails };
}
