ValueSet: GeplanteAbgabeStatusVS
Title: "ELGA e-Med Geplante Abgabe Status ValueSet"
Description: "ValueSet für zulässige Ausprägungen eines Status einer geplanten Abgabe (MedicationRequest)."

* ^experimental = true
//* include codes from system $cs-medication-request-status
                                                            // CDA Verordnung:
* include $cs-medication-request-status#active              // offen
* include $cs-medication-request-status#completed           // eingelöst
* include $cs-medication-request-status#entered-in-error    // storniert
* include $cs-medication-request-status#stopped             // nicht dispensiert
// nicht:
//* include $cs-medication-request-status#on-hold
//* include $cs-medication-request-status#stopped
//* include $cs-medication-request-status#cancelled
