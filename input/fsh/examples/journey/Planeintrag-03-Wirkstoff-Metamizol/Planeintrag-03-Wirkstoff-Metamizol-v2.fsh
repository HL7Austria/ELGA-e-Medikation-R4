Instance: Planeintrag-03-Wirkstoff-Metamizol-v2
// war At-Emed-Journey-07-02-Mr-Planeintrag-03
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 07-02: Planeintrag 3"
Description: "Bildet einen geänderten Planeintrag ab: Arzneimittel (Magelan-Tropfen) ersetzt reine Wirkstoffangabe, angepasste Dosierung."
Usage: #inline
* id = $idPlaneintrag03
* meta.versionId = $idPlaneintrag03v2
* contained[+] = at-emed-journey-medication-metagelan
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-03-19"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-26"
* extension[renderedDosageInstruction].valueMarkdown = "1-1-1-1 | 4 x täglich 40 Tropfen"

* status = $cs-medication-request-status#active
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category = MedicationRequestCategoryCS#Planeintrag "Planeintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medication-metagelan"

* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = Reference(At-Emed-Example-Patient-01)

* authoredOn = "2026-03-22T16:10:00+00:00"
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.4"
* requester = Reference(At-Emed-Example-Practitioner-04)

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
