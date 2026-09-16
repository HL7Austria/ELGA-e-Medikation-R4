Extension: AtElgaEmedExtensionGroupIdentifier
Id:  at-elga-emed-extension-group-identifier
Title: "AT ELGA e-Medikation Extension Group Identifier"
Description: "AT ELGA e-Medikation Extension, die den e-Med GroupIdentifier beinhaltet."
Context: MedicationDispense
* value[x] 1..1
* value[x] only Identifier
* valueIdentifier.system = $sys-eMed-groupIdentifier