Instance: AtEmedJourneyBundleMedikationsplanTx01 
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 01: Transaction Bundle"
Description: "**Beschreibung:** Beispiel eines Transaction Bundles, das einen leeren Mediaktionsplan (List) beinhaltet."
Usage: #example

//* identifier.system = "http://system-to-be-defined.com"
* identifier.system = "urn:ietf:rfc:3981"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"

// Liste 
* entry[Medikationsplan].resource = AtEmedJourneyListMedikationsplanTx01
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/AtEmedJourneyListMedikationsplanTx01"


Instance: AtEmedJourneyListMedikationsplanTx01
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 01: Leerer Medikationsplan"
Description: "**Beschreibung:** Beispiel eines leeren Mediaktionsplans (List)"
Usage: #inline

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2026-01-28T08:00:00+11:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#notstarted
