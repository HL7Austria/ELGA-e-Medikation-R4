Instance: At-Emed-Example-Mr-Dosierung-Wochentag
InstanceOf: AtEmedMRPlaneintrag
Title: "Beispiel Medikationsplaneintrag mit Schema mit Wochentags-Bezug"
Description: "Medikationsplaneintrag mit Schema mit Wochentags-Bezug (jeden Dienstag und jeden Donnerstag)."
Usage: #example

* contained[+] = contained-medication-wochentag

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "dienstags — 2 Stück; donnerstags — 2 Stück"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = #active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-wochentag"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* dosageInstruction.timing.repeat.frequency = 2
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #wk
* dosageInstruction.timing.repeat.dayOfWeek[0] = #tue
* dosageInstruction.timing.repeat.dayOfWeek[+] = #thu
* dosageInstruction.doseAndRate.doseQuantity = $vs-emed-mengenart#{Stueck} "Stück"


// Contained Medication *********************************************************************
Instance: contained-medication-wochentag
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-wochentag"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"