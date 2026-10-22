Instance: At-Emed-Journey-Planeintrag-01-Ramipril-v3-tx
// war At-Emed-Journey-06-02-Mr-Planeintrag-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und geänderten Dosierungsanweisungen ab."
Usage: #inline
* id = $idPlaneintrag01
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich: 1-0-1-0" 

* status = $cs-medication-request-status#active	"Active"
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category = MedicationRequestCategoryCS#Planeintrag "Planeintrag" 
* reportedBoolean = false 

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "Medication?code=https://termgit.elga.gv.at/CodeSystem/asp-liste|2450836&code:text=RAMIPRIL"

* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* authoredOn = "2026-03-19T12:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-03) "Dr. Krankenhaus"

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].timing.repeat.when[1] = $cs-event-timing#EVE  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 1
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück" // TODO
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"  //TODO



