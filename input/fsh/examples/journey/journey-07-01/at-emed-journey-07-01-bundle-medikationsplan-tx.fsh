Instance: At-Emed-Journey-07-01-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 07-01: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit einem geänderten, einem unveränderten und einem neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-19T12:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-07-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/At-Emed-Journey-07-01-List-Medikationsplan"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Journey-07-01-List-Medikationsplan"

// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-06-02-Mr-Planeintrag-01
//* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:0219ec70-d19a-48ff-94d3-5184b0eca4ac"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-01-02-Mr-Planeintrag-02
//* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-07-01-Mr-Planeintrag-03
//* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:6852930e-6883-4301-b5c1-c142b746af8f"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"


