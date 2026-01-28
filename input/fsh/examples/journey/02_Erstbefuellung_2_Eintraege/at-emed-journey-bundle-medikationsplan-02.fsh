Instance: AtEmedJourneyBundleMedikationsplan02
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Example Bundle Collection Medikationsplan 02"
Description: "Example Bundle vom Typ Collection Medikationsplan 02"
Usage: #example

// * identifier.system = "http://system-to-be-defined.com"
// * identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* identifier = "123"

* type = #collection

* timestamp = "2026-01-28T08:00:00+00:00"

// Liste 
* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplan02 

// Medikationsplaneinträge
* entry[Medikationsplaneintrag].resource = AtEmedJourneyMrPlaneintrag0201
* entry[Medikationsplaneintrag].resource = AtEmedJourneyMrPlaneintrag0202