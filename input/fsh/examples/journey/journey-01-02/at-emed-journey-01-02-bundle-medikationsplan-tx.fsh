Instance: At-Emed-Journey-01-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 01-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan (List) mit 2 neuen Planeinträgen (MedicationRequests) beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-02-27T08:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-01-02-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/4cb4dceb-173f-461a-a267-683ec33e4be1"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-01-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:5e947f71-6881-46cc-9b06-81a1743aa674"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-01-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:7f1294a2-f592-4547-881c-c15d1debc165"
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"


