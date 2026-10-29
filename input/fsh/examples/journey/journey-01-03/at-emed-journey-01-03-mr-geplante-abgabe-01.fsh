Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 1"
Description: "Bildet eine persistierte Geplante Abgabe des Arzneimittels Ramipril mit Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #example
* id = $idGeplanteAbgabe01
* meta.versionId = $idGeplanteAbgabe01v1
* meta.lastUpdated = "2026-02-27T08:15:00.204+00:00"
* contained[+] = at-emed-journey-medication-ramipril
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Narrative in Arbeit.</div>"
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0"

* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#GeplAbgabe "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medication-ramipril"

// logische Referenz über bPK-GH, ergänzt um aufgelöste Referenz
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = "Patient/At-Emed-Example-Patient-01"

* authoredOn = "2026-02-27T08:15:00+00:00"
// logische Referenz über GDA-OID, ergänzt um aufgelöste Referenz
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"
* requester = Reference(At-Emed-Example-Practitioner-01)

* basedOn = Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v1)
// TODO: zusätzliche logische Referenz: reference.identifier

* groupIdentifier.system = $sys-eMed-groupIdentifier
* groupIdentifier.value = "WYE82A2G8EEW"

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN
* dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 1
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück"
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"

* dispenseRequest.validityPeriod.start = "2026-02-27"
* dispenseRequest.validityPeriod.end = "2026-03-27"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
