ValueSet: MedikationsplaneintragStatusVS
Title: "ELGA e-Med Medikationsplaneintrag Status Value Set"
Description: "ValueSet für zulässige Ausprägungen eines Status eines Medikationsplaneintrags (MedicationRequest)."
* ^experimental = true
//* include codes from system MedicationRequestCategoryCS

* $cs-medication-request-status#active
* $cs-medication-request-status#on-hold
* $cs-medication-request-status#stopped
* $cs-medication-request-status#entered-in-error
* $cs-medication-request-status#completed
