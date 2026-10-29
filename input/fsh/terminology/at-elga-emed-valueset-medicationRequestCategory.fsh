CodeSystem: MedicationRequestCategoryCS
Id: at-elga-emed-codesystem-medicationrequestcategory-cs
Title: "AT ELGA e-Medikation MedicationRequest Kategorie CodeSystem"
Description: "Codesystem für zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von Geplanten Abgaben und Medikationsplaneinträgen."
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #Planeintrag "Planeintrag"
* #GeplAbgabe "Geplante Abgabe"


ValueSet: MedicationRequestCategoryVS
Id: at-elga-emed-valueset-medicationrequestcategory-vs
Title: "AT ELGA e-Medikation MedicationRequest Kategorie ValueSet"
Description: "ValueSet für zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von Geplanten Abgaben und Medikationsplaneinträgen"
* ^experimental = false
* include codes from system MedicationRequestCategoryCS