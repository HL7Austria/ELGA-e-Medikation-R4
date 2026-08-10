Extension: AtElgaEmedExtensionDosageCategory
Id:  at-elga-emed-extension-dosage-category
Title: "AT ELGA e-Medikation Extension Dosierungskategorie"
Description: "AT ELGA e-Medikation Extension Dosierungskategorie"
Context: Dosage
* value[x] 1..1
* value[x] only CodeableConcept
* value[x] from AtElgaEmedValueSetDosageCategory (required)
* value[x] ^binding.description = "Code für die Art der Dosierung"