Instance: At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-01
InstanceOf: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe   
Title: "Beispiel Journey 02-01: Durchgeführte Abgabe 1"
Description: "Bildet eine Durchgeführte Abgabe mit dem Arzneimittel Ramipril gemäß Geplanter Abgabe ab."
Usage: #example


* contained[+] = at-emed-journey-medicaiton-ramipril

* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-1 | Täglich: 1-0-0-0" 
* extension[recorded].valueDateTime = "2026-02-28T11:00:00+00:00" 
* extension[groupIdentifier].valueIdentifier.value = "WYE82A2G8EEW"

* status = #completed

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medicaiton-ramipril"

* subject = Reference(At-Emed-Example-Patient-01)
* performer.actor = Reference(At-Emed-Example-Organization-Apo-01)

* authorizingPrescription[geplanteAbgabe] = Reference(MedicationRequest/At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01) "GeplanteAbgabe 1"
* authorizingPrescription[planeintrag] = Reference(MedicationRequest/At-Emed-Journey-01-02-Mr-Planeintrag-01) "Planeintrag 1"

* type = #FFC
* quantity = 1 '1'
* whenHandedOver = "2026-02-28T11:00:00+00:00"

// * note.text = "Freitext zur Durchgeführten Abgabe."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"

