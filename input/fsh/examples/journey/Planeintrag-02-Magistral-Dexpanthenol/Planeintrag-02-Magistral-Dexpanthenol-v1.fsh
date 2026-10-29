Instance: At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
// war At-Emed-Journey-01-02-Mr-Planeintrag-02
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 2"
Description: "Bildet einen Planeintrag mit einer magistralen Zubereitung (Dexpanthenol-Salbe) und der Dosierungsanweisung ab."
Usage: #example
* id = $idPlaneintrag02
* meta.versionId = $idPlaneintrag02v1
* meta.lastUpdated = "2026-02-27T08:10:00.360+00:00"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">TODO</div>"
* contained[+] = contained-medication-magistral-01
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0 für 3 Wochen" 

* status = $cs-medication-request-status#active
* intent = http://hl7.org/fhir/CodeSystem/medicationrequest-intent#order
* category = MedicationRequestCategoryCS#Planeintrag "Planeintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-magistral-01"

* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = Reference(At-Emed-Example-Patient-01)

* authoredOn = "2026-02-27T08:10:00+00:00"
// logische Referenz über GDA-OID
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"
* requester = Reference(At-Emed-Example-Practitioner-01)

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

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
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.system = $cs-ucum
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.code = #wk 
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 2        // TODO: Angabe für Salbe
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073566 "Anwendung auf der Haut"




