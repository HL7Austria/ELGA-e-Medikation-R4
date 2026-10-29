Instance: At-Emed-Journey-07-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 07-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit 1 geänderten, 1 abgelaufenen und 1 neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-22T16:10:00+00:00"
// Liste 
* entry[Medikationsplan][+].resource = At-Emed-Journey-List-Medikationsplan-v5-tx
* entry[Medikationsplan][=].fullUrl = $srPlan
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = $rrPlan

// Planeintrag 1 unverändert

// Planeintrag 2 abgelaufen 
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v2-tx
* entry[Medikationsplaneintrag][=].fullUrl = $srPlaneintrag02
* entry[Medikationsplaneintrag][=].request.method = #PUT
* entry[Medikationsplaneintrag][=].request.url = $rrPlaneintrag02

// Planeintrag 3 geändert 
* entry[Medikationsplaneintrag][+].resource = Planeintrag-03-Wirkstoff-Metamizol-v2-tx
* entry[Medikationsplaneintrag][=].fullUrl = $srPlaneintrag03
* entry[Medikationsplaneintrag][=].request.method = #PUT 
//* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/7128c60c-126d-42b2-b575-dc26a2324b8b"
* entry[Medikationsplaneintrag][=].request.url = $rrPlaneintrag03



