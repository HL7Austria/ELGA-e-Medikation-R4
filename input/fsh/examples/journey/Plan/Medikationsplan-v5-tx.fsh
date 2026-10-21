Instance: At-Emed-Journey-List-Medikationsplan-v5-tx
// war At-Emed-Journey-07-02-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 07-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag."
Usage: #inline
* id = $idPlan
// versionid wird in der transaktion assigned

* status = #current
* mode = #working
* code = $cs-sct#736378000 
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* date = "2026-03-22T16:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-04) "Dr. Urlaubsvertretung"

// Planeintrag unverändert
* entry[0].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = $rrPlaneintrag01 //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v3)
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true

// Abgelaufenen Planeintrag entfernen
* entry[+].flag.coding = ElgaListEntryFlagCS#removed "Planeintrag entfernt"
* entry[=].item.reference = $rrPlaneintrag02 //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v2)
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true

// Planeintrag von Wirkstoff auf Arzneimittel gändert
* entry[+].flag.coding = ElgaListEntryFlagCS#changed "Planeintrag geändert"
* entry[=].item.reference = $rrPlaneintrag03 //Reference(Planeintrag-03-Wirkstoff-Metamizol-v2)
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true
