ValueSet: MedikationsplaneintragStatusVS
Title: "ELGA e-Med Medikationsplaneintrag Status Value Set"
Description: "**Beschreibung:** ValueSet für zulässige Ausprägungen eines Status eines Medikationsplaneintrags (MedicationRequest)."
* ^experimental = true
//* include codes from system MedicationRequestCategoryCS

* include $cs-medication-request-status#active
* include $cs-medication-request-status#on-hold
* include $cs-medication-request-status#completed
* include $cs-medication-request-status#stopped



ValueSet: GeplanteAbgabeStatusVS
Title: "ELGA e-Med Geplante Abgabe Status ValueSet"
Description: "**Beschreibung:** ValueSet für zulässige Ausprägungen eines Status einer geplanten Abgabe (MedicationRequest)."

* ^experimental = true
* include codes from system $cs-medication-request-status
