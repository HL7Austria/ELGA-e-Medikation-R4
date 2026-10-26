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
* extension[Rezeptur].valueMarkdown = "TODO: Beispielrezeptur"
* code.text = "Dexpanthenol-5-%-Salbe"
* ingredient[activeIngredient].itemCodeableConcept = $cs-atc#A11HA30 "Dexpanthenol"
* ingredient[activeIngredient].strength.numerator = 5 'g' "g"
* ingredient[activeIngredient].strength.denominator = 100 'g' "g"
* ingredient[activeIngredient].isActive = true
* ingredient[inactiveIngredient].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[inactiveIngredient].isActive = false
* ingredient[inactiveIngredient].strength.numerator.value = 95
* ingredient[inactiveIngredient].strength.numerator.unit = "g"
* ingredient[inactiveIngredient].strength.denominator.value = 100
* ingredient[inactiveIngredient].strength.denominator.unit = "g"