Instance: At-Emed-Journey-01-02-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 01-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans, der 2 Planeinträge referenziert und Informationen über Reihenfolge und Änderungsstatus speichert."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* date = "2026-02-27T08:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item = Reference(At-Emed-Journey-01-02-Mr-Planeintrag-01)

* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item = Reference(At-Emed-Journey-01-02-Mr-Planeintrag-02)