Instance: At-Emed-Journey-03-01-Md-Durchgefuehrte-Abgabe-02
InstanceOf: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe   
Title: "Beispiel Journey 03-01: Durchgeführte Abgabe 1"
Description: "Bildet eine Durchgeführte Abgabe mit Beendigung eines Besorgerprozesses (magistrale Zubereitung Dexpanthenol-Salbe) gemäß Geplanter Abgabe ab."
Usage: #example

* contained[+] = contained-medication-magistral-01

* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0" 
* extension[recorded].valueDateTime = "2026-03-01T15:15:00+00:00" 
* extension[groupIdentifier].valueIdentifier.value = "WYE82A2G8EEW"

* status = #completed

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-magistral-01"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* performer.actor = Reference(At-Emed-Example-Organization-02) "Amadeus Apotheke"

* authorizingPrescription[geplanteAbgabe] = Reference(MedicationRequest/At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02) "Geplante Abgabe 2"
* authorizingPrescription[planeintrag] = Reference(MedicationRequest/At-Emed-Journey-01-02-Mr-Planeintrag-02) "Planeintrag 2"

* type = #FFC
* quantity = 1 '1'
* whenHandedOver = "2026-03-01T15:15:00+00:00" 

// * note.text = "Freitext zur Durchgeführten Abgabe."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Dünn auftragen."
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.value = 3
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.unit = "wk"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073566 "Anwendung auf der Haut"

