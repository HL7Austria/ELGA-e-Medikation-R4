Instance: At-Emed-Journey-02-01-Bundle-Durchgefuehrte-Abgaben-Tx
InstanceOf: AtElgaEmedBundleDurchgefuehrteAbgabenTx 
Title: "Beispiel Journey 02-01: Durchgefuehrte-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit 2 Durchgeführten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-28T11:00:00+00:00" 
// Durchgefuehrte Abgaben
* entry[+].resource = At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-01
* entry[=].fullUrl = "urn:uuid:e4aa346f-5b06-4a0b-8d36-9c12a7650a2b"
* entry[=].request.method = #POST 
* entry[=].request.url = "MedicationDispense"
* entry[+].resource = At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-02
* entry[=].fullUrl = "urn:uuid:b8a20a46-a20a-4987-ad15-33475defb536"
* entry[=].request.method = #POST 
* entry[=].request.url = "MedicationDispense"
