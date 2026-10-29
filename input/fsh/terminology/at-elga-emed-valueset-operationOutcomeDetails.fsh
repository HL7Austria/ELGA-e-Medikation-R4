CodeSystem: AtElgaEmedOperationOutcomeDetailsCS
Id: at-emed-codesystem-operationoutcome-details
Title: "CodeSystem für AT e-Medikation OperationOutcome Details"
Description: "Dieses Codesystem legt die möglichen Fehlercodes im Rahmen der e-Medikation-Fachanwendung fest."
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
//ASW 11.10.2026 TODO Codes einfügen


ValueSet: AtElgaEmedOperationOutcomeDetailsVS
Id: at-elga-emed-operationoutcome-details
Title: "ValueSet für AT e-Medikation OperationOutcome Details"
Description: "Value-Set mit den für e-Medikation zulässigen detaillierten Fehlercodes."
* ^status = #active
* ^experimental = false

* include codes from system AtElgaEmedOperationOutcomeDetailsCS
