Instance: AtEmedExamplePractitioner01
InstanceOf: HL7ATCorePractitioner
Title: "HL7ATCorePractitioner"
Description: "Beispiel eines behandelnden Arztes"
Usage: #example

* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-practitioner"
* id = "at-emed-example-practitioner-01"
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