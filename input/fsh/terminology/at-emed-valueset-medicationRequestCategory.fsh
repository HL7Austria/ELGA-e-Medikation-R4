CodeSystem: MedicationRequestCategoryCS
Title: "ELGA e-Medikation MedicationRequest Kategorie CodeSystem"
Description: "Zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von geplanten Abgaben und Medikationsplaneinträgen."
* ^status = #active
* ^experimental = true
* ^caseSensitive = true

* #1 "Medikationsplaneintrag"
* #2 "Geplante Abgabe"

ValueSet: MedicationRequestCategoryVS
Title: "ELGA e-Medikation MedicationRequest Kategorie ValueSet"
Description: "ValueSet für Zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von geplanten Abgaben und Medikationsplaneinträgen"
* ^experimental = true
* include codes from system MedicationRequestCategoryCS