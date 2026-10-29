Instance: At-Emed-Journey-List-Medikationsplan-v3-plan-read-response
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 05-01: Medikationsplan"
Description: "TODO"
Usage: #inline
* id = $idPlan

* status = #current
* mode = #working
* code = $cs-sct#736378000 
// logische referenz über bpkgh
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject.reference = "Patient/At-Emed-Example-Patient-01"
* date = "2026-03-14T13:12:00+00:00"
// logische referenz über oid
* source.identifier.system = "urn:ietf:rfc:3986"
* source.identifier.value = "urn:oid:1.2.40.0.34.99.4613.1"
* source = Reference(At-Emed-Example-Practitioner-01) "Dr. Hausärztin"
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = $rrPlaneintrag01v2 //Reference(At-Emed-Journey-Planeintrag-01-Ramipril-v1)


* entry[+].flag.coding = ElgaListEntryFlagCS#unchanged "Planeintrag beibehalten"
* entry[=].item.reference = $rrPlaneintrag02v1 //Reference(At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1)

