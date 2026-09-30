Instance: at-elga-emed-searchparameter-list-mr-medication-code
InstanceOf: SearchParameter
Usage: #definition
* name = "Medication Code"
* status = #active
* description = "The code of the medication that is part of this MedicationRequest"
* code = #medicationrequest-medication-code
* base = #List
* type = #token
* expression = "List.entry.item.resolve().ofType(MedicationRequest).medication.resolve().ofType(Medication).ingredient.item.ofType(CodeableConcept)"