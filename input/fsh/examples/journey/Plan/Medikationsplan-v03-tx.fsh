Instance: At-Emed-Journey-List-Medikationsplan-v3-tx
// war At-Emed-Journey-05-01-List-Medikationsplan
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 05-01: Medikationsplan"
Description: "Beispiel eines Medikationsplans mit 1 geänderten und 1 unveränderten Planeintrag."
Usage: #inline
* id = "4cb4dceb-173f-461a-a267-683ec33e4be1"
// versionid wird in der transaktion assigned
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"

* date = "2026-03-14T13:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#changed "Planeintrag geändert"
* entry[=].item.reference = "MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true


* entry[+].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = "MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"
* entry[=].item.extension[ResolveAsVersionSpecific].valueBoolean = true


