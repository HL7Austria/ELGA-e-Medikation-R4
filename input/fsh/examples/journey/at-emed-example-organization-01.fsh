Instance: At-Emed-Example-Organization-01
InstanceOf: AtElgaEmedOrganization
Title: "Beispiel Organisation Hausärztin"
Description: "Beispiel Organisation: Ordination einer Hausärztin."
Usage: #example

* identifier[GDA-OID].system = "urn:ietf:rfc:3986"
* identifier[GDA-OID].value = "urn:oid:1.2.40.0.34.99.4613.1"
* identifier[GDA-OID].assigner.display = "Bundesministerium für Gesundheit"
* contact.address.use = #work
* contact.address.type = #both
* contact.address.line = "Hausarzt-Straße 8 Stiege 2"
* contact.address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* contact.address.line.extension[=].valueString = "Hausarzt-Straße"
* contact.address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* contact.address.line.extension[=].valueString = "8"
* contact.address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-additionalLocator"
* contact.address.line.extension[=].valueString = "Stiege 2"
* contact.address.line.extension[+].url = "https://fhir.hl7.at/core/r4/StructureDefinition/at-core-ext-address-additionalInformation"
* contact.address.line.extension[=].valueString = "Barrierefreier Zugang"
* contact.address.city = "St. Wolfgang"
* contact.address.state = "Salzburg"
* contact.address.postalCode = "5350"
* contact.address.country = "AUT"