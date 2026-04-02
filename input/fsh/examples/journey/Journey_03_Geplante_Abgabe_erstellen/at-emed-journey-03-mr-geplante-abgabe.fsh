Instance: At-Emed-Journey-03-Mr-Geplante-Abgabe   
InstanceOf: AtEmedMRGeplanteAbgabe
Title: "Beispiel Journey 03: Geplante Abgabe"
Description: "Bildet eine geplante Abgabe des Medikaments EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[+] = ContainedMedication03

// R5 Backports
// * extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
// * extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 Stück"

//* identifier.value = "WYE82A2G8EEW_4712_202602280800000"
* status = #active
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

* dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel nach dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction.timing.repeat.frequency = 2
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when[0] = $vs-einnahmezeitpunkte#ACM "Morgens"   
* dosageInstruction.timing.repeat.when[+] = $vs-einnahmezeitpunkte#ACV "Abends"  
* dosageInstruction.doseAndRate.doseQuantity = $vs-emed-mengenart#{Stueck} "Stück"
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


// Inline Medication *********************************************************************
Instance: ContainedMedication03
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline

* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"




// * dosageInstruction.text = "1 Kapsel täglich morgens"
// * dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel jeden Morgen mit ausreichend Flüssigkeit ein."
// * dosageInstruction.additionalInstruction = $sct#1153465004 "Education about overdosing"
// * dosageInstruction.timing.repeat.frequency = 1
// * dosageInstruction.timing.repeat.period = 1
// * dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.timing.period = 4
// * dosageInstruction.timing.periodMax = 6
// * dosageInstruction.timing.periodUnit = "h"
// * dosageInstruction.asNeededCodeableConcept = $sct#56018004 "wheezing"
// * dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073619 "zum Einnehmen"
// * dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction.maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction.maxDosePerPeriod.denominator = 1 '{day}' "{day}"