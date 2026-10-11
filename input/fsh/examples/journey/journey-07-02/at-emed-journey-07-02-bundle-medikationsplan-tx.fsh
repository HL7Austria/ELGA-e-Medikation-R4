
Alias: $Planeintrag1 = MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52
Alias: $Planeintrag2 = MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391
Alias: $Planeintrag3 = MedicationRequest/7128c60c-126d-42b2-b575-dc26a2324b8b

RuleSet: ResourceURL(path, resourceURL)
* {path} = {resourceURL}



Instance: At-Emed-Journey-07-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 07-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Medikationsplan mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-03-22T16:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-List-Medikationsplan-v5-tx
* entry[Medikationsplan].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

// Planeintrag 1 unverändert

// Planeintrag 2 abgelaufen 
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v2
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"
* entry[Medikationsplaneintrag][=].request.method = #PUT
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"

// Planeintrag 3 geändert 
* entry[Medikationsplaneintrag][+].resource = Planeintrag-03-Wirkstoff-Metamizol-v2
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/7128c60c-126d-42b2-b575-dc26a2324b8b"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
//* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/7128c60c-126d-42b2-b575-dc26a2324b8b"
* insert ResourceURL(entry[Medikationsplaneintrag][=].request.url, $Planeintrag1)



