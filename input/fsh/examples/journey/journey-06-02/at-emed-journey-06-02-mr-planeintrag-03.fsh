Instance: At-Emed-Journey-06-02-Mr-Planeintrag-03
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 06-02: Planeintrag 3"
Description: "Bildet einen Planeintrag mit einer Wirkstoffangabe (Metamizol) und Dosierung ab."
Usage: #example

* contained[+] = contained-medication-journey-06-02-02-wirkstoff
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-03-19"
* extension[renderedDosageInstruction].valueMarkdown = "1-1-1-1 | 4x täglich 1000 mg"

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-06-02-02-wirkstoff"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-03-19T12:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-03) "Dr. Krankenhaus"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 4
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#NOON
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#NIGHT
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 1000       
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#mg "MilliGram"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-06-02-02-wirkstoff
InstanceOf: AtElgaEmedMedicationMagistraleZubereitung
Title: "Beispiel Wirkstoffangaben (Metamizol)"
Usage: #inline

* ingredient.itemCodeableConcept = https://termgit.elga.gv.at/CodeSystem/medikation-ages-wirkstoffe#4467812 "METAMIZOL NATRIUM MONOHYDRAT"