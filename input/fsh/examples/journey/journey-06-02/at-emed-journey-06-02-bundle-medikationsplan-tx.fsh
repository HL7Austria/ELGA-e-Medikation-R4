Instance: At-Emed-Journey-06-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 06-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit einem geänderten, einem unveränderten und einem neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-19T12:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-06-02-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Planeintrag 1 aktivieren + ändern
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-06-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/5e947f71-6881-46cc-9b06-81a1743aa674"  // vom server gelieferte id verwenden
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/5e947f71-6881-46cc-9b06-81a1743aa674"

//Planeintrag 2 bleibt unverändert

//Planeintrag 3 neu (Wirkstoff)
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-06-02-Mr-Planeintrag-03
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/urn:uuid:6852930e-6883-4301-b5c1-c142b746af8f"   // termporere uuid vom client
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/6852930e-6883-4301-b5c1-c142b746af8f"

