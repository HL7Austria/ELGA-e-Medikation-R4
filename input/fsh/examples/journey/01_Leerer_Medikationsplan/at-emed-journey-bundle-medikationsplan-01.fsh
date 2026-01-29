Instance: AtEmedJourneyBundleMedikationsplan01 
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 01: Collection Bundle"
Description: "**Beschreibung:** Beispiel eines Collection Bundles, das einen leeren Mediaktionsplan (List) beinhaltet."
Usage: #example

* identifier.system = "http://system-to-be-defined.com"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"

* type = #collection

* timestamp = "2026-01-28T08:00:00+00:00"

* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplan01