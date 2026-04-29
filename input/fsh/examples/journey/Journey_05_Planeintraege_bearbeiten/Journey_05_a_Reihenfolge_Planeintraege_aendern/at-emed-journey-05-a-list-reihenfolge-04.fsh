Instance: At-Emed-Journey-05-a-List-Reihenfolge
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 05-a: Reihenfolge der Planeinträge ändern"
Description: "Beispiel Änderung der Reihenfolge der Medikationsplaneinträge (MedicationRequests) durch den Patienten."
Usage: #example

* identifier.value = "123"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-03-05T12:20:00+00:00"
* source = Reference(At-Emed-Example-Patient-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge mit geänderter Reihenfolge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

// * entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)  //nun an erster Stelle
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

// * entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-01)