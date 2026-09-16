Instance: At-Emed-Journey-02-Mr-Planeintrag-02
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 2"
Description: "Bildet einen Medikationsplaneintrag mit einer magistralen Zubereitung (Dexpanthenol-Salbe)und zugehörigen Dosierungsanweisungen ab."
Usage: #example

* contained[+] = contained-medication-journey-02-02-magistral
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0 für 3 Wochen" 

* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-journey-02-02-magistral"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T08:10:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

//* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.value = 3
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.unit = "wk"
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 2        // TODO: Angabe für Salbe
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-02-magistral
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Journey 02: Magistrale Zubereitung (Dexpanthenol-Salbe)"
Usage: #inline

// * text.status = #additional
// * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n<p>Freitext-Informationen zur magistralen Anwendung.</p>\n</div>"
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


