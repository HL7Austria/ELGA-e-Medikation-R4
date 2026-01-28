Instance: AtEmedJourneyListMedikationsplan02 
InstanceOf: AtEmedListMedikationsplan   
Title: "Example List Medikationsplan 02"
Description: "Example List Medikationsplan 02"
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2013-11-20T23:10:23+11:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = #user
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#notstarted
