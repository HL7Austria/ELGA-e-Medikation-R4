Instance: At-Emed-Example-Durchgefuehrte-Abgabe-01
InstanceOf: AtEmedMDDurchgefuehrteAbgabe
Title: "Beispiel Durchgeführte Abgabe 1"
Description: "Beispiel Durchgeführte Abgabe 1"
Usage: #example
// * status = #completed
// * medicationReference = Reference(Medication/AtApsExampleMedication01) "Ramipril 5mg Kapseln"
// * subject = Reference(Patient/HL7ATCorePatientExample01) "Max Mustermann"
// * performer.actor = Reference(Organization/AtApsExampleOrganization01) "Amadeus Spital"
// * authorizingPrescription = Reference(MedicationRequest/AtApsExampleMedicationRequest01) "Verordnung Ramipril"
// * whenHandedOver = "2024-10-15T09:30:00+01:00"
// * quantity.value = 30
// * quantity.unit = "Kapseln"
// * daysSupply = 30 'd' "Tage"
// * dosageInstruction.text = "1 Kapsel täglich morgens"
// * dosageInstruction.timing.repeat.frequency = 1
// * dosageInstruction.timing.repeat.period = 1
// * dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.route = $cs-sct#26643006 "Oral use"


// https://build.fhir.org/ig/hl7-eu/mpd/MedicationDispense-400D-dispense-1.json.html
//* meta.profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationDispense-eu-mpd"
* identifier.value = "WYE82A2G8EEW-4711-001"
* status = #completed
* medicationReference = Reference(Medication/01C-Cefuroxime1500Branded) "Cefuroxime MIP 1500 mg, powder for solution for injection/infusion. N10."
* subject = Reference(At-Emed-Journey-01-Patient-01)
* performer.actor = Reference(PractitionerRole/pharmacist1)
* authorizingPrescription = Reference(MedicationRequest/400C-prescription-cefuroxime-singleline)
* quantity = 1 '1'
* daysSupply = 3 'd' "day(s)"
* whenHandedOver = "2024-12-06T19:54:00Z"