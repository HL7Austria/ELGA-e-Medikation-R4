Instance: AtEmedExampleDosageStandardAdministration2
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag
Title: "Beispiel Medikationsplaneintrag mit Dosierung im Tageszeitenschema 2"
Description: "Medikationsplaneintrag mit Dosierung im Tageszeitenschema"
Usage: #example

* contained[+] = AtEmedExampleMedicationIbuprofen200

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "2-0-2-1 täglich | Täglich 2 Stück morgens, 2 Stück abends und 1 Stück nachts"

* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = $cs-medication-request-status#active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag"
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#AtEmedExampleMedicationIbuprofen200"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* dosageInstruction[standardDosage][0].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage][0].sequence = 1
* dosageInstruction[standardDosage][0].timing.repeat.frequency = 2
* dosageInstruction[standardDosage][0].timing.repeat.period = 1
* dosageInstruction[standardDosage][0].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage][0].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage][0].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage][0].doseAndRate.doseQuantity.value = 2
* dosageInstruction[standardDosage][0].doseAndRate.doseQuantity.system = $cs-ucum
* dosageInstruction[standardDosage][0].doseAndRate.doseQuantity.code = #Stueck
* dosageInstruction[standardDosage][0].doseAndRate.doseQuantity.unit = "Stück"

* dosageInstruction[standardDosage][1].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard 
* dosageInstruction[standardDosage][1].sequence = 1
* dosageInstruction[standardDosage][1].timing.repeat.frequency = 1
* dosageInstruction[standardDosage][1].timing.repeat.period = 1
* dosageInstruction[standardDosage][1].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage][1].timing.repeat.when[0] = $cs-timing#NIGHT "Nachts"
* dosageInstruction[standardDosage][1].doseAndRate.doseQuantity.value = 1
* dosageInstruction[standardDosage][1].doseAndRate.doseQuantity.system = $cs-ucum
* dosageInstruction[standardDosage][1].doseAndRate.doseQuantity.code = #Stueck
* dosageInstruction[standardDosage][1].doseAndRate.doseQuantity.unit = "Stück"
