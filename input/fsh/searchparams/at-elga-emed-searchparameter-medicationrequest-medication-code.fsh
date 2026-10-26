Instance: at-elga-emed-searchparameter-list-mr-medication-code
InstanceOf: SearchParameter
Title: "AT ELGA e-Medikation SearchParameter List Medication Code"
Description: "Suchparameter für den Code (PZN) eines Arzneimittels, das in einem MedicationRequest eines Medikationsplans (List) enthalten ist."
Usage: #definition
* name = "Medication Code"
* status = #active
* description = "Suchparameter für den Code (PZN) eines Arzneimittels, das in einem MedicationRequest eines Medikationsplans (List) enthalten ist."
* code = #medicationrequest-medication-code
* base = #List
* type = #token
* expression = "List.entry.item.resolve().ofType(MedicationRequest).medication.resolve().ofType(Medication).code.ofType(CodeableConcept)"