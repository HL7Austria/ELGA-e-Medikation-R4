Instance: At-Emed-Journey-05-a-List-Reihenfolge
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 05-a: Reihenfolge der Planeinträge ändern"
Description: "Beispiel Änderung der Reihenfolge der Medikationsplaneinträge (MedicationReqeusts) durch den Patienten."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medication management plan (record artifact)"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-03-05T12:20:00+00:00"
* source = Reference(At-Emed-Example-Patient-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge mit geänderter Reihenfolge
* entry[0].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)  //nun an erster Stelle
* entry[+].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-01)