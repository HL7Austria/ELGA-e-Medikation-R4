Instance: At-Emed-Journey-07-03-Mr-Geplante-Abgabe-03   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 07-03: Geplante Abgabe 1"
Description: "Bildet eine Geplante Abgabe von Magelan-Tropfen mit Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #example

* contained[+] = at-emed-journey-medication-metagelan
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">TODO: Some Narrative</div>"
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-03-19"
* extension[renderedDosageInstruction].valueMarkdown = "1-1-1-1 | 4 x täglich 40 Tropfen"

* status = $cs-medication-request-status#active
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category[mrcategory] = MedicationRequestCategoryCS#GeplAbgabe "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medication-metagelan"

* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* authoredOn = "2026-03-22T16:10:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01) "Dr. Hausärztin"
// TODO: zusätzliche logische Referenz: reference.identifier 

// ASW 11.10.2026 TODO sollte diese Referenz versionsspezifisch sein?
//* basedOn.reference = $rrPlaneintrag03v2 // Reference(Planeintrag-03-Wirkstoff-Metamizol-v2) "Planeintrag 3"
* basedOn.reference = $rrPlaneintrag03

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


