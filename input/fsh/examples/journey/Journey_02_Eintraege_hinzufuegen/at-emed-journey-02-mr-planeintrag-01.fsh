Instance: At-Emed-Journey-02-Mr-Planeintrag-01
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 1"
Description: "Bildet einen Medikationsplaneintrag mit dem Medikament EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[medication] = contained-medication-journey-02-01

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 Stück"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = #active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-02-01"

* subject = Reference(At-Emed-Journey-01-Patient-01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(At-Emed-Journey-01-Practitioner-01)

* dosageInstruction.timing.repeat.frequency = 2
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when[0] = $vs-einnahmezeitpunkte#ACM  // morgens
* dosageInstruction.timing.repeat.when[+] = $vs-einnahmezeitpunkte#ACV  // abends
* dosageInstruction.doseAndRate.doseQuantity = $vs-emed-mengenart#{Stueck} "Stück"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-01
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-journey-02-01"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
