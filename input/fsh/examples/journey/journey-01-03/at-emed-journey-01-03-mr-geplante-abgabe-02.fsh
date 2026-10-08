Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 2"
Description: "Bildet eine Geplante Abgabe mit einer magistralen Zubereitung (Dexpanthenol-Salbe) und den Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #example

* contained[+] = contained-medication-magistral-01
* text.status = #generated
* text.div = "<div> TODO: Some Narrative </div>"
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0" 

* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Inline Medication Ressource
* medicationReference.reference = "#contained-medication-magistral-01"

* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"

* basedOn = Reference(MedicationRequest/At-Emed-Journey-01-02-Mr-Planeintrag-02) "Planeintrag 2"
// TODO: zusätzliche logische Referenz: reference.identifier 

* groupIdentifier.value = "WYE82A2G8EEW"

// * note.text = "Freitext zur geplanten Abgabe (Info von Arzt an Apotheke)."

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

* dispenseRequest.validityPeriod.end = "2026-03-27"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
