Instance: At-Emed-Journey-List-Medikationsplan-v4
// war at-emed-journey-06-02-list-medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 06-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag."
Usage: #inline
* id = $idPlan
* meta.versionId = $idPlanv4
* status = #current
* mode = #working
* code = $cs-sct#736378000 
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = "Patient/At-Emed-Example-Patient-01"

* date = "2026-03-19T12:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-Organization-03) "Dr. Krankenhaus"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#changed "Planeintrag geändert"
* entry[=].item.reference = $rrPlaneintrag01v3 //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v3)


* entry[+].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = $rrPlaneintrag02v1 //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1)


* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = $rrPlaneintrag03v1 //Reference(Planeintrag-03-Wirkstoff-Metamizol-v1)

