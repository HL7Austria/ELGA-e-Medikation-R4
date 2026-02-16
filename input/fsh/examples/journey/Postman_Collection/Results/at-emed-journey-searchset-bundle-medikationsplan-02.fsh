Alias: $sct = http://snomed.info/sct
Alias: $list-order = http://terminology.hl7.org/CodeSystem/list-order
Alias: $MedicationRequestCategoryCS = https://fhir.hl7.at/elga/emed/r4/CodeSystem/MedicationRequestCategoryCS
Alias: $asp-liste = https://termgit.elga.gv.at/CodeSystem/asp-liste
Alias: $CodeSystem-medikationartanwendung.html = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html
Alias: $hl7-at-religionaustria = https://termgit.elga.gv.at/CodeSystem/hl7-at-religionaustria
Alias: $iso-3166-1-alpha-3 = https://termgit.elga.gv.at/CodeSystem/iso-3166-1-alpha-3
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Instance: AtEmedJourneyBundleMedikationsplan02ss01
InstanceOf: Bundle
Usage: #example
* meta.lastUpdated = "2026-02-10T15:18:13.015+00:00"
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "https://hapi.fhir.org/baseR4/List?_include=*&patient=Patient%2FAtEmedExamplePatient02ss02"
* entry[0].fullUrl = "https://hapi.fhir.org/baseR4/List/AtEmedJourneyListMedikationsplan02ss02"
* entry[=].resource = AtEmedJourneyListMedikationsplan02ss02
* entry[=].search.mode = #match
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/MedicationRequest/AtEmedJourneyMrPlaneintrag0202ss02"
* entry[=].resource = AtEmedJourneyMrPlaneintrag0202ss02
* entry[=].search.mode = #include
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/MedicationRequest/AtEmedJourneyMrPlaneintrag0201ss02"
* entry[=].resource = AtEmedJourneyMrPlaneintrag0201ss02
* entry[=].search.mode = #include
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/Practitioner/AtEmedExamplePractitioner01ss02"
* entry[=].resource = AtEmedExamplePractitioner01ss02
* entry[=].search.mode = #include
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/Patient/AtEmedExamplePatient02ss02"
* entry[=].resource = AtEmedExamplePatient02ss02
* entry[=].search.mode = #include

Instance: AtEmedJourneyListMedikationsplan02ss02
InstanceOf: List
Usage: #inline
* meta.versionId = "3"
* meta.lastUpdated = "2026-02-10T15:14:55.310+00:00"
* meta.source = "#FPldqdn9bnu6I6Cf"
* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-list-medikationsplan"
* status = #current
* mode = #working
* code = $sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient02ss02)
* date = "2026-01-28T08:00:00+00:00"
* source = Reference(AtEmedExamplePractitioner01ss02)
* orderedBy = $list-order#user
* entry[0].flag = urn:oid:1.2.36.1.2001.1001.101.104.16592#04 "Prescribed"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0201ss02)
* entry[+].flag = urn:oid:1.2.36.1.2001.1001.101.104.16592#04 "Prescribed"
* entry[=].date = "2026-01-28T08:00:00+00:00"
* entry[=].item = Reference(AtEmedJourneyMrPlaneintrag0202ss02)

Instance: AtEmedJourneyMrPlaneintrag0202ss02
InstanceOf: MedicationRequest
Usage: #inline
* meta.versionId = "2"
* meta.lastUpdated = "2026-02-10T15:14:55.310+00:00"
* meta.source = "#FPldqdn9bnu6I6Cf"
* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-mr-planeintrag"
* extension[0].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod"
* extension[=].valuePeriod.start = "2026-01-28"
* extension[=].valuePeriod.end = "2026-02-28"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
* extension[=].valueMarkdown = "1 täglich auftragen"
* identifier.value = "4712"
* status = #active
* intent = #order
* category = $MedicationRequestCategoryCS#1
* medicationCodeableConcept = $asp-liste#0004340 "ASPIRIN TBL 500MG"
* subject = Reference(AtEmedExamplePatient02ss02)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01ss02)
* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction.text = "1 täglich auftragen"
* dosageInstruction.patientInstruction = "Abends sehr dünn auf die betroffene Stelle auftragen."
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.route = $CodeSystem-medikationartanwendung.html#100000073566 "Anwendung auf der Haut"

Instance: AtEmedJourneyMrPlaneintrag0201ss02
InstanceOf: MedicationRequest
Usage: #inline
* meta.versionId = "2"
* meta.lastUpdated = "2026-02-10T15:14:55.310+00:00"
* meta.source = "#FPldqdn9bnu6I6Cf"
* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-mr-planeintrag"
* extension[0].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod"
* extension[=].valuePeriod.start = "2026-01-28"
* extension[=].valuePeriod.end = "2026-02-28"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
* extension[=].valueMarkdown = "1 Kapsel täglich morgens"
* identifier.value = "4711"
* status = #active
* intent = #order
* category = $MedicationRequestCategoryCS#1
* medicationCodeableConcept = $asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(AtEmedExamplePatient02ss02)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(AtEmedExamplePractitioner01ss02)
* reasonCode = $sct#59621000 "Essentielle Hypertonie"
* note.text = "Freitext Informationen zum Medikationsplaneintrag."
* dosageInstruction.text = "1 Kapsel täglich morgens"
* dosageInstruction.patientInstruction = "Nehmen Sie die Kapsel jeden Morgen mit ausreichend Flüssigkeit ein."
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.route = $CodeSystem-medikationartanwendung.html#100000073619 "zum Einnehmen"
* dosageInstruction.doseAndRate.doseQuantity = 5 'mg' "mg"

Instance: AtEmedExamplePractitioner01ss02
InstanceOf: Practitioner
Usage: #inline
* meta.versionId = "1"
* meta.lastUpdated = "2026-02-10T08:57:29.799+00:00"
* meta.source = "#yUly1sggUdCSs0mz"
* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-practitioner"
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:1.2.40.0.34.99.4613.4"
* identifier[=].assigner.display = "Bundesministerium für Gesundheit"
* identifier[+].system = "urn:oid:1.2.40.0.10.1.4.3.2"
* identifier[=].value = "987654321"
* identifier[=].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* active = true
* name.family = "Musterärztin"
* name.given = "Melanie"
* name.prefix = "Prof. Dr."
* telecom[0].system = #email
* telecom[=].value = "office@musterpraxis.at"
* telecom[=].use = #work
* telecom[+].system = #phone
* telecom[=].value = "+436500987654321"
* telecom[=].use = #work
* address.use = #work
* address.type = #both
* address.line = "Mozartgasse 8 Stiege 2"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Mozartgasse"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "8"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-additionalLocator"
* address.line.extension[=].valueString = "Stiege 2"
* address.line.extension[+].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-address-additionalInformation"
* address.line.extension[=].valueString = "Barrierefreier Zugang"
* address.city = "St. Wolfgang"
* address.state = "Salzburg"
* address.postalCode = "5350"
* address.country = "AUT"
* gender = #female

Instance: AtEmedExamplePatient02ss02
InstanceOf: Patient
Usage: #inline
* meta.versionId = "3"
* meta.lastUpdated = "2026-02-10T15:02:49.056+00:00"
* meta.source = "#qk9ph8gyzRWfK9vX"
* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-patient"
* extension[0].url = "http://hl7.at/fhir/HL7ATCoreProfiles/5.0.0/StructureDefinition/at-core-ext-patient-religion"
* extension[=].extension.url = "code"
* extension[=].extension.valueCodeableConcept = $hl7-at-religionaustria#162 "Pastafarianismus"
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-citizenship"
* extension[=].extension.url = "code"
* extension[=].extension.valueCodeableConcept = $iso-3166-1-alpha-3#AUT "Österreich"
* identifier[0].type = $v2-0203#SS "Social Security number"
* identifier[=].system = "urn:oid:1.2.40.0.10.1.4.3.1"
* identifier[=].value = "1234010100"
* identifier[=].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* identifier[+].type = $v2-0203#NI "National unique individual identifier"
* identifier[=].system = "urn:oid:1.2.40.0.10.2.1.1.149"
* identifier[=].value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* identifier[=].assigner.display = "Bundesministerium für Inneres"
* identifier[+].type = $v2-0203#PI "Patient internal identifier"
* identifier[=].system = "urn:oid:1.2.3.4.5"
* identifier[=].value = "0815"
* identifier[=].assigner.display = "Ein GDA in Österreich"
* name.family = "Mustermann"
* name.given = "Maxima"
* name.prefix = "DI"
* telecom[0].system = #email
* telecom[=].value = "office@hl7.at"
* telecom[=].use = #work
* telecom[+].system = #phone
* telecom[=].value = "+436501234567890"
* telecom[=].use = #home
* gender = #male
* birthDate = "1900-01-01"
* address.use = #home
* address.type = #both
* address.line = "Landstrasse 1 Stock 9 Tür 42"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Landstrasse"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "1"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-additionalLocator"
* address.line.extension[=].valueString = "Stock 9 Tür 42"
* address.line.extension[+].url = "http://hl7.at/fhir/HL7ATCoreProfiles/5.0.0/StructureDefinition/at-core-ext-address-additionalInformation"
* address.line.extension[=].valueString = "Lift vorhanden"
* address.city = "Linz"
* address.state = "Oberösterreich"
* address.postalCode = "4020"
* address.country = "AUT"