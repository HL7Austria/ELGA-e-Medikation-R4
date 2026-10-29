Profile: AtElgaEmedPatient
Parent: HL7ATCorePatient
Id: at-elga-emed-patient
Title: "AT ELGA e-Medikation Patient"
Description: "Profil für die Struktur der Patienten Ressource"

* id 1..1 MS
* id ^short = "Technische id der Ressource"
* meta MS
* meta.profile 1..1 MS
* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

* text MS
* text.status ^short = "Siehe Notes - \"Regeln für den Inhalt der narrativen Teile in den Notes\"."  
* text.div MS
* text.status MS

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."
* active 0..0
* name MS
* name.use 0..0
* name.family MS
* name.given MS
* name.prefix MS
* name.suffix MS

* deceased[x] 0..0
* link 0..0

* birthDate MS
* gender MS
* identifier MS
* identifier[bPK] 1..1 MS
* identifier[bPK].use 0..0
//* identifier[bPK].use ^short = "Fachliche Begründung: TODO"
* identifier[bPK].system MS
* identifier[bPK].value MS
* identifier[bPK].type MS
* identifier[bPK].type.coding MS
* identifier[bPK].type.coding.system MS
* identifier[bPK].type.coding.code MS
* identifier[bPK].type.coding.display MS
* identifier[bPK].type.coding.version MS

* identifier[socialSecurityNumber] MS
* identifier[socialSecurityNumber].use 0..0
//* identifier[socialSecurityNumber].use ^short = "Fachliche Begründung: TODO"
* identifier[socialSecurityNumber].system MS
* identifier[socialSecurityNumber].value MS
* identifier[socialSecurityNumber].type.coding MS
* identifier[socialSecurityNumber].type MS
* identifier[socialSecurityNumber].type.coding.system MS
* identifier[socialSecurityNumber].type.coding.code MS
* identifier[socialSecurityNumber].type.coding.display MS
* identifier[socialSecurityNumber].type.coding.version MS

* identifier[localPatientId] MS
* identifier[localPatientId].use 0..0
//* identifier[localPatientId].use ^short = "Fachliche Begründung: TODO"
* identifier[localPatientId].system MS
* identifier[localPatientId].value MS
* identifier[localPatientId].type MS
* identifier[localPatientId].type.coding MS
* identifier[localPatientId].type.coding.system MS
* identifier[localPatientId].type.coding.code MS
* identifier[localPatientId].type.coding.display MS
* identifier[localPatientId].type.coding.version MS