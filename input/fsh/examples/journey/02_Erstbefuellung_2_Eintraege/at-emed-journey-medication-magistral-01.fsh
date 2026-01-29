
Alias: $standardterms = http://standardterms.edqm.eu


Instance: ExampleMedicationMagistral01
InstanceOf: AtEmedMedication
Title: "Beispiel Medication Magistral 01"
Description: "Beispiel Medication - Magistrale Zubereitung - Inotyol Salbe mit Canesten Creme, 2x täglich"
Usage: #example

* status = #active

* manufacturer = Reference(AtEmedExampleOrganizationApo01) "Amadeus Apotheke"

* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"

// * ingredient[+].itemReference = Reference(AtEmedJourneySubstanceHydrocortison) "Hydrocortison"
// * ingredient[=].strength.numerator.value = 1
// * ingredient[=].strength.numerator.unit = "%"
// * ingredient[=].strength.denominator.value = 100
// * ingredient[=].strength.denominator.unit = "g"
// * ingredient[+].itemReference = Reference(AtEmedJourneySubstanceClotrimazol) "Clotrimazol"
// * ingredient[=].strength.numerator.value = 1
// * ingredient[=].strength.numerator.unit = "%"
// * ingredient[=].strength.denominator.value = 100
// * ingredient[=].strength.denominator.unit = "g"
// // * ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
// // * ingredient[=].isActive = false
// // * ingredient[=].strength.numerator.value = 98
// // * ingredient[=].strength.numerator.unit = "g"
// // * ingredient[=].strength.denominator.value = 100
// // * ingredient[=].strength.denominator.unit = "g"


// nicht möglich: vorgabe entsprechend aps medication profil: ingredient.item[x] only Reference(http://hl7.org/fhir/StructureDefinition/Substance or AtEmedMedication)
* ingredient[+].itemCodeableConcept = $cs-atc#A01AC03 "Hydrocortison"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept = $cs-atc#A01AB18 "Clotrimazol"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
// * ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
// * ingredient[=].isActive = false
// * ingredient[=].strength.numerator.value = 98
// * ingredient[=].strength.numerator.unit = "g"
// * ingredient[=].strength.denominator.value = 100
// * ingredient[=].strength.denominator.unit = "g"   

* batch.lotNumber = "MAG-2026-001"
* batch.expirationDate = "2027-01-01"


//Bsp aus EPA https://gemspec.gematik.de/ig/fhir/epa-medication/1.3.0/Medication-3f0b0cb0-e8cf-4aaf-bad8-01a51619417b.json

// Alias: $sct = http://snomed.info/sct
// Alias: $epa-drug-category-cs = https://gematik.de/fhir/epa-medication/CodeSystem/epa-drug-category-cs
// Alias: $ask = http://fhir.de/CodeSystem/ask

// Instance: 3f0b0cb0-e8cf-4aaf-bad8-01a51619417b
// InstanceOf: Medication
// Usage: #example
// * meta.versionId = "2"
// * meta.lastUpdated = "2025-12-03T14:00:00.244Z"
// * meta.profile = "https://gematik.de/fhir/epa-medication/StructureDefinition/epa-medication|1.3.0"
// * extension[0].url = "https://gematik.de/fhir/epa-medication/StructureDefinition/rx-prescription-process-identifier-extension"
// * extension[=].valueIdentifier.system = "https://gematik.de/fhir/epa-medication/sid/rx-prescription-process-identifier"
// * extension[=].valueIdentifier.value = "160.100.000.000.019.82_20251202"
// * extension[+].url = "https://gematik.de/fhir/epa-medication/StructureDefinition/epa-medication-type-extension"
// * extension[=].valueCoding = $sct#763158003 "Medicinal product (product)"
// * extension[+].url = "https://gematik.de/fhir/epa-medication/StructureDefinition/drug-category-extension"
// * extension[=].valueCoding = $epa-drug-category-cs#00
// * extension[+].url = "http://fhir.de/StructureDefinition/normgroesse"
// * extension[=].valueCode = #N3
// * extension[+].url = "https://gematik.de/fhir/epa-medication/StructureDefinition/medication-id-vaccine-extension"
// * extension[=].valueBoolean = false
// * identifier[0].system = "https://gematik.de/fhir/epa-medication/sid/epa-medication-unique-identifier"
// * identifier[=].value = "6E36794F8327D7B96B74DC7E29FFCB49CC2CD859EBB58251DC1FB4456BEF92A9"
// * identifier[+].system = "https://gematik.de/fhir/epa-medication/sid/rx-originator-process-identifier"
// * identifier[=].value = "48de03e7-84f3-4724-830e-5aabca10dfa8_160.100.000.000.019.82"
// * status = #active
// * form.text = "Tabletten"
// * amount.numerator.extension.url = "https://gematik.de/fhir/epa-medication/StructureDefinition/medication-total-quantity-formulation-extension"
// * amount.numerator.extension.valueString = "100"
// * amount.numerator.unit = "Stück"
// * amount.denominator.value = 1
// * ingredient.itemCodeableConcept = $ask#22686
// * ingredient.itemCodeableConcept.text = "Ramipril"
// * ingredient.strength.numerator.value = 5
// * ingredient.strength.numerator.unit = "mg"
// * ingredient.strength.denominator.value = 1
// * ingredient.strength.denominator.unit = "Tbl."