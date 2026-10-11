Instance: At-Emed-Journey-05-01-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 05-01: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan mit 1 geänderten und 1 unveränderten Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-14T13:10:00+00:00"
// Liste 
* entry[Medikationsplan][+].resource = At-Emed-Journey-List-Medikationsplan-v3-tx
* entry[Medikationsplan][=].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Medikationsplaneintrag 1: Ramipril wird pausiert
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v2
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"  // zu ersetzen mit vom Server vergebenen id (response-bundle: journey 01-02)
* entry[Medikationsplaneintrag][=].request.method = #PUT
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"

// Planeintrag 2 bleibt unverändert


