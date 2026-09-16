Instance: At-Emed-Journey-05-Bundle-Durchgefuehrte-Abgaben-Tx
InstanceOf: AtElgaEmedBundleDurchgefuehrteAbgabenTx 
Title: "Beispiel Journey 05: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles mit Durchgeführten Abgaben."
Usage: #example

* type = #transaction
* timestamp = "2026-03-01T15:15:00+00:00" 
// Durchgefuehrte Abgaben
* entry[durchgefuehrteAbgaben][+].resource = At-Emed-Journey-05-Md-Durchgefuehrte-Abgabe-02
* entry[durchgefuehrteAbgaben][=].request.method = #POST 
* entry[durchgefuehrteAbgaben][=].request.url = "MedicationDispense"
