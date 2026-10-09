Instance: At-Emed-Journey-01-02-Bundle-plan-write-response
InstanceOf: Bundle   
Title: "Beispiel Journey 01-02: Plan-Write-Response"
Description: "Beispiel einer Response eines plan-write mit 2 neuen Planeinträgen"
Usage: #example

* type = #transaction-response
* timestamp = "2026-02-27T08:10:00+00:00"
* link.url = "https://example.elga.com/base/List/$plan-write"
* link.relation = #self
// Liste 
* entry[+].resource = At-Emed-Journey-List-Medikationsplan-v2
* entry[=].fullUrl = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[=].response.status = "200"
* entry[=].response.location = "https://example.elga.com/base/List/4cb4dceb-173f-461a-a267-683ec33e4be1/_history/v25cd90b82-be84-41c1-ae4b-715d232fec20"
//* entry[=].response.etag = "v25cd90b82-be84-41c1-ae4b-715d232fec20"
* entry[=].response.lastModified = "2026-09-23T13:54:03.698+00:00"
// Medikationsplaneinträge
// Eintrag 1
* entry[+].fullUrl = "https://example.elga.com/base/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"
* entry[=].resource = At-Emed-Journey-Planeintrag-01-Ramipril-v1
* entry[=].response.status = "201"
* entry[=].response.location = "https://example.elga.com/base/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52/_history/v1aeb5e5e8-785a-430b-afef-ee57335b213d"
* entry[=].response.lastModified = "2026-09-23T13:54:03.714+00:00"
// Eintrag 2
* entry[+].fullUrl = "https://example.elga.com/base/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"
* entry[=].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-v1
* entry[=].response.status = "201"
* entry[=].response.location = "https://example.elga.com/base/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391/_history/v101275d13-fd59-4781-99ae-744fb90a1ba0"
* entry[=].response.lastModified = "2026-09-23T13:54:03.76+00:00"
