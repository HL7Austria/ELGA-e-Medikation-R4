Instance: AtEmedExamplePlaneintrag01
InstanceOf: AtEmedMedicationRequestPlaneintrag
Title: "Beispiel Medikationsplaneintrag 1"
Description: "Beispiel Medikationsplaneintrag 1"
Usage: #example

//* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "477"
* status = #active
* intent = #order
* category.coding = #1 "Medikationsplaneintrag"
//* medicationReference = Reference(Medication/AtApsExampleMedication01) "Magistrale Zubereitung"
* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(Patient/AtEmedExamplePatient01)
* authoredOn = "2024-10-03"
* requester = Reference(Practitioner/AtEmedExamplePractitioner01)
* reasonCode = $cs-sct#59621000 "Hypertonie"
* reasonCode.text = "Hypertonie"
//* groupIdentifier.value = "100"
* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction.text = "1 Kapsel täglich morgens"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.route = $cs-sct#26643006 "Oral use"
* dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"

