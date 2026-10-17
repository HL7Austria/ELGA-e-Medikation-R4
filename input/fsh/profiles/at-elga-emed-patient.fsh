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

* identifier[socialSecurityNumber] MS
* identifier[socialSecurityNumber].use 0..0
* identifier[socialSecurityNumber].use ^short = "Fachliche Begründung: TODO"
* identifier[socialSecurityNumber].system MS
* identifier[socialSecurityNumber].value MS

* identifier[localPatientId] MS
* identifier[localPatientId].use 0..0
* identifier[localPatientId].use ^short = "Fachliche Begründung: TODO"
* identifier[localPatientId].system MS
* identifier[localPatientId].value MS