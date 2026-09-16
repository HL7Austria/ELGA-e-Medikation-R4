Instance: At-Emed-Journey-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 03: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles mit Geplanten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-27T10:20:00+00:00"
// Geplante Abgaben
* entry[geplanteAbgaben][+].resource = At-Emed-Journey-03-Mr-Geplante-Abgabe-01
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"
* entry[geplanteAbgaben][+].resource = At-Emed-Journey-03-Mr-Geplante-Abgabe-02
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"
