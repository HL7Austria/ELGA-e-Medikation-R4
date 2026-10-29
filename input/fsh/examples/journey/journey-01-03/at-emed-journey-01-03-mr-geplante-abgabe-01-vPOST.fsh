Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01-vPOST
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 1 (Request)"
Description: "Bildet eine vom GDA übermittelte Geplante Abgabe des Arzneimittels Ramipril mit Dosierungsanweisungen gemäß zugehörigem Planeintrag ab."
Usage: #inline
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0"

* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#GeplAbgabe "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Conditional Reference über PZN und Bezeichnung; wird von der Fachanwendung aufgelöst und als contained Medication persistiert
* medicationReference.reference = "Medication?code=https://termgit.elga.gv.at/CodeSystem/asp-liste|2450836&code:text=RAMIPRIL%20HEX%20TBL%205MG"

// logische Referenz über bPK-GH
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* authoredOn = "2026-02-27T08:15:00+00:00"
// logische Referenz über GDA-OID
* requester.identifier.system = "urn:ietf:rfc:3986"
* requester.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"

* basedOn = Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v1)
// TODO: zusätzliche logische Referenz: reference.identifier

// mittels $groupidentifier-create vorab bezogen (Variante A)
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
