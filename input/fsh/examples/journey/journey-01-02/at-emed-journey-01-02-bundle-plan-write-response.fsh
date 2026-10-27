Instance: At-Emed-Journey-01-02-Bundle-plan-write-response
InstanceOf: AtElgaEmedBundleMedikationsplanWriteResponse
Title: "Beispiel Journey 01-02: Plan-Write-Response"
Description: "Beispiel einer Response eines plan-write mit 2 neuen Planeinträgen"
Usage: #example

* type = #transaction-response
* link.url = "https://example.elga.com/base/List/$plan-write"
* link.relation = #self
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-List-Medikationsplan-v2
* entry[Medikationsplan].fullUrl = $srPlan
* entry[Medikationsplan].response.status = "200"
* entry[Medikationsplan].response.location = $srPlanv2
* entry[Medikationsplan].response.lastModified = "2026-02-27T08:10:00.312+00:00"
// Medikationsplaneinträge
// Eintrag 1
* entry[Medikationsplaneintrag][+].fullUrl = $srPlaneintrag01
* entry[Medikationsplaneintrag][=].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v1
* entry[Medikationsplaneintrag][=].response.status = "201"
* entry[Medikationsplaneintrag][=].response.location = $srPlaneintrag01v1
* entry[Medikationsplaneintrag][=].response.lastModified = "2026-02-27T08:10:00.314+00:00"
// Eintrag 2
* entry[Medikationsplaneintrag][+].fullUrl = $srPlaneintrag02
* entry[Medikationsplaneintrag][=].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
* entry[Medikationsplaneintrag][=].response.status = "201"
* entry[Medikationsplaneintrag][=].response.location = $srPlaneintrag02v1
* entry[Medikationsplaneintrag][=].response.lastModified = "2026-02-27T08:10:00.360+00:00"
