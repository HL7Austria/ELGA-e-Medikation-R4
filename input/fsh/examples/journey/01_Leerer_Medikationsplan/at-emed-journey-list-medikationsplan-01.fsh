Instance: AtEmedJourneyListMedikationsplan01 
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 01: Leerer Medikationsplan"
Description: "**Beschreibung:** Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2026-01-28T08:00:00+11:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
