Instance: At-Emed-Journey-02-List-Medikationsplan
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 02: Medikationsplan"
Description: "Beispiel eines Medikationsplans (List), der 2 Planeinträge (MedicationReqeusts) referenziert und Informationen über Reihenfolge und Änderungsstatus speichert."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(At-Emed-Journey-01-Patient-01)
* date = "2026-01-28T08:00:00+00:00"
* source = Reference(At-Emed-Journey-01-Practitioner-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-01)
* entry[+].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)