Instance: At-Emed-Example-Mr-Planeintrag
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Example Medikationsplaneintrag"
Description: "Bildet einen Medikationsplaneintrag mit dem Medikament EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[medication] = ContainedMedication01

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 Kapsel täglich morgens"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
//* status = $cs-medication-request-status#active
* status = #active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 

* reportedBoolean = false

// Referenz auf Inline Medication Ressource
* medicationReference.reference = "#ContainedMedication01"

* subject = Reference(At-Emed-Journey-01-Patient-01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(At-Emed-Journey-01-Practitioner-01)

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



// Contained Medication *********************************************************************
Instance: ContainedMedication01
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "ContainedMedication01"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"


