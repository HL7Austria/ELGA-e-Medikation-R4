ValueSet: DurchgefuehrteAbgabeStatusVS
Title: "ELGA e-Med Durchgeführte Abgabe Status Value Set"
Description: "ValueSet für zulässige Ausprägungen eines Status einer durchgeführten Abgabe (MedicationDispense)."
* ^experimental = true
                                                                // CDA Abgabe:
* include $cs-medication-dispense-status#completed              // abgegeben
* include $cs-medication-dispense-status#entered-in-error       // storniert
* include $cs-medication-dispense-status#stopped                // abgesetzt
//* include $cs-medication-dispense-status#in-progress

 