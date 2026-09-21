Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 1"
Description: "Bildet eine Geplante Abgabe des Arzneimittels Ramipril mit den Dosierungsanweisungen des zugehörigen Planeintrags ab."
Usage: #example

* contained[+] = contained-medication-journey-01-03-01

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-1 | Täglich: 1-0-0-0" 

//* identifier.value = "WYE82A2G8EEW_4713202602270810000"

* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-01-03-01"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T08:10:00+00:00" 
* requester = Reference(At-Emed-Example-Practitioner-01)

* basedOn = Reference(MedicationRequest/At-Emed-Journey-01-02-Mr-Planeintrag-01) "Planeintrag 1"
// TODO: zusätzliche logische Referenz: reference.identifier 

* groupIdentifier.value = "WYE82A2G8EEW"

// * note.text = "Freitext zur geplanten Abgabe (Info von Arzt an Apotheke)."

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

* dispenseRequest.validityPeriod.end = "2026-03-27"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"

// Contained Medication *********************************************************************
Instance: contained-medication-journey-01-03-01
InstanceOf: AtElgaEmedMedicationStandardMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #inline

* code = $cs-asp-liste#2450836 "RAMIPRIL HEX TBL 5MG"