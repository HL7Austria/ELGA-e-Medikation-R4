Instance: AtEmedJourneyMedicationMagistral02
InstanceOf: AtEmedMedication
Title: "Beispiel Journey 02: Magistrale Zubereitung"
Description: "**Beschreibung:** Beispiel einer magistralen Zubereitung (Medication) - Salbe."
Usage: #example

//* status = #active
//* manufacturer = Reference(AtEmedExampleOrganizationApo01) "Amadeus Apotheke"
* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"
// CodeableConcept
* ingredient[+].itemCodeableConcept = $cs-atc#A01AC03 "Hydrocortison"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept = $cs-atc#A01AB18 "Clotrimazol"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[=].isActive = false
* ingredient[=].strength.numerator.value = 98
* ingredient[=].strength.numerator.unit = "g"
* ingredient[=].strength.denominator.value = 100
* ingredient[=].strength.denominator.unit = "g"   

// alternativ: Substance Reference
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
// * ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
// * ingredient[=].isActive = false
// * ingredient[=].strength.numerator.value = 98
// * ingredient[=].strength.numerator.unit = "g"
// * ingredient[=].strength.denominator.value = 100
// * ingredient[=].strength.denominator.unit = "g"

//* batch.lotNumber = "MAG-2026-001"
//* batch.expirationDate = "2027-01-01"

