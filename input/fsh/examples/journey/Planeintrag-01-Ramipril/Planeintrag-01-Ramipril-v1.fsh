Instance: At-Emed-Journey-Planeintrag-01-Ramipril-v1
// war 01-02-mr-planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und der Dosierungsanweisung ab."
Usage: #inline
* id = "6bacfe23-d469-4945-bf3c-90c7e647aa52"
* meta.versionId = "v1v1aeb5e5e8-785a-430b-afef-ee57335b213d"
* contained[+] = at-emed-journey-medication-ramipril

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0" 

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medication-ramipril"

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
