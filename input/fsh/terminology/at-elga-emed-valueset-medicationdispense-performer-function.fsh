CodeSystem: AtElgaEmedValueSetMedicationDispensePerformerFunctionCS
Title: "ELGA e-Med MedicationDispense Performer Function CodeSystem"
Description: "Codesystem für zulässige Ausprägungen der MedicationDispense Performer Function."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
* #dispenseGDA "Abgebender GDA"
* #referenceGDA "Planeintrag verknüpfender GDA"

ValueSet: AtElgaEmedValueSetMedicationDispensePerformerFunctionVS
Title: "ELGA e-Med MedicationDispense Performer Function ValueSet"
Description: "ValueSet für zulässige Ausprägungen der MedicationDispense Performer Function."
* ^experimental = true
* include codes from system AtElgaEmedValueSetMedicationDispensePerformerFunctionCS

