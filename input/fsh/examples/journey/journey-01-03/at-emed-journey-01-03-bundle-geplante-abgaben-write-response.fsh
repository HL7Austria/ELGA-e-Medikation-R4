Instance: At-Emed-Journey-01-03-Bundle-Geplante-Abgaben-Write-Response
InstanceOf: AtElgaEmedBundleGeplanteAbgabenWriteResponse
Title: "Beispiel Journey 01-03: Prescription-Write-Response"
Description: "Beispiel einer Response eines prescription-write mit 2 neuen Geplanten Abgaben"
Usage: #example

* type = #transaction-response
* link.url = "https://example.elga.com/base/MedicationRequest/$prescription-write"
* link.relation = #self
// Geplante Abgabe 1
* entry[+].fullUrl = $srGeplanteAbgabe01
* entry[=].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01
* entry[=].response.status = "201"
* entry[=].response.location = $srGeplanteAbgabe01v1
* entry[=].response.lastModified = "2026-02-27T08:15:00.204+00:00"
// Geplante Abgabe 2
* entry[+].fullUrl = $srGeplanteAbgabe02
* entry[=].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02
* entry[=].response.status = "201"
* entry[=].response.location = $srGeplanteAbgabe02v1
* entry[=].response.lastModified = "2026-02-27T08:15:00.231+00:00"
