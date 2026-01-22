Instance: AtEmedExamplePlaneintrag01
InstanceOf: AtEmedMedicationRequestPlaneintrag
Title: "Example Planeintrag 1"
Description: "Example Planeintrag 1"
Usage: #example

* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "100-1/3"
* status = #active
* intent = #option
* medicationCodeableConcept = $cs-sct#376255008 "Thalidomide 50 mg oral capsule"
* subject = Reference(Patient/AtEmedExamplePatient01)
* authoredOn = "2024-10-03"
* requester = Reference(PractitionerRole/doctor1)
* reasonCode = $cs-sct#109989006 "Multiple myeloma"
* groupIdentifier.value = "100"
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


// * status = #active
// * intent = #order
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
