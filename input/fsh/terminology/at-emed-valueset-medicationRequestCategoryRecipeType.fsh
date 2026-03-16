CodeSystem: MedicationRequestCategoryRecipeTypeCS
Title: "ELGA e-Med MedicationRequest Kategorie Rezeptart CodeSystem"
Description: "Codesystem für zulässige Ausprägungen der MedicationRequest Kategorie Rezeptart."
* ^status = #active
* ^experimental = true
* ^caseSensitive = true

* #1 "Kassenrezept"
* #2 "Privatrezept"

ValueSet: MedicationRequestCategoryRecipeTypeVS
Title: "ELGA e-Med MedicationRequest Kategorie Rezeptart ValueSet"
Description: "ValueSet für zulässige Ausprägungen der MedicationRequest Kategorie Rezeptart."
* ^experimental = true
* include codes from system MedicationRequestCategoryRecipeTypeCS