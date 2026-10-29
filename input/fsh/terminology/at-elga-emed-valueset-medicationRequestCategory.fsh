CodeSystem: MedicationRequestCategoryCS
Id: at-elga-emed-codesystem-medicationrequestcategory-cs
Title: "At ELGA e-Medikation MedicationRequest Kategorie CodeSystem"
Description: "Codesystem für zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von Geplanten Abgaben und Medikationsplaneinträgen."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
* #Planeintrag "Planeintrag"
* #GeplAbgabe "Geplante Abgabe"


ValueSet: MedicationRequestCategoryVS
Id: at-elga-emed-valueset-medicationrequestcategory-vs
Title: "At ELGA e-Medikation MedicationRequest Kategorie ValueSet"
Description: "ValueSet für zulässige Ausprägungen der MedicationRequest Kategorie. Dient der Unterscheidung von Geplanten Abgaben und Medikationsplaneinträgen"
* ^experimental = true
* include codes from system MedicationRequestCategoryCS