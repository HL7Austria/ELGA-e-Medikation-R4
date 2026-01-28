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

// Listeneinträge
* entry[0].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0201)
* entry[+].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0202)