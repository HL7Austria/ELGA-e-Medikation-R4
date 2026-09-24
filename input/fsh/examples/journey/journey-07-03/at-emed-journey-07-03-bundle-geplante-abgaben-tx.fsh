Instance: At-Emed-Journey-07-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 07-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit Geplanten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-03-22T16:10:00+00:00"
// Geplante Abgaben
* entry[geplanteAbgaben][+].resource = At-Emed-Journey-07-03-Mr-Geplante-Abgabe-03 
* entry[geplanteAbgaben][=].fullUrl = "urn:uuid:7a1fd5cc-e600-4a30-9f7d-15d653dc88ff"
* entry[geplanteAbgaben][=].request.method = #POST 
* entry[geplanteAbgaben][=].request.url = "MedicationRequest"