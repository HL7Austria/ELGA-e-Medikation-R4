CodeSystem: AtElgaEmedValueSetMedicationDispensePerformerFunctionCS
Id: at-elga-emed-codesystem-medicationdispense-performer-function-cs
Title: "AT ELGA e-Medikation MedicationDispense Performer Function CodeSystem"
Description: "Codesystem für zulässige Ausprägungen der MedicationDispense Performer Function."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
* #dispenseGDA "Abgebender GDA"
* #referenceGDA "Planeintrag verknüpfender GDA"

ValueSet: AtElgaEmedValueSetMedicationDispensePerformerFunctionVS
Id: at-elga-emed-valueset-medicationdispense-performer-function-vs
Title: "AT ELGA e-Medikation MedicationDispense Performer Function ValueSet"
Description: "ValueSet für zulässige Ausprägungen der MedicationDispense Performer Function."
* ^experimental = true
* include codes from system AtElgaEmedValueSetMedicationDispensePerformerFunctionCS

