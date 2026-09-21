Instance: At-Emed-Journey-02-01-Bundle-Durchgefuehrte-Abgaben-Tx
InstanceOf: AtElgaEmedBundleDurchgefuehrteAbgabenTx 
Title: "Beispiel Journey 02-01: Durchgefuehrte-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit Durchgeführten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-28T11:00:00+00:00" 
// Durchgefuehrte Abgaben
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-01
* entry[durchgefuehrteAbgaben][=].fullUrl = "urn:uuid:e4aa346f-5b06-4a0b-8d36-9c12a7650a2b"
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
* entry[durchgefuehrteAbgaben][=].fullUrl = "urn:uuid:53223bdb-3963-4dc3-ace1-92a9c880e5ba"
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-02
* entry[durchgefuehrteAbgaben][=].fullUrl = "urn:uuid:b8a20a46-a20a-4987-ad15-33475defb536"
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
