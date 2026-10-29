Instance: At-Emed-Journey-Planeintrag-01-Ramipril-vPOST
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und der Dosierungsanweisung ab."
Usage: #inline

* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"

* status = $cs-medication-request-status#active
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category = MedicationRequestCategoryCS#Planeintrag "Planeintrag" 
* reportedBoolean = false 

// Conditional Reference über PZN und Bezeichnung; wird von der Fachanwendung aufgelöst und als contained Medication persistiert
* medicationReference.reference = "Medication?code=https://termgit.elga.gv.at/CodeSystem/asp-liste|2450836&code:text=RAMIPRIL%20HEX%20TBL%205MG"

* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
 //Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* authoredOn = "2026-02-27T08:10:00+00:00" 
// logische Referenz über GDA-OID
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"

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
