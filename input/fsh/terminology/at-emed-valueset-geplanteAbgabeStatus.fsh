ValueSet: GeplanteAbgabeStatusVS
Title: "ELGA e-Med Geplante Abgabe Status ValueSet"
Description: "ValueSet für zulässige Ausprägungen eines Status einer geplanten Abgabe (MedicationRequest)."

* ^experimental = true
//* include codes from system $cs-medication-request-status

* $cs-medication-request-status#active              // offen
* $cs-medication-request-status#completed           // eingelöst
* $cs-medication-request-status#entered-in-error    // verworfen
* $cs-medication-request-status#stopped             // abgelaufen
* $cs-medication-request-status#cancelled           // nicht abgegeben

