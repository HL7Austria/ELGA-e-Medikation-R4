Instance: At-Emed-Example-Practitioner-02
InstanceOf: AtElgaEmedPractitioner
Title: "Beispiel Apothekerin 02"
Description: "Beispiel einer Apothekerin (Dr. Apothekerin)."
Usage: #example

//* meta.profile = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-practitioner"
* identifier[GDA-OID].system = "urn:ietf:rfc:3986"
* identifier[GDA-OID].value = "urn:oid:1.2.40.0.34.99.4613.2"
* identifier[GDA-OID].assigner.display = "Bundesministerium für Gesundheit"
* identifier[VPNR].system = "urn:oid:1.2.40.0.10.1.4.3.2"
* identifier[VPNR].value = "987654321"
* identifier[VPNR].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* active = true
* name.family = "Apothekerin"
* name.given = "Claudia"
* name.prefix = "Prof. Dr."
* gender = #female