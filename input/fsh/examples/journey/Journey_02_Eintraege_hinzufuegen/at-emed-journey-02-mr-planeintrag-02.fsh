Instance: At-Emed-Journey-02-Mr-Planeintrag-02
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Journey 02: Medikationsplaneintrag 2"
Description: "Bildet einen Medikationsplaneintrag mit einer Referenz auf eine magistrale Zubereitung und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[medication] = contained-medication-journey-02-magistral

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 täglich auftragen"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4713_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
//* status = $cs-medication-request-status#active
* status = #active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 

* reportedReference = Reference(At-Emed-Journey-01-Practitioner-02)

// Referenz auf Inline Medication Ressource
* medicationReference.reference = "#contained-medication-journey-02-magistral"

* subject = Reference(At-Emed-Journey-01-Patient-01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(At-Emed-Journey-01-Practitioner-01)
 
* dosageInstruction.patientInstruction = "Abends sehr dünn auf die betroffene Stelle auftragen."
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

// Contained Medication *********************************************************************
Instance: contained-medication-journey-02-magistral
InstanceOf: AtEmedMedication
Title: "Beispiel Journey 02: Magistrale Anwendung (Salbe)"
Usage: #inline

* text.status = #additional
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n<p>Freitext-Informationen zur magistralen Anwendung.</p>\n</div>"

//* status = #active
//* manufacturer = Reference(AtEmed-Example-Organization-Apo-01) "Amadeus Apotheke"
* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"
// CodeableConcept
// * ingredient[+].itemReference = Reference(At-Emed-Journey-Substance-Hydrocortison) "Hydrocortison"
* ingredient[+].itemCodeableConcept = $cs-atc#A01AC03 "Hydrocortison"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
// * ingredient[+].itemReference = Reference(At-Emed-Journey-Substance-Clotrimazol) "Clotrimazol"
* ingredient[+].itemCodeableConcept = $cs-atc#A01AB18 "Clotrimazol"
* ingredient[=].strength.numerator = 1 '%' "%"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[=].isActive = false
* ingredient[=].strength.numerator.value = 98
* ingredient[=].strength.numerator.unit = "g"
* ingredient[=].strength.denominator.value = 100
* ingredient[=].strength.denominator.unit = "g"   

// * batch.lotNumber = "MAG-2026-001"
// * batch.expirationDate = "2027-01-01"

