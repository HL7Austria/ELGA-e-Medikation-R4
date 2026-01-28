Instance: AtEmedJourneyListMedikationsplan02 
InstanceOf: AtEmedListMedikationsplan   
Title: "Example List Medikationsplan 02"
Description: "Example List Medikationsplan 02"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2026-01-28T08:00:00+00:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#notstarted
