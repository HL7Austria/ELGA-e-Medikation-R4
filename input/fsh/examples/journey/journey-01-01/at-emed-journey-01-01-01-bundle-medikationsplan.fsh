Instance: At-Emed-Journey-01-01-01-Bundle-Medikationsplan
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 01-01: Medikationsplan-Bundle"
Description: "Beispiel eines Medikationsplan-Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example
* total = 3
* type = #searchset
//* timestamp = "2026-02-27T08:00:00+00:00" 
* entry[Medikationsplan].resource = At-Emed-Journey-List-Medikationsplan-v1
* entry[Medikationsplan].search.mode = #match
* entry[Medikationsplan].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/base/Patient/At-Emed-Example-Patient-01"
* entry[Patient].search.mode = #include
* entry[Authors].resource = At-Emed-Example-Device-01
* entry[Authors].fullUrl = "https://example.elga.com/base/Device/At-Emed-Example-Device-01"
* entry[Authors].search.mode = #include
* link.url = "https://example.elga.com/base/List/$plan-read"
* link.relation = #self

