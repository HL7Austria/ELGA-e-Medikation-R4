Instance: At-Emed-Journey-05-01-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 05-01: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan mit einem geänderten und einem unveränderten Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-14T13:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-05-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Medikationsplaneintrag 1: Ramipril wird pausiert
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-05-01-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/urn:uuid:5e947f71-6881-46cc-9b06-81a1743aa674"  // zu ersetzen mit vom Server vergebenen id (response-bundle: journey 01-02)
* entry[Medikationsplaneintrag][=].request.method = #PUT
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/5e947f71-6881-46cc-9b06-81a1743aa674"

// Planeintrag 2 bleibt unverändert


