ValueSet: DurchgefuehrteAbgabeStatusVS
Title: "ELGA e-Med Durchgeführte Abgabe Status ValueSet"
Description: "ValueSet für zulässige Ausprägungen eines Status einer Durchgeführten Abgabe (MedicationDispense)."
* ^experimental = true
* ^status = #active
                                                               // CDA Abgabe:
* $cs-medication-dispense-status#completed              // abgegeben
* $cs-medication-dispense-status#entered-in-error       // storniert
* $cs-medication-dispense-status#cancelled                // abgesetzt
//* $cs-medication-dispense-status#in-progress  

 