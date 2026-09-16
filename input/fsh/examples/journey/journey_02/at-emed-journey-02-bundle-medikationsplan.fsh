Instance: At-Emed-Journey-02-Bundle-Medikationsplan
InstanceOf: AtElgaEmedBundleMedikationsplan   
Title: "Beispiel Journey 02: Medikationsplan-Searchset-Bundle"
Description: "Beispiel eines Medikationsplan-Searchset-Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen (MedicationRequests) referenziert."
Usage: #example

* type = #searchset
* timestamp = "2026-02-27T08:10:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Journey-02-List-Medikationsplan 
* entry[Medikationsplan].fullUrl = "https://example.elga.com/List/At-Emed-Journey-02-List-Medikationsplan"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-01
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-01"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-02-Mr-Planeintrag-02
* entry[Medikationsplaneintrag][=].fullUrl = "https://example.elga.com/MedicationRequest/At-Emed-Journey-02-Mr-Planeintrag-02"
* entry[Patient].resource = At-Emed-Example-Patient-01
* entry[Patient].fullUrl = "https://example.elga.com/Patient/At-Emed-Example-Patient-01"
* entry[Authors].resource = At-Emed-Example-Practitioner-01
* entry[Authors].fullUrl = "https://example.elga.com/Practitioner/At-Emed-Example-Practitioner-01"