Instance: At-Emed-Example-Mr-Dosierung-Zeitintervalle-Kombi
InstanceOf: AtEmedMRPlaneintrag
Title: "Beispiel Medikationsplaneintrag Dosierung als Kombination von Zeitintervallen"
Description: "Medikationsplaneintrag mit Dosierung als Kombination von Zeitintervallen (alle 2 Tage: 08:00 Uhr — je 1 Stück; 18:00 Uhr — je 2 Stück)."
Usage: #example

* contained[+] = contained-medication-zeitintervalle-kombi

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "alle 2 Tage: 08:00 Uhr — je 1 Stück; 18:00 Uhr — je 2 Stück"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = #active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-zeitintervalle-kombi"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 2
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "08:00:00"
* dosageInstruction.doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"
* dosageInstruction[+].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 2
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "18:00:00"
* dosageInstruction.doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"




// Contained Medication *********************************************************************
Instance: contained-medication-zeitintervalle-kombi
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-zeitintervalle-kombi"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"