Instance: At-Emed-Example-Organization-01
InstanceOf: HL7ATCoreOrganization
Title: "Beispiel Organisation Hausärztin"
Description: "Beispiel Organisation: Ordination einer Hausärztin."
Usage: #example

* telecom[0].system = #email
* telecom[=].value = "office@musterpraxis.at"
* telecom[=].use = #work
* telecom[+].system = #phone
* telecom[=].value = "+436500987654321"
* telecom[=].use = #work
* address.use = #work
* address.type = #both
* address.line = "Hausarzt-Straße 8 Stiege 2"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Hausarzt-Straße"
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