Instance: At-Emed-Journey-02-List-Medikationsplan
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 02: Medikationsplan"
Description: "Beispiel eines Medikationsplans (List), der 2 Planeinträge (MedicationRequests) referenziert und Informationen über Reihenfolge und Änderungsstatus speichert."
Usage: #example

* identifier.value = "123"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-02-27T10:20:00+00:00"
* source = Reference(At-Emed-Example-Practitioner-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

// * entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-01)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

// * entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)