Instance: at-emed-journey-02-mr-geplante-abgabe-01   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 02: Geplante Abgabe"
Description: "Bildet eine Geplante Abgabe des Arzneimittels Ramipril mit den Dosierungsanweisungen des zugehörigen Planeintrags ab."
Usage: #example

* contained[+] = contained-medication-journey-02-01-01

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 Stück"

//* identifier.value = "WYE82A2G8EEW_4712_202602280800000"
* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#1 "Kassenrezept"

// Referenz auf Inline Medication Ressource
* medicationReference.reference = #ContainedMedication03


* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)
//* reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"

* basedOn = Reference(MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-01) "Planeintrag"
// TODO: zusätzliche logische Referenz: reference.identifier 

* groupIdentifier.value = "WYE82A2G8EEW"

* note.text = "Freitext zur geplanten Abgabe (Info von Arzt an Apotheke)."

* dosageInstruction.extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#other
* dosageInstruction.sequence = 1
* dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel nach dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction.timing.repeat.frequency = 2
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when[0] = $cs-timing#ACM "Morgens"   
* dosageInstruction.timing.repeat.when[+] = $cs-timing#ACV "Abends"  
* dosageInstruction.doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"
* dosageInstruction.route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"

// Anzahl der erlaubten Einlösungen 
//* dispenseRequest.initialFill.quantity.value = 1
//* dispenseRequest.dispenseInterval = 30 'd' "Tage"
* dispenseRequest.validityPeriod.end = "2026-03-13"
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
// * dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-01-01
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Medikation Ramipril"
Usage: #inline
//* id = "contained-medication-journey-02-01-01"
* code = $cs-asp-liste#2450836 "RAMIPRIL HEX TBL 5MG"