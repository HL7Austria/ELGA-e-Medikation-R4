CodeSystem: MedicationRequestStatusCS
Title: "ELGA e-Med MedicationRequest Status"
Description: "**Beschreibung:** Codesystem für zulässige Ausprägungen eines Status eines MedicationRequests im Medikationsplaneintrag und in geplanter Abgabe. 
Basiert auf VS https://hl7.org/fhir/R4/valueset-medicationrequest-status.html, ohne Status: draft, unknown"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true

* #active "active"
* #on-hold "on-hold"
* #cancelled "cancelled"
* #completed "completed"
* #entered-in-error "entered-in-error"
* #stopped "stopped"


ValueSet: MedikationsplaneintragStatusVS
Title: "ELGA e-Med Medikationsplaneintrag Status Value Set"
Description: "**Beschreibung:** ValueSet für zulässige Ausprägungen eines Status eines Medikationsplaneintrags (MedicationRequest)."
* ^experimental = true
//* include codes from system MedicationRequestCategoryCS

* include MedicationRequestStatusCS#active
* include MedicationRequestStatusCS#on-hold
* include MedicationRequestStatusCS#completed
* include MedicationRequestStatusCS#stopped



ValueSet: GeplanteAbgabeStatusVS
Title: "ELGA e-Med Geplante Abgabe Status ValueSet"
Description: "**Beschreibung:** ValueSet für zulässige Ausprägungen eines Status einer geplanten Abgabe (MedicationRequest)."

* ^experimental = true
* include codes from system MedicationRequestStatusCS
