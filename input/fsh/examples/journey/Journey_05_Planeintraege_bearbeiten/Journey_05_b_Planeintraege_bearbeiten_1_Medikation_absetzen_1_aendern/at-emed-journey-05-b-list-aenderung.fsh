Instance: At-Emed-Journey-05-b-List-Aenderung
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 05-b: Reihenfolge der Planeinträge ändern"
Description: "Beispiel: Medikation absetzen und ändern durch einen anderen GDA."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-03-10T13:20:00+00:00"
* source = Reference(At-Emed-Example-Practitioner-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge mit geänderter Reihenfolge
* entry[+].flag.coding = #05 "Ceased"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-03-10T13:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)   // hier bleibt der alte Eintrag aus Journey 2 bestehen, da nur der Listeneintrag als ceased markiert wird
* entry[0].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-03-10T13:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-05-b-Mr-Planeintrag-01) // geänderter Eintrag