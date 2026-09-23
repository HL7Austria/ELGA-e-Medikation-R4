Instance: At-Emed-Journey-05-01-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 05-01: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan mit einem geänderten und einem unveränderten Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-14T13:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-05-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/At-Emed-Journey-05-01-List-Medikationsplan"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Journey-05-01-List-Medikationsplan"

// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-05-01-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:5b9831e4-60a8-4152-8d37-f8c904bb3d73"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-01-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:32506977-b3ba-4f6f-af14-f8ea6fef243a"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"


