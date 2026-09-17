Instance: At-Emed-Journey-01-01-Bundle-Medikationsplan
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 01-01: Medikationsplan-Bundle"
Description: "Beispiel eines Medikationsplan-Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example

* type = #searchset
* timestamp = "2026-02-27T08:00:00+00:00" 
* entry[Medikationsplan].resource = At-Emed-Journey-01-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/At-Emed-Journey-01-01-List-Medikationsplan"
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/Patient/At-Emed-Example-Patient-01"
* entry[Authors].resource = At-Emed-Example-Device-01
* entry[Authors].fullUrl = "https://example.elga.com/Device/At-Emed-Example-Device-01"