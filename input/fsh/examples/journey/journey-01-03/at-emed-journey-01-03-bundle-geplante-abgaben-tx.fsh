Instance: At-Emed-Journey-01-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 01-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit Geplanten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-27T10:20:00+00:00"
// Geplante Abgaben
* entry[geplanteAbgaben][+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01
* entry[geplanteAbgaben][=].fullUrl = "urn:uuid:e68fbdbe-a04e-408b-a98f-865af70b1741"
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"

* entry[geplanteAbgaben][+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02
* entry[geplanteAbgaben][=].fullUrl = "urn:uuid:bc10cdbb-2fa8-4176-ac50-1f2b82275010"
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"
