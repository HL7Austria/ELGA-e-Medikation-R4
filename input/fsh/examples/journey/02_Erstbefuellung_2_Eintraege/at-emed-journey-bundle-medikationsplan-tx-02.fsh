Instance: AtEmedJourneyBundleMedikationsplanTx02
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 02: Transaction Bundle"
Description: "**Beschreibung:** Beispiel eines Transaction Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) beinhaltet."
Usage: #example

* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplan02 
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/AtEmedJourneyListMedikationsplan02"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag0201
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/AtEmedJourneyMrPlaneintrag0201"
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag0202
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/AtEmedJourneyMrPlaneintrag0202"


