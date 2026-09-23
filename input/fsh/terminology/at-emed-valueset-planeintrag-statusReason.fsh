CodeSystem: AtElgaEmedCodeSystemPlaneintragStatusReasonCS
Title: "ELGA e-Med MedicationRequest Planeintrag StatusReason CodeSystem"
Description: "Codesystem für zulässige Ausprägungen des StatusReason eines Medikationsplaneintrags (MedicationRequest)."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
* #other "Anderer Grund: Freitexteingabe"
* #abgl "Planeintrag Abgelaufen"
* #kwirk "keine Wirkung"
* #ka "keine Aussage"

ValueSet: AtElgaEmedValueSetPlaneintragStatusReasonVS
Title: "ELGA e-Med Medikationsplaneintrag StatusReason Value Set"
Description: "ValueSet für zulässige Ausprägungen des StatusReason eines Medikationsplaneintrags (MedicationRequest)."
* ^experimental = true
* ^status = #active

* $cs-medication-request-status-reason#salg "Allergy" //Allergie
* $cs-medication-request-status-reason#sddi "Drug interacts with another drug" //Wechselwirkung
* $cs-medication-request-status-reason#sdupther "Duplicate therapy"
* $cs-medication-request-status-reason#surg "Patient scheduled for surgery."
* $cs-medication-request-status-reason#sintol "Suspected intolerance" //wurde vom Patient nicht vertragen
* include codes from system AtElgaEmedCodeSystemPlaneintragStatusReasonCS
