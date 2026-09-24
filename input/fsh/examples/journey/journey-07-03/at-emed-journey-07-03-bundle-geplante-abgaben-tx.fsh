Instance: At-Emed-Journey-07-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 07-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit Geplanten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-27T10:20:00+00:00"
// Geplante Abgaben
* entry[geplanteAbgaben][+].resource = At-Emed-Journey-07-03-Mr-Geplante-Abgabe-01
* entry[geplanteAbgaben][=].fullUrl = "urn:uuid:e68fbdbe-a04e-408b-a98f-865af70b1741"
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"
