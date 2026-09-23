Instance: At-Emed-Example-Practitioner-02
InstanceOf: AtElgaCorePractitioner
Title: "Beispiel Apothekerin 02"
Description: "Beispiel einer Apothekerin (Dr. Apothekerin)."
Usage: #example

//* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-practitioner"
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:1.2.40.0.34.99.4613.4"
* identifier[=].assigner.display = "Bundesministerium für Gesundheit"
* identifier[+].system = "urn:oid:1.2.40.0.10.1.4.3.2"
* identifier[=].value = "987654321"
* identifier[=].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* active = true
* name.family = "Apothekerin"
* name.given = "Claudia"
* name.prefix = "Prof. Dr."
* gender = #female