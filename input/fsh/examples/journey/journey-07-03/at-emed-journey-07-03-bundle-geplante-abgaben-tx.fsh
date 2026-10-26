Instance: At-Emed-Journey-07-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx  
Title: "Beispiel Journey 07-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit 1 Geplanten Abgabe."
Usage: #example

* type = #transaction
// Geplante Abgaben
* entry[+].resource = At-Emed-Journey-07-03-Mr-Geplante-Abgabe-03 
* entry[=].fullUrl = "urn:uuid:7a1fd5cc-e600-4a30-9f7d-15d653dc88ff"
* entry[=].request.method = #POST 
* entry[=].request.url = "MedicationRequest"