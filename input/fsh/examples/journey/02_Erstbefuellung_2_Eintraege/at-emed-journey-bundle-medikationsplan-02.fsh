Instance: AtEmedJourneyBundleMedikationsplan02
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 02: Collection Bundle"
Description: "**Beschreibung:** Beispiel eines Collection Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) referenziert."
Usage: #example

* identifier.system = "http://system-to-be-defined.com"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #collection
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplan02 
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag0201
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag0202
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"