Alias: $atc = http://www.whocc.no/atc
Alias: $standardterms = http://standardterms.edqm.eu
Alias: $sct = http://snomed.info/sct

Instance: ExampleMedicationCefuroxime
InstanceOf: AtEmedMedication
Title: "Beispiel Medication Cefuroxime"
Description: "Beispiel Medication Cefuroxime"
Usage: #example
// * code = http://www.whocc.no/atc#C09AA05 "Ramipril"
// * code.text = "Ramipril 5mg Kapseln"
// * status = #active
// * manufacturer = Reference(Organization/AtApsExampleOrganization01) "Amadeus Spital"
// * ingredient.itemReference = Reference(Medication/AtApsExampleMedication01) "Ramipril Wirkstoff"
// * ingredient.isActive = true
// * ingredient.strength.numerator.value = 500
// * ingredient.strength.numerator.unit = "mg"
// * ingredient.strength.numerator.system = "http://unitsofmeasure.org"
// * ingredient.strength.numerator.code = #mg
// * ingredient.strength.denominator.value = 1
// * ingredient.strength.denominator.unit = "Kapsel"
// * ingredient.strength.denominator.system = "http://unitsofmeasure.org"
// * ingredient.strength.denominator.code = #1

// Bsp von Medication Resource
* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/Medication-eu-mpd"
* extension.url = "https://profiles.ihe.net/PHARM/MPD/StructureDefinition/ihe-ext-medication-classification"
* extension.valueCodeableConcept = $atc#J01DC02 "cefuroxime"
* form = $standardterms#50053000 "Powder for solution for injection or infusion"
* ingredient.itemCodeableConcept = $sct#372833007 "Cefuroxime"
* ingredient.isActive = true
* ingredient.strength.numerator = 1500 'mg' "milligram"
* ingredient.strength.denominator = 1 http://standardterms.edqm.eu#15060000 "Vial"