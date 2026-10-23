Instance: At-Emed-Journey-05-01-Bundle-plan-read-response
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 05-01: Medikationsplan-Bundle $plan-read Response"
Description: "Beispiel eines Medikationsplan-Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) referenziert."
Usage: #example

* type = #searchset
* timestamp = "2026-03-14T13:12:00+00:00"
* link.url = "https://example.elga.com/base/List/$plan-read"
* link.relation = #self
* total = 5
* entry[Medikationsplan].resource = At-Emed-Journey-List-Medikationsplan-v3-plan-read-response
* entry[Medikationsplan].search.mode = #match
* entry[Medikationsplan].fullUrl = $srPlan
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v2
* entry[Medikationsplaneintrag][=].fullUrl = $srPlaneintrag01
* entry[Medikationsplaneintrag][=].search.mode = #include
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
* entry[Medikationsplaneintrag][=].fullUrl = $srPlaneintrag02
* entry[Medikationsplaneintrag][=].search.mode = #include
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/base/Patient/At-Emed-Example-Patient-01"
* entry[Patient].search.mode = #include
* entry[Authors].resource = At-Emed-Example-Practitioner-01
* entry[Authors].fullUrl = "https://example.elga.com/base/Practitioner/At-Emed-Example-Practitioner-01"
* entry[Authors].search.mode = #include
