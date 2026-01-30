Instance: AtEmedJourneyMrPlaneintrag0202
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 2"
Description: "**Beschreibung:** Bildet einen Medikationsplaneintrag mit einer Referenz auf eine magistrale Zubereitung und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 täglich auftragen"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4712"
* status = #active
* intent = #order
* category = MedicationRequestCategoryCS#1 

// Todo: Magistrale Zubereitung wieder aktivieren
//* medicationReference = Reference(AtEmedJourneyMedicationMagistral02) "Magistrale Zubereitung"
* medicationCodeableConcept = $cs-asp-liste#0004340 "ASPIRIN TBL 500MG"

* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)

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

