Instance: At-Emed-Example-List-Medikationsplan-Dosierungsvarianten
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel Medikationsplan mit Dosierungsvarianten"
Description: "Beispiel Medikationsplan (List) mit Dosierungsvarianten: Freitext Dosierung, Schema mit Tageszeiten-Bezug (1-0-1-0), Schema mit Uhrzeiten-Bezug."
Usage: #example

* identifier.value = "123"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"  // "Medikationsplan"
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-02-27T10:20:00+00:00"
* source = Reference(At-Emed-Example-Practitioner-01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Freitext)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-1010)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Zeit-1tg)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Wochentag)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Intervalle-Wh)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Zeitintervalle-Kombi)
* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"

* entry[=].date = "2026-02-27T10:20:00+00:00"
* entry[=].item = Reference(At-Emed-Example-Mr-Dosierung-Wochentag-Kombi)




