Instance: At-Emed-Journey-01-02-Mr-Planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und der Dosierungsanweisung ab."
Usage: #example

* contained[+] = contained-medication-journey-01-02-01

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0" 

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-01-02-01"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-02-27T08:10:00+00:00" 
* requester = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück" // TODO
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"  //TODO


// Contained Medication *********************************************************************
Instance: contained-medication-journey-01-02-01
InstanceOf: AtElgaEmedMedicationStandardMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #inline

* code = $cs-asp-liste#2450836 "RAMIPRIL HEX TBL 5MG"
