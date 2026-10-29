Instance: At-Emed-Journey-List-Medikationsplan-v1
InstanceOf: AtElgaEmedListMedikationsplan   
Usage: #inline
Title: "Beispiel Journey 01-01: Leerer Medikationsplan"
Description: "Beispiel eines leeren Mediaktionsplans (List-Ressource ohne Einträge)"
* id = $idPlan
* meta.versionId = $idPlanv1
* meta.lastUpdated = "2026-02-27T08:00:00.120+00:00"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">TODO</div>"
* status = #current
* mode = #working
* code = $cs-sct#736378000   
* subject.type = "Patient"
* subject.identifier.value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* subject.identifier.system = "urn:oid:1.2.40.0.10.2.1.1.149"
* subject = Reference(At-Emed-Example-Patient-01)

* date = "2026-02-27T08:00:00+00:00" 
// Verantworlich für die intitiale Erstellung ist die Flachanwendung
* source = Reference(At-Emed-Example-Device-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
* emptyReason = $cs-list-empty-reason#notstarted
