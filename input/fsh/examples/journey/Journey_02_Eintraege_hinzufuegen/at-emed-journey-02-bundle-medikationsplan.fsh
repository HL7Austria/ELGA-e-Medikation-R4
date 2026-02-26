Instance: At-Emed-Journey-02-Bundle-Medikationsplan
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 02: Collection Bundle"
Description: "Beispiel eines Collection Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) referenziert."
Usage: #example

* identifier.system = "http://system-to-be-defined.com"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #collection
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-02-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"