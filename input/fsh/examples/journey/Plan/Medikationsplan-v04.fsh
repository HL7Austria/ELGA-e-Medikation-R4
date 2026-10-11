Instance: At-Emed-Journey-List-Medikationsplan-v4
// war at-emed-journey-06-02-list-medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 06-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans mit 1 geänderten, 1 unveränderten und 1 neuen Planeintrag."
Usage: #inline
* id = "4cb4dceb-173f-461a-a267-683ec33e4be1"
* meta.versionId = "v44e178346-9406-48f7-bb5e-583166011fd3"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* date = "2026-03-19T12:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-03) "Dr. Krankenhaus"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#changed "Planeintrag geändert"
* entry[=].item.reference = "MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52/_history/v34540d8b6-2e8d-46a8-bf52-fc0d59325760" //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v3)


* entry[+].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = "MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391/_history/v101275d13-fd59-4781-99ae-744fb90a1ba0" //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1)


* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item.reference = "MedicationRequest/7128c60c-126d-42b2-b575-dc26a2324b8b/_history/v19bb12b57-04a0-4d19-af1f-e78c3cc628cc" //Reference(Planeintrag-03-Wirkstoff-Metamizol-v1)

