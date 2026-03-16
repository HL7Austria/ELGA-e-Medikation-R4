Instance: At-Emed-Journey-01-List-Medikationsplan
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 01: Leerer Medikationsplan"
Description: "Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medication management plan (record artifact)"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-02-27T08:00:00+00:00" 
// Verantworlichtkeit der Intitialsierung durch die Flachanwendung
* source = Reference(At-Emed-Example-Device-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
