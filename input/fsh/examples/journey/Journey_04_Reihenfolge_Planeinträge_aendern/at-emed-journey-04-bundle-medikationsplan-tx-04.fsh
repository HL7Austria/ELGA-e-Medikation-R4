Instance: At-Emed-Journey-04-Bundle-Medikationsplan-Tx
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 04: Transaction Bundle zur Änderung der Reihenfolge der Medikationsplaneinträge."
Description: "Beispiel eines Transaction Bundles, zur Änderung der Reihenfolge der Medikationsplaneinträge (referenziert List-Ressource mit MedicationRequests."
Usage: #example

* type = #transaction
* timestamp = "2026-02-05T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-04-List-Medikationsplan-Reihenfolge
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Journey-04-List-Medikationsplan-Reihenfolge"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-01"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-02"