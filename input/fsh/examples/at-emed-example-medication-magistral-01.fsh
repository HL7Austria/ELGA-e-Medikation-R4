Instance: At-Emed-Example-Medication-Magistral-01
InstanceOf: AtElgaEmedMedicationMagistraleZubereitung
Title: "Beispiel Journey 02: Magistrale Zubereitung"
Description: "Beispiel einer magistralen Zubereitung (Dexpanthenol-Salbe)."
Usage: #example

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