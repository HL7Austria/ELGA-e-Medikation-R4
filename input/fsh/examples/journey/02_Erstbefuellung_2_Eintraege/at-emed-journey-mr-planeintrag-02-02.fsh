Instance: AtEmedJourneyMrPlaneintrag0202
InstanceOf: AtEmedMRPlaneintrag   
Title: "Example Medikationsplaneintrag 02 02"
Description: "Example Medikationsplaneintrag 02 02"

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 täglich auftragen"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4712"
// * identifier.system = "urn:ietf:rfc:3986"
// * identifier.value = "urn:uuid:cdbd33f0-6cde-11db-9fe1-0800200c9a66"

//* identifier.system = "http://www.bmc.nl/portal/prescriptions"
* status = #active
* intent = #order

* category.coding = http://hl7.org/fhir/medicationrequest-category#1 "Medikationsplaneintrag"

* medicationReference = Reference(ExampleMedicationMagistral01) "Magistrale Zubereitung"

* subject = Reference(AtEmedExamplePatient01)

* authoredOn = "2026-01-28T08:00:00+00:00"

* requester = Reference(AtEmedExamplePractitioner01)

// * reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"

// * groupIdentifier.value = "WYE82A2G8EE1"  // nicht im Medikationsplaneintrag

* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction.text = "1 täglich auftragen"

* dosageInstruction.patientInstruction = "Abends sehr dünn auf die betroffene Stelle auftragen."
//* dosageInstruction.additionalInstruction = $sct#1153465004 "Education about overdosing"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.timing.period = 4
// * dosageInstruction.timing.periodMax = 6
// * dosageInstruction.timing.periodUnit = "h"
// * dosageInstruction.asNeededCodeableConcept = $sct#56018004 "wheezing"

* dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

// * dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction.maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction.maxDosePerPeriod.denominator = 1 '{day}' "{day}"

// Anzahl der Einlösungen (nur in der geplanten Abgabe relevant?)
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.validityPeriod.end = "2026-02-03"
// * dispenseRequest.quantity.value = 30
// * dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"

// zugrundeliegender Medikationsplaneintrag nach einer Änderung?
//* basedOn = Reference(MedicationRequest/AtEmedExampleMedicationRequestPlaneintrag01) "Planeintrag"

