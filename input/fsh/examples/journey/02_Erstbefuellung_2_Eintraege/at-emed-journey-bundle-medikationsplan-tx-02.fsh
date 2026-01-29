Instance: AtEmedJourneyBundleMedikationsplanTx02
InstanceOf: AtEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 02: Transaction Bundle"
Description: "**Beschreibung:** Beispiel eines Transaction Bundles, das einen Mediaktionsplan (List) mit 2 Planeinträgen beinhaltet."
Usage: #example
* meta.profile = "http://example.org/fhir/StructureDefinition/AtEmedBundleMedikationsplanTx"
* identifier.system = "http://example.org/fhir/bundle-identifier"
* identifier.value = "BundleTx-12345"

* identifier.system = "urn:ietf:rfc:3982"
* identifier.value = "63fef90a-be11-4ddf-aece-d77da15c4f20"
* type = #transaction
* timestamp = "2026-01-28T08:00:00+00:00"

// Liste 
* entry[Medikationsplan][+].resource = AtEmedJourneyListMedikationsplanTx02
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = "List/AtEmedJourneyListMedikationsplanTx02"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag02Tx01
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/AtEmedJourneyMrPlaneintrag02Tx01"
* entry[Medikationsplaneintrag][+].resource = AtEmedJourneyMrPlaneintrag02Tx02
* entry[Medikationsplaneintrag][=].request.method = #PUT 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest/AtEmedJourneyMrPlaneintrag02Tx02"


//************* Medikationsplan (List)  **********************/


Instance: AtEmedJourneyListMedikationsplanTx02 
InstanceOf: AtEmedListMedikationsplan   
Title: "Beispiel List Medikationsplan 02"
Description: "Beispiel List Medikationsplan 02"
Usage: #inline
//* meta.profile = "http://example.org/fhir/StructureDefinition/AtEmedListMedikationsplan"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient01)
* date = "2026-01-28T08:00:00+00:00"
* source = Reference(AtEmedExamplePractitioner01)
* orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user
// Listeneinträge
* entry[0].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0201)
* entry[+].flag.coding = #04 "Prescribed"
* entry[=].flag.coding.system = "urn:oid:1.2.36.1.2001.1001.101.104.16592"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0202)


//************* Planeintrag 1 (MedicationRequest) **********************/

Instance: AtEmedJourneyMrPlaneintrag02Tx01
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Medikationsplaneintrag 02-01"
Description: "Beispiel Medikationsplaneintrag 02-01"
Usage: #inline
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 Kapsel täglich morgens"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4711"
// * identifier.system = "urn:ietf:rfc:3986"
// * identifier.value = "urn:uuid:cdbd33f0-6cde-11db-9fe1-0800200c9a66"
* status = #active
* intent = #order
* category.coding = http://hl7.org/fhir/medicationrequest-category#1 "Medikationsplaneintrag"
* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)
* reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"
// * groupIdentifier.value = "WYE82A2G8EE1"  // nicht im Medikationsplaneintrag
* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction.text = "1 Kapsel täglich morgens"
* dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel jeden Morgen mit ausreichend Flüssigkeit ein."
//* dosageInstruction.additionalInstruction = $sct#1153465004 "Education about overdosing"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.timing.period = 4
// * dosageInstruction.timing.periodMax = 6
// * dosageInstruction.timing.periodUnit = "h"
// * dosageInstruction.asNeededCodeableConcept = $sct#56018004 "wheezing"
* dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073619 "zum Einnehmen"
* dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction.maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction.maxDosePerPeriod.denominator = 1 '{day}' "{day}"
// Anzahl der Einlösungen (nur in der geplanten Abgabe relevant?)
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.validityPeriod.end = "2026-02-03"
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"

// zugrundeliegender Medikationsplaneintrag nach einer Änderung?
//* basedOn = Reference(MedicationRequest/AtEmedExampleMedicationRequestPlaneintrag01) "Planeintrag"



//************* Planeintrag 2 (MedicationRequest) **********************/

Instance: AtEmedJourneyMrPlaneintrag02Tx02
InstanceOf: AtEmedMRPlaneintrag   
Title: "Beispiel Medikationsplaneintrag 02-02"
Description: "Beispiel Medikationsplaneintrag 02-02"
Usage: #inline
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-01-28"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-02-28"
* extension[renderedDosageInstruction].valueMarkdown = "1 täglich auftragen"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4712"
// * identifier.system = "urn:ietf:rfc:3986"
// * identifier.value = "urn:uuid:cdbd33f0-6cde-11db-9fe1-0800200c9a66"
//* identifier.system = "http://www.bmc.nl/portal/prescriptions"
* status = #active
* intent = #order
* category.coding = http://hl7.org/fhir/medicationrequest-category#1 "Medikationsplaneintrag"
* medicationReference = Reference(AtEmedJourneyMedicationMagistral02) "Magistrale Zubereitung"
* subject = Reference(AtEmedExamplePatient01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01)
// * reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"
// * groupIdentifier.value = "WYE82A2G8EE1"  // nicht im Medikationsplaneintrag
* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction.text = "1 täglich auftragen"
* dosageInstruction.patientInstruction = "Abends sehr dünn auf die betroffene Stelle auftragen."
//* dosageInstruction.additionalInstruction = $sct#1153465004 "Education about overdosing"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
// * dosageInstruction.timing.period = 4
// * dosageInstruction.timing.periodMax = 6
// * dosageInstruction.timing.periodUnit = "h"
// * dosageInstruction.asNeededCodeableConcept = $sct#56018004 "wheezing"
* dosageInstruction.route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"
// * dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction.maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction.maxDosePerPeriod.denominator = 1 '{day}' "{day}"
// Anzahl der Einlösungen (nur in der geplanten Abgabe relevant?)
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.validityPeriod.end = "2026-02-03"
// * dispenseRequest.quantity.value = 30
// * dispenseRequest.quantity.unit = "Kapseln"
* dispenseRequest.expectedSupplyDuration = 30 'd' "Tage"
// zugrundeliegender Medikationsplaneintrag nach einer Änderung?
//* basedOn = Reference(MedicationRequest/AtEmedExampleMedicationRequestPlaneintrag01) "Planeintrag"

