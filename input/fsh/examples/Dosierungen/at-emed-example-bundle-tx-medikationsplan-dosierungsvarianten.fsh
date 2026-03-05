Instance: At-Emed-Example-Bundle-Tx-Medikationsplan-Dosierungsvarianten
InstanceOf: AtEmedBundleTxMedikationsplan   
Title: "Beispiel Transaction Bundle: Medikationsplan mit Dosierungsvarianten"
Description: "Beispiel eines Transaction Bundles:  Medikationsplan mit Dosierungsvarianten."
Usage: #example

* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"
// Liste 
* entry[Medikationsplan].resource = At-Emed-Example-List-Medikationsplan-Dosierungsvarianten
* entry[Medikationsplan].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a56"
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/At-Emed-Example-List-Medikationsplan-Dosierungsvarianten"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = At-Emed-Example-Mr-Dosierung-Freitext
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a57"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Example-Mr-Dosierung-Freitext"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Example-Mr-Dosierung-1010
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a58"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Example-Mr-Dosierung-1010"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Example-Mr-Dosierung-Zeit-1tg
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a59"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Example-Mr-Dosierung-Zeit-1tg"
* entry[Medikationsplaneintrag][+].resource = At-Emed-Example-Mr-Dosierung-Wochentag
* entry[Medikationsplaneintrag][=].fullUrl = "urn:uuid:62e2daa5-c34b-4b97-8044-fd893bc99a60"
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/At-Emed-Example-Mr-Dosierung-Wochentag"
