Extension: AtElgaEmedExtensionDosageCategory
Id: at-elga-emed-extension-dosage-category
Title: "AT ELGA e-Medikation Extension Dosierungskategorie"
Description: "AT ELGA e-Medikation Extension Dosierungskategorie"
Context: Dosage
* value[x] only CodeableConcept
* value[x] MS
* url MS
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from AtElgaEmedValueSetDosageCategory (required)
* valueCodeableConcept ^binding.description = "Code für die Art der Dosierung"
* valueCodeableConcept.coding 1..1 MS
* valueCodeableConcept.coding.display MS
* valueCodeableConcept.coding.code MS
* valueCodeableConcept.coding.code 1..1
* valueCodeableConcept.coding.system MS
* valueCodeableConcept.coding.system 1..1
* valueCodeableConcept.coding.system = Canonical(AtElgaEmedCodeSystemDosageCategory)
* valueCodeableConcept.coding.version MS
* valueCodeableConcept.text 0..0
//* valueCodeableConcept.text ^short = "Fachliche Begründung: TODO"