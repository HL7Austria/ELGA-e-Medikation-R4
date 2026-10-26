Instance: At-Emed-Journey-01-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 01-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit 2 Geplanten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-27T10:20:00+00:00"
// Geplante Abgaben
* entry[+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01
* entry[=].fullUrl = "urn:uuid:e68fbdbe-a04e-408b-a98f-865af70b1741"
* entry[=].request.method = #POST 
* entry[=].request.url = "MedicationRequest"

* entry[+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02
* entry[=].fullUrl = "urn:uuid:bc10cdbb-2fa8-4176-ac50-1f2b82275010"
* entry[=].request.method = #POST 
* entry[=].request.url = "MedicationRequest"
