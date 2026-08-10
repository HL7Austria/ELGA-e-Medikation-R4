Instance: AtEmedExampleDosageStandardAdministration1
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag
Title: "Beispiel Medikationsplaneintrag mit Dosierung im Tageszeitenschema 1"
Description: "Medikationsplaneintrag mit Dosierung im Tageszeitenschema (morgens, mittags, abends, nachts): 1-0-1-0."
Usage: #example

* contained[+] = AtEmedExampleMedicationIbuprofen200

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 täglich | Täglich 1 Stück morgens und 1 Stück abends"

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

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 1
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.code = #Stueck
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.unit = "Stück"
