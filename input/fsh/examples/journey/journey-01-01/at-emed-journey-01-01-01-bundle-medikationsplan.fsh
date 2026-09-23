Instance: At-Emed-Journey-01-01-01-Bundle-Medikationsplan
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 01-01: Medikationsplan-Bundle"
Description: "Beispiel eines Medikationsplan-Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example
* total = 3
* type = #searchset
* timestamp = "2026-02-27T08:00:00+00:00" 
* entry[Medikationsplan].resource = At-Emed-Journey-01-01-List-Medikationsplan
* entry[Medikationsplan].search.mode = #match
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/Patient/At-Emed-Example-Patient-01"
* entry[Patient].search.mode = #include
* entry[Authors].resource = At-Emed-Example-Device-01
* entry[Authors].fullUrl = "https://example.elga.com/Device/At-Emed-Example-Device-01"
* entry[Authors].search.mode = #include
* link.url = "https://example.elga.com/base/List/$plan-read"
* link.relation = #self

Instance: At-Emed-Journey-01-01-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Usage: #inline
Title: "Beispiel Journey 01-01: Leerer Medikationsplan"
Description: "Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
* id = "4cb4dceb-173f-461a-a267-683ec33e4be1"
* meta.versionId = "f43395bd-d5e7-4d61-872e-46c214d090ab"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  
* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* date = "2026-02-27T08:00:00+00:00" 
// Verantworlich für die intitiale Erstellung ist die Flachanwendung
* source = Reference(At-Emed-Example-Device-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
