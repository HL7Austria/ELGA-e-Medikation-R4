Instance: At-Emed-Journey-06-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 06-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-19T12:10:00+00:00"
// Liste 
* entry[Medikationsplan][+].resource = At-Emed-Journey-List-Medikationsplan-v4-tx
* entry[Medikationsplan][=].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Planeintrag 1 aktivieren + ändern
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v3
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"  // vom server gelieferte id verwenden
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"

//Planeintrag 2 bleibt unverändert

//Planeintrag 3 neu (Wirkstoff)
* entry[Medikationsplaneintrag][+].resource = Planeintrag-03-Wirkstoff-Metamizol-vPOST
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:6852930e-6883-4301-b5c1-c142b746af8f"   // temporäre uuid vom client
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

