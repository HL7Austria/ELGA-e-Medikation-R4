Alias: $hl7-at-religionaustria = https://termgit.elga.gv.at/CodeSystem/hl7-at-religionaustria
Alias: $iso-3166-1-alpha-3 = https://termgit.elga.gv.at/CodeSystem/iso-3166-1-alpha-3
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Instance: AtEmedExamplePatient01
InstanceOf: HL7ATCorePatient
Title: "Beispiel Patient 01"
Description: "Beispiel Patient 01"
Usage: #example
* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/5.0.0/StructureDefinition/at-core-patient"
* extension[0].extension.url = "code"
* extension[=].extension.valueCodeableConcept = $hl7-at-religionaustria#162 "Pastafarianismus"
* extension[=].url = "http://hl7.at/fhir/HL7ATCoreProfiles/5.0.0/StructureDefinition/at-core-ext-patient-religion"
* extension[+].extension.url = "code"
* extension[=].extension.valueCodeableConcept = $iso-3166-1-alpha-3#AUT "Österreich"
* extension[=].url = "http://hl7.org/fhir/StructureDefinition/patient-citizenship"
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
* name.given = "Max"
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