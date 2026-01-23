Instance: AtEmedExampleGeplanteAbgabe01
InstanceOf: AtEmedMedicationRequestGeplanteAbgabe
Title: "Beispiel Geplante Abgabe 1"
Description: "Beispiel Geplante Abgabe 1"
Usage: #example

//* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
//* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-medicationrequest-geplanteAbgabe"
* identifier.value = "WYE82A2G8EEW-4711"
* status = #active
* intent = #order
* category.coding = #2 "Geplante Abgabe"
//* medicationReference = Reference(Medication/AtApsExampleMedication01) "Magistrale Zubereitung"
* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(Patient/AtEmedExamplePatient01)
* authoredOn = "2024-10-03"
* requester = Reference(Practitioner/AtEmedExamplePractitioner01)
* reasonCode = $cs-sct#59621000 "Hypertonie"
* reasonCode.text = "Hypertonie"
* groupIdentifier.value = "WYE82A2G8EE1"
//* courseOfTherapyType = $sct#394577000 "Continuous therapy"
//* courseOfTherapyType = #continuous "Continuous long term therapy"
* note.text = "Freitext Informationen zur geplanten Abgabe."
* dosageInstruction.text = "1 Kapsel täglich morgens"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.route = $cs-sct#26643006 "Oral use"
* dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"
* basedOn = Reference(Medication/AtEmedExampleMedicationRequestPlaneintrag01) "Planeintrag"

