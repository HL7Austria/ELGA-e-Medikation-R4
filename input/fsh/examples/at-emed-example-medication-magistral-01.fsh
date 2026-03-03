Instance: At-Emed-Example-Medication-Magistral-01
InstanceOf: AtEmedMedication
Title: "Beispiel Journey 02: Magistrale Zubereitung"
Description: "Beispiel einer magistralen Zubereitung (Medication) - Salbe."
Usage: #example


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