Alias: $sct = http://snomed.info/sct
Alias: $changetype = http://nehta.gov.au/codes/medications/changetype

Instance: AtEmedExampleListMedikationsplan01
InstanceOf: AtEmedListMedikationsplan
Title: "AtEmedListMedikationsplan-Beispiel"
Description: "AtEmedListMedikationsplan-Beispiel"
Usage: #example
* status = #current
* mode = #changes
* code = $sct#182836005 "Review of medication"
* code.text = "Medication Review"
* date = "2013-11-20T23:10:23+11:00"
* source = Reference(Patient/example)
* entry[0].flag = $changetype#01 "Prescribed"
* entry[=].item.display = "hydroxocobalamin"
* entry[+].flag = $changetype#02 "Cancelled"
* entry[=].deleted = true
* entry[=].item.display = "Morphine Sulfate"