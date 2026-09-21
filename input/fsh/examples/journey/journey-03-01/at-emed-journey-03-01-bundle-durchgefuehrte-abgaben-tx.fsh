Instance: At-Emed-Journey-03-01-Bundle-Durchgefuehrte-Abgaben-Tx
InstanceOf: AtElgaEmedBundleDurchgefuehrteAbgabenTx 
Title: "Beispiel Journey 03-01: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles mit Durchgeführten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-03-01T15:15:00+00:00" 
// Durchgefuehrte Abgaben
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-03-01-Md-Durchgefuehrte-Abgabe-02
* entry[durchgefuehrteAbgaben][=].fullUrl = "urn:uuid:3126a1c8-d139-4763-9bda-5ac61a0cd378"
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
