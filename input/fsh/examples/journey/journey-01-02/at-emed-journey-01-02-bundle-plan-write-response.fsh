Instance: At-Emed-Journey-01-02-Bundle-plan-write-response
InstanceOf: Bundle   
Title: "Beispiel Journey 01-02: Plan-Write-Response "
Description: "Beispiel einer Response eines plan write mit 2 neuen Planeinträgen"
Usage: #example
* type = #transaction-response
* timestamp = "2026-02-27T08:10:00+00:00"
* link.url = "https://example.elga.com/base/List/$plan-write"
* link.relation = #self
// Liste 
* entry[+].resource = At-Emed-Journey-01-02-List-plan-write-response-List
* entry[=].fullUrl = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1"
* entry[=].response.status = "200"
* entry[=].response.location = "https://example.elga.com/List/4cb4dceb-173f-461a-a267-683ec33e4be1/_history/9f99de43-341d-40a0-a55d-21f6b4c305ed"
* entry[=].response.etag = "9f99de43-341d-40a0-a55d-21f6b4c305ed"
* entry[=].response.lastModified = "2026-09-23T13:54:03.698+00:00"
// Medikationsplaneinträge
// Eintrag 1
* entry[+].fullUrl = "https://example.elga.com/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52"
* entry[=].resource = At-Emed-Journey-01-02-plan-write-response-PE-01
* entry[=].response.status = "201"
* entry[=].response.location = "https://example.elga.com/MedicationRequest/6bacfe23-d469-4945-bf3c-90c7e647aa52/_history/aeb5e5e8-785a-430b-afef-ee57335b213d"
* entry[=].response.etag = "aeb5e5e8-785a-430b-afef-ee57335b213d"
* entry[=].response.lastModified = "2026-09-23T13:54:03.714+00:00"
// Eintrag 2
* entry[+].fullUrl = "https://example.elga.com/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391"
* entry[=].resource = At-Emed-Journey-01-02-plan-write-response-PE-02
* entry[=].response.status = "201"
* entry[=].response.location = "https://example.elga.com/MedicationRequest/55e4be12-0d10-454c-a85f-cfb5f849e391/_history/01275d13-fd59-4781-99ae-744fb90a1ba0"
* entry[=].response.etag = "01275d13-fd59-4781-99ae-744fb90a1ba0"
* entry[=].response.lastModified = "2026-09-23T13:54:03.76+00:00"

Instance: At-Emed-Journey-01-02-List-plan-write-response-List
InstanceOf: AtElgaEmedListMedikationsplan   
Title: "Beispiel Journey 01-02: Medikationsplan"
Description: "Beispiel eines Medikationsplans, der 2 Planeinträge referenziert und Informationen über Reihenfolge und Änderungsstatus speichert."
Usage: #example
* id = "4cb4dceb-173f-461a-a267-683ec33e4be1"
* meta.versionId = "9f99de43-341d-40a0-a55d-21f6b4c305ed"
* status = #current
* mode = #working
* code = $cs-sct#736378000 "Medikationsplan"
// logische referenz über bpkgh
* subject = Reference(At-Emed-Example-Patient-01)
* date = "2026-02-27T08:10:00+00:00"
// logische referenz über oid
* source = Reference(At-Emed-Example-PractitionerRole-01)
// * orderedBy = http://terminology.hl7.org/CodeSystem/list-order#user

// Listeneinträge
* entry[0].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item = Reference(At-Emed-Journey-01-02-plan-write-response-PE-01)

* entry[+].flag.coding = ElgaListEntryFlagCS#new "Neuer Planeintrag"
* entry[=].item = Reference(At-Emed-Journey-01-02-plan-write-response-PE-02)


Instance: At-Emed-Journey-01-02-plan-write-response-PE-01
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 1"
Description: "Bildet einen Planeintrag mit dem Arzneimittel Ramipril und der Dosierungsanweisung ab."
Usage: #example
* id = "6bacfe23-d469-4945-bf3c-90c7e647aa52"
* meta.versionId = "aeb5e5e8-785a-430b-afef-ee57335b213d"
* contained[+] = at-emed-journey-medicaiton-ramipril
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#continuous
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-0-0 | Täglich: 1-0-0-0" 
* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false 
// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#at-emed-journey-medicaiton-ramipril"
* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T08:10:00+00:00" 
* requester = Reference(At-Emed-Example-PractitionerRole-01)
//* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].patientInstruction = "Nehmen Sie die Tablette vor dem Essen mit ausreichend Flüssigkeit ein."
* dosageInstruction[standardDosage].timing.repeat.frequency = 1
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-event-timing#MORN  
* dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#{Stueck} "Stück" // TODO
* dosageInstruction[standardDosage].route = $cs-medikationartanwendung#100000073619 "zum Einnehmen"
//* dosageInstruction.doseAndRate.doseQuantity = 10 'mg' "mg"  //TODO




Instance: At-Emed-Journey-01-02-plan-write-response-PE-02
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Journey 01-02: Planeintrag 2"
Description: "Bildet einen Planeintrag mit einer magistralen Zubereitung (Dexpanthenol-Salbe) und der Dosierungsanweisung ab."
Usage: #example
* id = "55e4be12-0d10-454c-a85f-cfb5f849e391"
* meta.versionId = "01275d13-fd59-4781-99ae-744fb90a1ba0"
* contained[+] = d9641fa3-9b85-4ab9-a843-c08e5a6fc007
* courseOfTherapyType = $cs-medication-request-courseOfTherapyType#acute
// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-20"
* extension[renderedDosageInstruction].valueMarkdown = "1-0-1-0 | Täglich 1-0-1-0 für 3 Wochen" 
* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Planeintrag" 
* reportedBoolean = false
// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#d9641fa3-9b85-4ab9-a843-c08e5a6fc007"
* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T08:10:00+00:00"
* requester = Reference(At-Emed-Example-PractitionerRole-01)
//* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction[standardDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard
* dosageInstruction[standardDosage].sequence = 1
* dosageInstruction[standardDosage].timing.repeat.frequency = 2
* dosageInstruction[standardDosage].timing.repeat.period = 1
* dosageInstruction[standardDosage].timing.repeat.periodUnit = #d
* dosageInstruction[standardDosage].timing.repeat.when[0] = $cs-timing#MORN "Morgens"
* dosageInstruction[standardDosage].timing.repeat.when[+] = $cs-timing#EVE "Abends" 
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.value = 3
* dosageInstruction[standardDosage].timing.repeat.boundsDuration.unit = "wk"
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.value = 2        // TODO: Angabe für Salbe
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity.system = $cs-ucum
// * dosageInstruction[standardDosage].doseAndRate.doseQuantity = $cs-ucum#Stueck "Stück"
* dosageInstruction[standardDosage].route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

// Contained Medication *********************************************************************
Instance: d9641fa3-9b85-4ab9-a843-c08e5a6fc007
InstanceOf: AtElgaEmedMedicationMagistraleZubereitung
Title: "Beispiel Magistrale Zubereitung (Dexpanthenol-Salbe)"
Usage: #inline
// * text.status = #additional
// * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n<p>Freitext-Informationen zur magistralen Anwendung.</p>\n</div>"
//* status = #active
//* manufacturer = Reference(AtElgaEmed-Example-Organization-Apo-01) "Amadeus Apotheke"
* form.coding = https://termgit.elga.gv.at/CodeSystem/medikationdarreichungsform#100000073713 "Salbe"
* ingredient[+].itemCodeableConcept = $cs-atc#A11HA30 "Dexpanthenol"
* ingredient[=].strength.numerator = 5 'g' "g"
* ingredient[=].strength.denominator = 100 'g' "g"
* ingredient[+].itemCodeableConcept.text = "Salbengrundlage"
* ingredient[=].isActive = false
* ingredient[=].strength.numerator.value = 95
* ingredient[=].strength.numerator.unit = "g"
* ingredient[=].strength.denominator.value = 100
* ingredient[=].strength.denominator.unit = "g"



