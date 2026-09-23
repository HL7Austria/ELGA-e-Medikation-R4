Instance: At-Emed-Journey-07-01-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 07-01: Medikationsplan"
Description: "Beispiel eines Medikationsplans mit einem geänderten, einem unveränderten und einem neuen Planeintrag."
Usage: #example

* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject = Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* date = "2026-03-22T16:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"

// Planeintrag unverändert
* entry[0].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item = Reference(At-Emed-Journey-06-02-Mr-Planeintrag-01)

// Abgelaufenen Planeintrag entfernen
* entry[+].flag.coding = ElgaListEntryFlagCS#removed "Planeintrag entfernt"
* entry[=].item = Reference(At-Emed-Journey-07-01-Mr-Planeintrag-02)

// Planeintrag von Wirkstoff auf Arzneimittel gändert
* entry[+].flag.coding = ElgaListEntryFlagCS#changed "Planeintrag geändert"
* entry[=].item = Reference(At-Emed-Journey-07-01-Mr-Planeintrag-03)