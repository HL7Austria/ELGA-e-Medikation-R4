Alias: $sct = http://snomed.info/sct
Alias: $changetype = http://nehta.gov.au/codes/medications/changetype

Instance: AtEmedExampleMedikationsplan01
InstanceOf: AtEmedListMedikationsplan   
Title: "Example Medikationsplan 1"
Description: "Example Medikationsplan 1"
Usage: #example
* status = #current
//* mode = #working
//* code = $sct#182836005 "Review of medication"
//* code.text = "Medication Review"
//* date = "2013-11-20T23:10:23+11:00"
//* source = Reference(Patient/example)
* entry[0].flag = #01 "Unchanged"
// * entry[=].item.display = "hydroxocobalamin"
// * entry[+].flag = $changetype#02 "Cancelled"
// * entry[=].deleted = true
// * entry[=].item.display = "Morphine Sulfate"

* entry.item = Reference(AtEmedExamplePlaneintrag01)

// hier gehören die Medikationsplaneinträge hinein
// Hier gehört die List Ressource hinein, die die Reihenfolge des Medikationsplans abbildet