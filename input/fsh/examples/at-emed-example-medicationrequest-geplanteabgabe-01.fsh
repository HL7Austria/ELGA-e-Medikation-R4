Alias: $sct = http://snomed.info/sct

Instance: AtEmedExampleMedicationRequestGeplanteAbgabe01
InstanceOf: AtEmedMedicationRequestGeplanteAbgabe
Title: "AtEmedMedicationRequestGeplanteAbgabe-Beispiel"
Description: "AtEmedMedicationRequestGeplanteAbgabe-Beispiel"
Usage: #example

//* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-medicationrequest-geplanteAbgabe"
* identifier.value = "WYE82A2G8EEW-4711"
* status = #active
* intent = #order
* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(Patient/AtEmedExamplePatient01)
* authoredOn = "2024-10-03"
* requester = Reference(Practitioner/AtEmedExamplePractitioner01)
* reasonCode = $sct#109989006 "Multiple myeloma"
* groupIdentifier.value = "WYE82A2G8EE1"
* dosageInstruction.timing.repeat.boundsDuration = 42 'd' "day"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #EVE.late
* dosageInstruction.doseAndRate.doseQuantity = 4 http://snomed.info/sct#732936001 "Tablet"
* dispenseRequest.validityPeriod.start = "2024-10-03"
* dispenseRequest.validityPeriod.end = "2024-12-03"
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity = 168 http://snomed.info/sct#732936001 "Tablet"
* basedOn = Reference(Medication/AtEmedExampleMedicationRequestPlaneintrag01) "Planeintrag"




// * medicationReference = Reference(Medication/AtApsExampleMedication01) "Ramipril 5mg Kapseln"
// * subject = Reference(Patient/HL7ATCorePatientExample01) "Max Mustermann"
// * authoredOn = "2024-10-14T10:00:00+01:00"
// * requester = Reference(Practitioner/HL7ATCorePractitionerExample01) "Dr. Melanie Musterärztin"
// * reasonCode = $cs-sct#59621000 "Hypertonie"
// * reasonCode.text = "Hypertonie"
// * dosageInstruction.text = "1 Kapsel täglich morgens"
// * dosageInstruction.timing.repeat.frequency = 1
// * dosageInstruction.timing.repeat.period = 1
// * dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.route = $cs-sct#26643006 "Oral use"
// * dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dispenseRequest.quantity.value = 30
// * dispenseRequest.quantity.unit = "Kapseln"
// * dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"