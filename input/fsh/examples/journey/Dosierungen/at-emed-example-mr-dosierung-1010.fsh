Instance: AtEmedExampleMR-Dosierung-1010
InstanceOf: AtEmedMRPlaneintrag
Title: "Beispiel Medikationsplaneintrag mit Dosierung im Tageszeitenschema"
Description: "**Beschreibung:** Medikationsplaneintrag mit Dosierung im Tageszeitenschema (morgens, mittags, abends, nachts): 1-0-1-0."
Usage: #example

* contained[medication] = ContainedMedication01-1010

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
* medicationReference.reference = "#ContainedMedication01-1010"

* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)

* dosageInstruction.timing.repeat.frequency = 2
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when[0] = $vs-einnahmezeitpunkte#ACM  // morgens
* dosageInstruction.timing.repeat.when[+] = $vs-einnahmezeitpunkte#ACV  // abends
* dosageInstruction.doseAndRate.doseQuantity = $vs-emed-mengenart#{Stueck} "Stück"


// Contained Medication *********************************************************************
Instance: ContainedMedication01-1010
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "ContainedMedication01-1010"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"