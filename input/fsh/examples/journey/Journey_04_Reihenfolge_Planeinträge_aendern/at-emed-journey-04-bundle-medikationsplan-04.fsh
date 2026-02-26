Instance: At-Emed-Journey-04-Bundle-Medikationsplan
InstanceOf: AtEmedBundleMedikationsplan   
Title: "Beispiel Journey 04: Collection Bundle mit geänderter Reihenfolge der Planeinträge."
Description: "Beispiel eines Collection Bundles, mit geänderter Reihenfolge der Medikationsplaneinträge (referenziert List-Ressource mit Einträgen)."
Usage: #example

* identifier.system = "http://system-to-be-defined.com"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #collection
* timestamp = "2026-02-05T08:00:00+00:00"
// Liste: Die Position in der Liste bestimmt die Reihenfolge der Einträge im Medikationsplan
* entry[Medikationsplan].resource = At-Emed-Journey-04-List-Medikationsplan-Reihenfolge 
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
// Medikationsplaneinträge: hier ist die Reihenfolge egal
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"