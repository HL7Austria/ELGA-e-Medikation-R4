Instance: At-Emed-Journey-06-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 06-02: Medikationsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-19T12:10:00+00:00"
// Liste 
* entry[Medikationsplan][+].resource = At-Emed-Journey-List-Medikationsplan-v4-tx
* entry[Medikationsplan][=].fullUrl = $srPlan
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = $rrPlan

// Planeintrag 1 aktivieren + ändern
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v3-tx
* entry[Medikationsplaneintrag][=].fullUrl = $srPlaneintrag01  // vom server gelieferte id verwenden
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = $rrPlaneintrag01

//Planeintrag 2 bleibt unverändert

//Planeintrag 3 neu (Wirkstoff)
* entry[Medikationsplaneintrag][+].resource = Planeintrag-03-Wirkstoff-Metamizol-vPOST
* entry[Medikationsplaneintrag][=].fullUrl = $POSTuuidPlaneintrag03   // temporäre uuid vom client
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

