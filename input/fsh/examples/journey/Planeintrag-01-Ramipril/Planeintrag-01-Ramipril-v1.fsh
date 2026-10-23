Instance: At-Emed-Journey-Planeintrag-01-Ramipril-v1
// war 01-02-mr-planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und der Dosierungsanweisung ab."
Usage: #example
* id = $idPlaneintrag01
* meta.versionId = $idPlaneintrag01v1
* contained[+] = at-emed-journey-medication-ramipril

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0" 

* status = $cs-medication-request-status#active
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category = MedicationRequestCategoryCS#Planeintrag "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medication-ramipril"

* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = "Patient/At-Emed-Example-Patient-01"

* authoredOn = "2026-02-27T08:10:00+00:00" 
* requester = Reference(At-Emed-Example-Practitioner-01) "Dr. Hausärztin"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 1
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück" // TODO
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"  //TODO
