Instance: At-Emed-Journey-05-b-List-Aenderung
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Journey 05-b: Mediationsplan ändern (Einträge absetzen und ändern)."
Description: "Beispiel: Mediationsplan ändern (Einträge absetzen und ändern)."
Usage: #example

* identifier.value = "123"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-03-10T13:20:00+00:00"
* source = Reference(At-Emed-Example-Practitioner-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge mit geänderter Reihenfolge
* entry[+].flag.coding = ElgaListEntryFlagCS#removed "Planeintrag entfernt"

// * entry[=].date = "2026-03-10T13:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-02-Mr-Planeintrag-02)   // hier bleibt der alte Eintrag aus Journey 2 bestehen, da nur der Listeneintrag als ceased markiert wird
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

// * entry[=].date = "2026-03-10T13:20:00+00:00"
* entry[=].item = Reference(At-Emed-Journey-05-b-Mr-Planeintrag-01) // geänderter Eintrag