Instance: AtEmedJourneyMrPlaneintrag0201
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 1"
Description: "**Beschreibung:** Bildet einen Medikationsplaneintrag mit dem Medikament EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[medication] = InlineAtEmedJourneyMedicationMagistral01

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 Kapsel täglich morgens"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4711"
* status = #active
* intent = #order
* category = MedicationRequestCategoryCS#1 


* medicationReference.reference = #InlineAtEmedJourneyMedicationMagistral01


// dtz. nicht möglich
//* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"

* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)

//* reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"
* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction.text = "1 Kapsel täglich morgens"
* dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel jeden Morgen mit ausreichend Flüssigkeit ein."
//* dosageInstruction.additionalInstruction = $sct#1153465004 "Education about overdosing"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.timing.period = 4
// * dosageInstruction.timing.periodMax = 6
// * dosageInstruction.timing.periodUnit = "h"
// * dosageInstruction.asNeededCodeableConcept = $sct#56018004 "wheezing"
* dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073619 "zum Einnehmen"
* dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction.maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction.maxDosePerPeriod.denominator = 1 '{day}' "{day}"



// Inline Medication

Instance: InlineAtEmedJourneyMedicationMagistral01
InstanceOf: AtEmedMedication
Title: "Beispiel Journey 02: Magistrale Zubereitung"
Description: "**Beschreibung:** Beispiel einer magistralen Zubereitung (Medication) - Salbe."
Usage: #inline

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


