Instance: At-Emed-Journey-02-Mr-Planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 1"
Description: "Bildet einen Medikationsplaneintrag mit dem Medikament EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[+] = contained-medication-journey-02-01

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 Stück"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = $cs-medication-request-status#active
* intent = #order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-02-01"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[otherDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#other
* dosageInstruction[otherDosage].sequence = 1
* dosageInstruction[otherDosage].patientInstruction = "Nehmen Sie die Kapsel nach dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[otherDosage].timing.repeat.frequency = 2
* dosageInstruction[otherDosage].timing.repeat.period = 1
* dosageInstruction[otherDosage].timing.repeat.periodUnit = #d
* dosageInstruction[otherDosage].timing.repeat.when[0] = $cs-timing#ACM "Morgens"   
* dosageInstruction[otherDosage].timing.repeat.when[+] = $cs-timing#ACV "Abends"  
* dosageInstruction[otherDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"
* dosageInstruction[otherDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-01
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-journey-02-01"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
