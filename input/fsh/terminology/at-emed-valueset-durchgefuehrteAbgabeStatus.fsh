ValueSet: DurchgefuehrteAbgabeStatusVS
Title: "ELGA e-Med Durchgeführte Abgabe Status Value Set"
Description: "ValueSet für zulässige Ausprägungen eines Status einer durchgeführten Abgabe (MedicationDispense)."
* ^experimental = true
                                                                // CDA Abgabe:
* $cs-medication-dispense-status#completed              // abgegeben
* $cs-medication-dispense-status#entered-in-error       // storniert
* $cs-medication-dispense-status#stopped                // abgesetzt
//* $cs-medication-dispense-status#in-progress

 