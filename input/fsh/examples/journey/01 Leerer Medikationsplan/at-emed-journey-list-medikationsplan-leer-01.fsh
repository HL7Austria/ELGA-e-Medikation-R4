Instance: AtEmedJourneyListMedikationsplanLeer01 
InstanceOf: AtEmedListMedikationsplan   
Title: "Example List Medikationsplan leer 01"
Description: "Example List Medikationsplan leer 01"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2013-11-20T23:10:23+11:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#notstarted
