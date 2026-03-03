Instance: At-Emed-Journey-05-a-Bundle-Medikationsplan-Tx
InstanceOf: AtEmedBundleTxMedikationsplan   
Title: "Beispiel Journey 05-a: Transaction Bundle zur Änderung der Reihenfolge der Medikationsplaneinträge."
Description: "Beispiel eines Transaction Bundles, zur Änderung der Reihenfolge der Medikationsplaneinträge."
Usage: #example

* type = #transaction
* timestamp = "2026-03-05T12:20:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-05-a-List-Reihenfolge
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Journey-05-a-List-Reihenfolge"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-01"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-02"