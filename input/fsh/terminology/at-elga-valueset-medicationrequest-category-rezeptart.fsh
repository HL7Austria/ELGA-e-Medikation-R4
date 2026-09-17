//TODO this is a copy of the information on termgit.elga.gv.at

Instance: medikationrezeptart 
InstanceOf: CodeSystem 
Usage: #definition 
* id = "medikationrezeptart" 
* url = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart" 
* name = "medikationrezeptart" 
* title = "MedikationRezeptart" 
* status = #active 
* content = #complete 
* version = "1.0.0+20230131" 
* description = "**Description:** ELGA Codelist for Prescription type

**Beschreibung:** ELGA Codeliste für RezeptArt" 
* identifier[0].use = #official 
* identifier[0].system = "urn:ietf:rfc:3986" 
* identifier[0].value = "urn:oid:1.2.40.0.10.1.4.3.4.3.3" 
* date = "2015-03-31" 
* count = 3 
* concept[0].code = #KASSEN
* concept[0].display = "Kassenrezept"
* concept[1].code = #PRIVAT
* concept[1].display = "Privatrezept"
* concept[2].code = #SUBST
* concept[2].display = "Substitutionsrezept"



Instance: elga-medikationrezeptart 
InstanceOf: ValueSet 
Usage: #definition 
* id = "elga-medikationrezeptart" 
* meta.profile[0] = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-valueset" 
* url = "https://termgit.elga.gv.at/ValueSet/elga-medikationrezeptart" 
* name = "elga-medikationrezeptart" 
* title = "ELGA_MedikationRezeptart" 
* status = #active 
* version = "1.1.0+20240325" 
* description = "**Description:** ELGA ValueSet for Prescription type

**Beschreibung:** ELGA ValueSet für RezeptArt" 
* identifier[0].use = #official 
* identifier[0].system = "urn:ietf:rfc:3986" 
* identifier[0].value = "urn:oid:1.2.40.0.34.10.68" 
* date = "2024-03-25" 
* compose.include[0].extension[0].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid"
* compose.include[0].extension[0].valueOid = "urn:oid:1.2.40.0.10.1.4.3.4.3.3"
* compose.include[0].system = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart"
* compose.include[0].version = "1.0.0+20230131"
* compose.include[0].concept[0].code = #KASSEN
* compose.include[0].concept[0].display = "Kassenrezept"
* compose.include[0].concept[1].code = #PRIVAT
* compose.include[0].concept[1].display = "Privatrezept"
* compose.include[0].concept[2].code = #SUBST
* compose.include[0].concept[2].display = "Substitutionsrezept"

* expansion.timestamp = "2024-03-25T06:36:54.0000Z"

* expansion.contains[0].system = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart"
* expansion.contains[0].version = "1.0.0+20230131"
* expansion.contains[0].code = #KASSEN
* expansion.contains[0].display = "Kassenrezept"
* expansion.contains[0].extension[0].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid"
* expansion.contains[0].extension[0].valueOid = "urn:oid:1.2.40.0.10.1.4.3.4.3.3"
* expansion.contains[1].system = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart"
* expansion.contains[1].version = "1.0.0+20230131"
* expansion.contains[1].code = #PRIVAT
* expansion.contains[1].display = "Privatrezept"
* expansion.contains[1].extension[0].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid"
* expansion.contains[1].extension[0].valueOid = "urn:oid:1.2.40.0.10.1.4.3.4.3.3"
* expansion.contains[2].system = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart"
* expansion.contains[2].version = "1.0.0+20230131"
* expansion.contains[2].code = #SUBST
* expansion.contains[2].display = "Substitutionsrezept"
* expansion.contains[2].extension[0].url = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid"
* expansion.contains[2].extension[0].valueOid = "urn:oid:1.2.40.0.10.1.4.3.4.3.3"