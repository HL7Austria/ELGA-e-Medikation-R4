Alias: $iso-3166-1-alpha-3 = https://termgit.elga.gv.at/CodeSystem/iso-3166-1-alpha-3
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Instance: At-Emed-Example-Patient-01
InstanceOf: AtElgaEmedPatient
Title: "Beispiel Patient 01"
Description: "Beispiel eines Patienten (Anton Mustermann)."
Usage: #example
* identifier[socialSecurityNumber].type = $v2-0203#SS "Social Security number"
* identifier[socialSecurityNumber].system = "urn:oid:1.2.40.0.10.1.4.3.1"
* identifier[socialSecurityNumber].value = "1234010100"
* identifier[socialSecurityNumber].assigner.display = "Dachverband der österreichischen Sozialversicherungsträger"
* identifier[bPK].type = $v2-0203#NI "National unique individual identifier"
* identifier[bPK].system = "urn:oid:1.2.40.0.10.2.1.1.149"
* identifier[bPK].value = "GH:oeLdSEb0l+8kSdJWjOYyYmnYki0="
* identifier[bPK].assigner.display = "Bundesministerium für Inneres"
* identifier[localPatientId].type = $v2-0203#PI "Patient internal identifier"
* identifier[localPatientId].system = "urn:oid:1.2.3.4.5"
* identifier[localPatientId].value = "0815"
* identifier[localPatientId].assigner.display = "Ein GDA in Österreich"
* name.family = "Mustermann"
* name.given = "Anton"
* name.prefix = "DI"
* gender = #male
* birthDate = "1900-01-01"