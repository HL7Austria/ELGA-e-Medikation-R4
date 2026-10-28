Instance: at-emed-journey-medication-ramipril
InstanceOf: AtElgaEmedMedicationStandardMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #example

* code = $cs-asp-liste#2450836 "RAMIPRIL HEX TBL 5MG"
* form = $cs-emed-doseform#100000073664 "Tablette"
* amount.numerator = 30 '{Stueck}' "Stück"
* amount.denominator.value = 1
* ingredient.itemCodeableConcept.coding[ATCWidO] = $cs-atc#C09AA05 "Ramipril"
* ingredient.itemCodeableConcept.coding[WirkstoffeAges] = https://termgit.elga.gv.at/CodeSystem/medikation-ages-wirkstoffe#100000092240 "RAMIPRIL"
* ingredient.isActive = true
* ingredient.strength.numerator = 5 'mg' "mg"
* ingredient.strength.denominator = 1 '{Stueck}' "Stück"