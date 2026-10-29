Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 2"
Description: "Bildet eine persistierte Geplante Abgabe mit einer magistralen Zubereitung (Dexpanthenol-Salbe) und den Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #example
* id = $idGeplanteAbgabe02
* meta.versionId = $idGeplanteAbgabe02v1
* meta.lastUpdated = "2026-02-27T08:15:00.231+00:00"
* contained[+] = contained-medication-magistral-01
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">TODO</div>"
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0 für 3 Wochen"

* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#GeplAbgabe "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-magistral-01"

// logische Referenz über bPK-GH, ergänzt um aufgelöste Referenz
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = "Patient/At-Emed-Example-Patient-01"

* authoredOn = "2026-02-27T08:15:00+00:00"
// logische Referenz über GDA-OID, ergänzt um aufgelöste Referenz
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"
* requester = Reference(At-Emed-Example-Practitioner-01)

* basedOn = Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1)
// TODO: zusätzliche logische Referenz: reference.identifier

* groupIdentifier.system = $sys-eMed-groupIdentifier
* groupIdentifier.value = "WYE82A2G8EEW"

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
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073566 "Anwendung auf der Haut"

* dispenseRequest.validityPeriod.start = "2026-02-27"
* dispenseRequest.validityPeriod.end = "2026-03-27"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
