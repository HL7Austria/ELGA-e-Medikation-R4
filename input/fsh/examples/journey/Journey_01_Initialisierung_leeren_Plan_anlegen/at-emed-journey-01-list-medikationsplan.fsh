Instance: At-Emed-Journey-01-List-Medikationsplan
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 01: Leerer Medikationsplan"
Description: "Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(At-Emed-Journey-01-Patient-01)
* date = "2026-01-28T08:00:00+11:00"
// Verantworlichtkeit der Intitialsierung durch die Flachanwendung
* source = Reference(At-Emed-Journey-01-Device)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
