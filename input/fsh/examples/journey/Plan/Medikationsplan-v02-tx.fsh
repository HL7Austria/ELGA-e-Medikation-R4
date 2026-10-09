Instance: At-Emed-Journey-List-Medikationsplan-v2-tx
//war At-Emed-Journey-01-02-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 01-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans, der 2 neue Planeinträge referenziert."
Usage: #inline
* id = "4cb4dceb-173f-461a-a267-683ec33e4be1"
//* meta.versionId = "2v5cd90b82-be84-41c1-ae4b-715d232fec20"
//in Transaction Bundle keine Version befüllt
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject.reference = "Patient?identifier=urn%3Aoid%3A1.2.40.0.10.2.1.1.149%7CGH%3AoeLdSEb0l%2B8kSdJWjOYyYmnYki0%3D" //Reference(At-Emed-Example-Patient-01) "Anton Mustermann"
* date = "2026-02-27T08:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = "urn:uuid:5e947f71-6881-46cc-9b06-81a1743aa674" //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-vPOST)

* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = "urn:uuid:7f1294a2-f592-4547-881c-c15d1debc165" //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-vPOST)