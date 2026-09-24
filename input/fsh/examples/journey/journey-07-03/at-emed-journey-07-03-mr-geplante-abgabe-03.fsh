Instance: At-Emed-Journey-07-03-Mr-Geplante-Abgabe-03   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 07-03: Geplante Abgabe 1"
Description: "Bildet eine Geplante Abgabe des Arzneimittels Magelan mit Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #example

* contained[+] = contained-medication-journey-07-03-03
* text.status = #generated
* text.div = "<div>TODO: Some Narrative</div>"
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-03-19"
* extension[renderedDosageInstruction].valueMarkdown = "1-1-1-1 | 4 x täglich 40 Tropfen"

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-07-03-03"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-03-22T16:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"

* basedOn = Reference(MedicationRequest/At-Emed-Journey-07-02-Mr-Planeintrag-03) "Planeintrag 3"
// TODO: zusätzliche logische Referenz: reference.identifier 

* groupIdentifier.value = "WYE82A2G8EEW"

// * note.text = "Freitext zur geplanten Abgabe (Info von Arzt an Apotheke)."

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

* dispenseRequest.validityPeriod.end = "2026-04-20"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 2
* dispenseRequest.quantity.unit = "Packung"


// Contained Medication *********************************************************************
Instance: contained-medication-journey-07-03-03
InstanceOf: AtElgaEmedMedicationStandardMedikation
Title: "Beispiel Wirkstoffangaben (Magelan)"
Usage: #inline

* code = $cs-asp-liste#4467812 "METAGELAN TR 500MG/ML"

//* ingredient.itemCodeableConcept = https://termgit.elga.gv.at/CodeSystem/medikation-ages-wirkstoffe#4467812 "METAMIZOL NATRIUM MONOHYDRAT"
