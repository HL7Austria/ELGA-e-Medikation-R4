ValueSet: GeplanteAbgabeStatusVS
Id: at-elga-emed-valueset-geplanteabgabestatus-vs
Title: "At ELGA e-Medikation Geplante Abgabe Status ValueSet"
Description: "ValueSet für zulässige Ausprägungen eines Status einer Geplanten Abgabe (MedicationRequest)."
* ^status = #active
* ^experimental = true
//* include codes from system $cs-medication-request-status

* $cs-medication-request-status#active              // offen
* $cs-medication-request-status#completed           // eingelöst
* $cs-medication-request-status#entered-in-error    // storniert
* $cs-medication-request-status#stopped             // abgelaufen
* $cs-medication-request-status#cancelled           // nicht abgegeben

