Instance: At-Emed-Journey-04-Md-Durchgefuehrte-Abgabe-02
InstanceOf: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe   
Title: "Beispiel Journey 04: Durchgeführte Abgabe 1"
Description: "Bildet eine durchgeführte Abgabe mit dem Arzneimittel Ramipril gemäß Geplanter Abgabe."
Usage: #example


* contained[+] = contained-medication-journey-04-02-magistral

* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0" 
* extension[recorded].valueDateTime = "2026-02-28T11:00:00+00:00" 
* extension[groupIdentifier].valueIdentifier.value = "WYE82A2G8EEW"

* status = #completed

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-04-02-magistral"

* subject = Reference(At-Emed-Example-Patient-01)
* performer.actor = Reference(At-Emed-Example-Organization-Apo-01)

* authorizingPrescription[geplanteAbgabe] = Reference(MedicationRequest/At-Emed-Journey-03-Mr-Geplante-Abgabe-02) "GeplanteAbgabe 1"
* authorizingPrescription[planeintrag] = Reference(MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-02) "Planeintrag 1"

* type = #FFP
* quantity = 0 '0'
// * whenHandedOver = "2026-02-28T11:00:00+00:00"

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


// Contained Medication *********************************************************************
Instance: contained-medication-journey-04-02-magistral
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #inline

//* status = #active
//* manufacturer = Reference(AtElgaEmed-Example-Organization-Apo-01) "Amadeus Apotheke"
* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"

* ingredient[+].itemCodeableConcept = $cs-atc#A11HA30 "Dexpanthenol"
* ingredient[=].strength.numerator = 5 'g' "g"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[=].isActive = false
* ingredient[=].strength.numerator.value = 95
* ingredient[=].strength.numerator.unit = "g"
* ingredient[=].strength.denominator.value = 100
* ingredient[=].strength.denominator.unit = "g"