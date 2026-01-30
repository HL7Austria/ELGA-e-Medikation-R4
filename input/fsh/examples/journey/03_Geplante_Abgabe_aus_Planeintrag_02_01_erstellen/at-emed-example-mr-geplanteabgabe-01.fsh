Instance: AtEmedJourneyMrGeplanteAbgabe03   
InstanceOf: AtEmedMRGeplanteAbgabe
Title: "Beispiel Journey 03: Geplante Abgabe"
Description: "**Beschreibung:** Bildet eine geplante Abgabe des Medikaments EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 Kapsel täglich morgens"

//* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "WYE82A2G8EEW-4711"
* status = #active
* intent = #order
* category = MedicationRequestCategoryCS#2 "Geplante Abgabe"

* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"

* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-29T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)
* reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"

* groupIdentifier.value = "WYE82A2G8EE1"

* note.text = "Freitext Informationen zur geplanten Abgabe."

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

// Anzahl der erlaubten Einlösungen 
* dispenseRequest.numberOfRepeatsAllowed = 1
// * dispenseRequest.validityPeriod.end = "2026-02-03"
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"

* basedOn = Reference(MedicationRequest/AtEmedJourneyMrPlaneintrag0201) "Planeintrag"

