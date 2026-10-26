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
//* entry[Medikationsplan].response.etag = "v25cd90b82-be84-41c1-ae4b-715d232fec20"
* entry[Medikationsplan].response.lastModified = "2026-09-23T13:54:03.698+00:00"
// Medikationsplaneinträge
// Eintrag 1
* entry[Medikationsplaneintrag][+].fullUrl = $srPlaneintrag01
* entry[Medikationsplaneintrag][=].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v1
* entry[Medikationsplaneintrag][=].response.status = "201"
* entry[Medikationsplaneintrag][=].response.location = $srPlaneintrag01v1
* entry[Medikationsplaneintrag][=].response.lastModified = "2026-09-23T13:54:03.714+00:00"
// Eintrag 2
* entry[Medikationsplaneintrag][+].fullUrl = $srPlaneintrag02
* entry[Medikationsplaneintrag][=].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
* entry[Medikationsplaneintrag][=].response.status = "201"
* entry[Medikationsplaneintrag][=].response.location = $srPlaneintrag02v1
* entry[Medikationsplaneintrag][=].response.lastModified = "2026-09-23T13:54:03.76+00:00"
