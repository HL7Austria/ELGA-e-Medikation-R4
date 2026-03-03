Instance: At-Emed-Journey-05-b-Bundle-Medikationsplan
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 05-b: Collection Bundle"
Description: "Beispiel eines Collection Bundles mit geändertem und abgesetztem Planeintrag."
Usage: #example

* identifier.system = "http://system-to-be-defined.com"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #collection
* timestamp = "2026-03-10T13:20:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-05-b-List-Aenderung
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-05-b-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"