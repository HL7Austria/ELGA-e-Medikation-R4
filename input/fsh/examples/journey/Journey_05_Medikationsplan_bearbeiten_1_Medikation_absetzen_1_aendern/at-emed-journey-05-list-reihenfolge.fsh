Instance: At-Emed-Journey-05-List-Medikationsplan-Aenderung
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 04: Reihenfolge der Planeinträge ändern"
Description: "Beispiel: Medikation absetzen und ändern durch einen anderen GDA."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(At-Emed-Journey-01-Patient-01)
* date = "2026-02-07T08:00:00+00:00"
* source = Reference(At-Emed-Journey-01-Practitioner-02)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge mit geänderter Reihenfolge
* entry[0].flag.coding = #05 "Ceased"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-02-07T08:00:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)
* entry[+].flag.coding = #02 "Changed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-02-07T08:00:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-01)