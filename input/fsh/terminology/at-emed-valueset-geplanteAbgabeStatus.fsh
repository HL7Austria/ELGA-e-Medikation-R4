ValueSet: GeplanteAbgabeStatusVS
Title: "ELGA e-Med Geplante Abgabe Status ValueSet"
Description: "ValueSet für zulässige Ausprägungen eines Status einer geplanten Abgabe (MedicationRequest)."

* ^experimental = true
//* include codes from system $cs-medication-request-status
                                                            // CDA Verordnung:
* $cs-medication-request-status#active              // offen
* $cs-medication-request-status#completed           // eingelöst
* $cs-medication-request-status#entered-in-error    // storniert
* $cs-medication-request-status#stopped             // nicht dispensiert

