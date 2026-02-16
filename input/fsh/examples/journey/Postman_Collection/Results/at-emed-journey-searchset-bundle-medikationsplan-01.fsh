Alias: $sct = http://snomed.info/sct
Alias: $list-order = http://terminology.hl7.org/CodeSystem/list-order
Alias: $list-empty-reason = http://terminology.hl7.org/CodeSystem/list-empty-reason
Alias: $hl7-at-religionaustria = https://termgit.elga.gv.at/CodeSystem/hl7-at-religionaustria
Alias: $iso-3166-1-alpha-3 = https://termgit.elga.gv.at/CodeSystem/iso-3166-1-alpha-3
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Instance: AtEmedJourneyBundleMedikationsplan01ss01
InstanceOf: Bundle
Usage: #example
* meta.lastUpdated = "2026-02-10T15:07:11.753+00:00"
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "https://hapi.fhir.org/baseR4/List?_include=*&patient=Patient%2FAtEmedExamplePatient02ss01"
* entry[0].fullUrl = "https://hapi.fhir.org/baseR4/List/AtEmedJourneyListMedikationsplan01ss01"
* entry[=].resource = AtEmedJourneyListMedikationsplan01ss01
* entry[=].search.mode = #match
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/Practitioner/AtEmedExamplePractitioner01ss01"
* entry[=].resource = AtEmedExamplePractitioner01ss01
* entry[=].search.mode = #include
* entry[+].fullUrl = "https://hapi.fhir.org/baseR4/Patient/AtEmedExamplePatient02ss01"
* entry[=].resource = AtEmedExamplePatient02ss01
* entry[=].search.mode = #include

Instance: AtEmedJourneyListMedikationsplan01ss01
InstanceOf: List
Usage: #inline
* meta.versionId = "1"
* meta.lastUpdated = "2026-02-10T15:00:20.545+00:00"
* meta.source = "#lgQtGPwo1RDkOQVN"
* meta.profile = "https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-emed-list-medikationsplan"
* status = #current
* mode = #working
* code = $sct#736378000 "Medikationsplan"
* subject = Reference(AtEmedExamplePatient02ss01)
* date = "2026-01-28T08:00:00+11:00"
* source = Reference(AtEmedExamplePractitioner01ss01)
* orderedBy = $list-order#user
* emptyReason = $list-empty-reason#notstarted

Instance: AtEmedExamplePractitioner01ss01
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

Instance: AtEmedExamplePatient02ss01
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