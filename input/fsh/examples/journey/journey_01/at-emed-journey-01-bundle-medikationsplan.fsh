Instance: At-Emed-Journey-01-Bundle-Medikationsplan
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 01: Medikationsplan-Searchset-Bundle"
Description: "Beispiel eines Medikationsplan-Searchset-Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example

* type = #searchset
* timestamp = "2026-02-27T08:00:00+00:00" 
* entry[Medikationsplan].resource = At-Emed-Journey-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/At-Emed-Journey-01-List-Medikationsplan"
// * entry[Patient].resource = At-Emed-Example-Patient-01
// * entry[Patient].fullUrl = "urn:uuid:9a10ac0d-6063-4272-9ed7-0539582e1d3c"  // TODO
// * entry[Source].resource = At-Emed-Example-Device-01
// * entry[Source].fullUrl = "urn:uuid:5fb18c43-c408-4b18-aecf-04f019af0a16"  // TODO 