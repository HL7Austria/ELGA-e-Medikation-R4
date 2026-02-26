Instance: At-Emed-Journey-01-Bundle-Ts-Medikationsplan
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 01: Transaction Bundle"
Description: "Beispiel eines Transaction Bundles, mit leerem Mediaktionsplan (referenziert List-Ressource ohne Einträge)."
Usage: #example

* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-01-List-Medikationsplan
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a55"
* entry[Medikationsplan].request.method = #PUT 
* entry[Medikationsplan].request.url = "List/At-Emed-Journey-01-List-Medikationsplan"


// Instance: At-Emed-Journey-ListMedikationsplanTx01
// InstanceOf: AtEmedListMedikationsplan   
// Title: "Beispiel Journey 01: Leerer Medikationsplan"
// Description: "Beispiel eines leeren Mediaktionsplans (List)"
// Usage: #inline

// * status = #current
// * mode = #working
// * code = $cs-sct#736378000 "Medikationsplan"
// * subject = Reference(At-Emed-Journey-01-Patient-01)
// * date = "2026-01-28T08:00:00+11:00"
// * source = Reference(At-Emed-Journey-01-Practitioner-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
// * emptyReason = $cs-list-empty-reason#notstarted
