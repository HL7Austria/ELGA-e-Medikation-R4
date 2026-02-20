Instance: AtEmedJourneyBundleMedikationsplan01 
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 01: Collection Bundle"
Description: "**Beschreibung:** Beispiel eines Collection Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example

* type = #collection
* timestamp = "2026-01-28T08:00:00+00:00"
* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplan01
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a55"