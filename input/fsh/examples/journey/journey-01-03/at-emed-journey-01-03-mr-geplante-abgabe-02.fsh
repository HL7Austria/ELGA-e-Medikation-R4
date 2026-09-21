Instance: At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02   
InstanceOf: AtElgaEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Journey 01-03: Geplante Abgabe 2"
Description: "Bildet eine Geplante Abgabe mit einer magistralen Zubereitung (Dexpanthenol-Salbe) mit den Dosierungsanweisungen des zugehörigen Planeintrags ab."
Usage: #example

* contained[+] = contained-medication-journey-01-03-02-magistral

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0" 

//* identifier.value = "WYE82A2G8EEW_4712202602270810000"
* status = $cs-medication-request-status#active
* intent = #order
* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[recipetype] = $cs-medication-rezeptart#KASSEN "Kassenrezept"

// Referenz auf Inline Medication Ressource
* medicationReference.reference = "#contained-medication-journey-01-03-02-magistral"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

* basedOn = Reference(MedicationRequest/At-Emed-Journey-01-02-Mr-Planeintrag-02) "Planeintrag 2"
// TODO: zusätzliche logische Referenz: reference.identifier 

* groupIdentifier.value = "WYE82A2G8EEW"

// * note.text = "Freitext zur geplanten Abgabe (Info von Arzt an Apotheke)."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.value = 3
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.unit = "wk"
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 2
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

* dispenseRequest.validityPeriod.end = "2026-03-27"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"

// Contained Medication *********************************************************************
Instance: contained-medication-journey-01-03-02-magistral
InstanceOf: AtElgaEmedMedicationMagistraleZubereitung
Title: "Beispiel Journey 02: Magistrale Anwendung (Dexpanthenol-Salbe)"
Usage: #inline

//* status = #active
//* manufacturer = Reference(AtElgaEmed-Example-Organization-Apo-01) "Amadeus Apotheke"
* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"

* ingredient[+].itemCodeableConcept = $cs-atc#A11HA30 "Dexpanthenol"
* ingredient[=].strength.numerator = 5 'g' "g"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[=].isActive = false
* ingredient[=].strength.numerator.value = 95
* ingredient[=].strength.numerator.unit = "g"
* ingredient[=].strength.denominator.value = 100
* ingredient[=].strength.denominator.unit = "g"