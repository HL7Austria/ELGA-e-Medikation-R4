Profile: AtElgaEmedPatient
Parent: HL7ATCorePatient
Id: at-elga-emed-patient
Title: "AT ELGA e-Medikation Patient"
Description: "Profil für die Struktur der Patienten Ressource"
* name MS
* name.family MS
* name.given MS
* name.prefix MS
* name.suffix MS

* birthDate MS
* gender MS
* identifier MS
* identifier[bPK] 1..1 MS
* identifier[bPK].use 0..0
* identifier[bPK].use ^short = "Fachliche Begründung: TODO"
* identifier[bPK].system MS
* identifier[bPK].value MS
* identifier[bPK].type MS
* identifier[bPK].type.coding.system MS
* identifier[bPK].type.coding.code MS
* identifier[bPK].type.coding.display MS
* identifier[bPK].type.coding.version MS

* identifier[socialSecurityNumber] MS
* identifier[socialSecurityNumber].use 0..0
* identifier[socialSecurityNumber].use ^short = "Fachliche Begründung: TODO"
* identifier[socialSecurityNumber].system MS
* identifier[socialSecurityNumber].value MS
* identifier[socialSecurityNumber].type MS
* identifier[socialSecurityNumber].type.coding.system MS
* identifier[socialSecurityNumber].type.coding.code MS
* identifier[socialSecurityNumber].type.coding.display MS
* identifier[socialSecurityNumber].type.coding.version MS

* identifier[localPatientId] MS
* identifier[localPatientId].use 0..0
* identifier[localPatientId].use ^short = "Fachliche Begründung: TODO"
* identifier[localPatientId].system MS
* identifier[localPatientId].value MS
* identifier[localPatientId].type MS
* identifier[localPatientId].type.coding.system MS
* identifier[localPatientId].type.coding.code MS
* identifier[localPatientId].type.coding.display MS
* identifier[localPatientId].type.coding.version MS