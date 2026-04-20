Instance: At-Emed-Example-Mr-Dosierung-Wochentag-Kombi
InstanceOf: AtEmedMRPlaneintrag
Title: "Beispiel Medikationsplaneintrag mit Dosierung als Kombination von Wochentagen"
Description: "Medikationsplaneintrag mit Dosierung als Kombination von Wochentagen (montags 1-0-1-0 Stück; freitags 1-0-1-0 Stück)."
Usage: #example

* contained[+] = contained-medication-wochentag-kombi

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "montags 1-0-1-0 Stück; freitags 1-0-1-0 Stück"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = $cs-medication-request-status#active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-wochentag-kombi"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* dosageInstruction.timing.repeat.frequency = 4
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #wk
* dosageInstruction.timing.repeat.dayOfWeek[0] = #mon
* dosageInstruction.timing.repeat.dayOfWeek[+] = #fri
* dosageInstruction.timing.repeat.when[0] = #MORN
* dosageInstruction.timing.repeat.when[+] = #EVE
* dosageInstruction.doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"

// Contained Medication *********************************************************************
Instance: contained-medication-wochentag-kombi
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-wochentag-kombi"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"