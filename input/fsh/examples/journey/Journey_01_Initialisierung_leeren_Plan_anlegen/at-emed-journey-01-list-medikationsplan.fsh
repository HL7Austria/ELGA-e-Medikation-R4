Instance: At-Emed-Journey-01-List-Medikationsplan
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 01: Leerer Medikationsplan"
Description: "Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
Usage: #example

* identifier.value = "123"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-02-27T08:00:00+00:00" 
// Verantworlich für die intitiale Erstellung ist die Flachanwendung
* source = Reference(At-Emed-Example-Device-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
