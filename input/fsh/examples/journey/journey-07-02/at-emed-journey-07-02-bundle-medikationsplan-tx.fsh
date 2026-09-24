Instance: At-Emed-Journey-07-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 07-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit einem geänderten, einem unveränderten und einem neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-22T16:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-07-02-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Planeintrag 1 unverändert

// Planeintrag 2 abgelaufen 
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-07-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/urn:uuid:7f1294a2-f592-4547-881c-c15d1debc165"
* entry[Medikationsplaneintrag][=].request.method = #PUT
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/urn:uuid:7f1294a2-f592-4547-881c-c15d1debc165"

// Planeintrag 3 geändert 
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-07-02-Mr-Planeintrag-03
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/urn:uuid:6852930e-6883-4301-b5c1-c142b746af8f"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/urn:uuid:6852930e-6883-4301-b5c1-c142b746af8f"


