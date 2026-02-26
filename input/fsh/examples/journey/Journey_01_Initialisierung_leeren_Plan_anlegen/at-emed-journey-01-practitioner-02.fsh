Instance: At-Emed-Journey-01-Practitioner-02
InstanceOf: HL7ATCorePractitioner
Title: "Beispiel Ärztin 02"
Description: "Beispiel einer ursprünglich eine Medikation verordnenden Ärztin (Fremdmedikation)."
Usage: #example

//* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-practitioner"
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:1.2.40.0.34.99.4613.4"
* identifier[=].assigner.display = "Bundesministerium für Gesundheit"
* identifier[+].system = "urn:oid:1.2.40.0.10.1.4.3.2"
* identifier[=].value = "987654322"
* identifier[=].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* active = true
* name.family = "Fremdmedikation"
* name.given = "Hermine"
* name.prefix = "Prof. Dr."
* telecom[0].system = #email
* telecom[=].value = "office@fremdmedikation.at"
* telecom[=].use = #work
* telecom[+].system = #phone
* telecom[=].value = "+436500987654399"
* telecom[=].use = #work
* address.use = #work
* address.type = #both
* address.line = "Hauptstraße 7 Stiege 1"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Hauptstraße"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "7"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-additionalLocator"
* address.line.extension[=].valueString = "Stiege 1"
* address.line.extension[+].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-address-additionalInformation"
* address.line.extension[=].valueString = "Barrierefreier Zugang"
* address.city = "Unterstinkenbrunn"
* address.state = "Niederösterreich"
* address.postalCode = "2154"
* address.country = "AUT"
* gender = #female