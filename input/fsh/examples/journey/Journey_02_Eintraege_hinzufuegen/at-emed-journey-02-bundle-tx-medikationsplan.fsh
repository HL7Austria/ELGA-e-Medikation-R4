Instance: At-Emed-Journey-02-Bundle-Tx-Medikationsplan
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 02: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-02-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Journey-02-List-Medikationsplan"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-01"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-02"


