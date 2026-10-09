Instance: At-Emed-Journey-01-02-Bundle-plan-read-response
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 01-02: Medikationsplan-Bundle"
Description: "Beispiel eines Medikationsplan-Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) referenziert."
Usage: #example

* type = #searchset
* timestamp = "2026-02-27T08:10:00+00:00"

* entry[Medikationsplan].resource = At-Emed-Journey-List-Medikationsplan-v2
* entry[Medikationsplan].search.mode = #match
* entry[Medikationsplan].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v1
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"
* entry[Medikationsplaneintrag][=].search.mode = #include
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/base/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"
* entry[Medikationsplaneintrag][=].search.mode = #include
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/base/Patient/At-Emed-Example-Patient-01"
* entry[Patient].search.mode = #include
* entry[Authors].resource = At-Emed-Example-Device-01
* entry[Authors].fullUrl = "https://example.elga.com/base/Device/At-Emed-Example-Device-01"
* entry[Authors].search.mode = #include
* link.url = "https://example.elga.com/base/List/$plan-read"
* link.relation = #self




// = zu response_bundle umbauen (mit patient usw)