Instance: At-Emed-Journey-07-02-Mr-Planeintrag-02
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 07-02: Planeintrag 2"
Description: "Bildet einen abgelaufenen Planeintrag ab (Dexpanthenol-Salbe)."
Usage: #example

* contained[+] = contained-medication-magistral-01
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0 für 3 Wochen" 

* status = $cs-medication-request-status#stopped "Stopped"
* statusReason.coding = http://terminology.hl7.org/CodeSystem/medicationrequest-status-reason#abgl "Planeintrag Abgelaufen" 
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-magistral-01"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-02-27T08:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.value = 3
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.unit = "wk"
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 2        // TODO: Angabe für Salbe
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073566 "Anwendung auf der Haut"



