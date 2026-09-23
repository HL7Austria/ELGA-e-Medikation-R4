Instance: At-Emed-Journey-07-01-Mr-Planeintrag-03
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 07-01: Planeintrag 3"
Description: "Bildet einen geänderten Planeintrag ab (Arzneimittel ersetzt reine Wirkstoffangabe, angepasste Dosierung."
Usage: #example

* contained[+] = contained-medication-journey-07-01-02
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-03-19"
* extension[renderedDosageInstruction].valueMarkdown = "1-1-1-1 | 4 x täglich 40 Tropfen"

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-07-01-02"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-03-19T12:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-03) "Dr. Krankenhaus"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tropfen nach dem Essen ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 4
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#NOON
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#NIGHT
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 40       
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Tropfen} "Tropfen"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-07-01-02
InstanceOf: AtElgaEmedMedicationMagistraleZubereitung
Title: "Beispiel Wirkstoffangaben (Magelan)"
Usage: #inline

* code = $cs-asp-liste#4467812 "METAGELAN TR 500MG/ML"

* ingredient.itemCodeableConcept = https://termgit.elga.gv.at/CodeSystem/medikation-ages-wirkstoffe#4467812 "METAMIZOL NATRIUM MONOHYDRAT"
