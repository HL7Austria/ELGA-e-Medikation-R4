Instance: At-Emed-Journey-List-Medikationsplan-v2-tx
//war At-Emed-Journey-01-02-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 01-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans, der 2 neue Planeinträge referenziert."
Usage: #inline
* id = $idPlan
//* meta.versionId = "2v5cd90b82-be84-41c1-ae4b-715d232fec20"
// versionid wird in der transaktion assigned
//in Transaction Bundle keine Version befüllt
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* date = "2026-02-27T08:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = $POSTuuidPlaneintrag01 //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-vPOST)
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true

* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = $POSTuuidPlaneintrag02 //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-vPOST)
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true
