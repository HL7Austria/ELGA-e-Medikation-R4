Instance: At-Emed-Journey-04-Bundle-Durchgefuehrte-Abgaben-Tx
InstanceOf: AtElgaEmedBundleDurchgefuehrteAbgabenTx 
Title: "Beispiel Journey 04: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles mit Durchgeführten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-02-28T11:00:00+00:00" 
// Durchgefuehrte Abgaben
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-04-Md-Durchgefuehrte-Abgabe-01
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-04-Md-Durchgefuehrte-Abgabe-02
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
