Instance: At-Emed-Journey-02-Mr-Planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 1"
Description: "Bildet einen Medikationsplaneintrag mit dem Arzneimittel Ramipril und zugehörigen Dosierungsanweisungen ab."
Usage: #example

* contained[+] = contained-medication-journey-02-01

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 täglich | Täglich 1 Stück morgens" // TODO prüfen

//* identifier.value = "4713_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = $cs-medication-request-status#active
* intent = #order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-02-01"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T08:10:00+00:00" 
* requester = Reference(At-Emed-Example-Practitioner-01)

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-01
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #inline
//* id = "contained-medication-journey-02-01"
* code = $cs-asp-liste#2450836 "RAMIPRIL HEX TBL 5MG"
