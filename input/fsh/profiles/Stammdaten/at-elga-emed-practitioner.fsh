Profile: AtElgaEmedPractitioner
Parent: HL7ATCorePractitioner
Id: at-elga-emed-practitioner
Title: "AT ELGA e-Medikation Practitioner"
Description: "Profil für die Struktur der Practitioner Ressource"

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

* identifier MS
* identifier[GDA-OID] 1..1 MS
* identifier[GDA-OID].use 0..0
//* identifier[GDA-OID].use ^short = "Fachliche Begründung: TODO"
* identifier[GDA-OID].system MS
* identifier[GDA-OID].value MS


* identifier[VPNR] MS
* identifier[VPNR].use 0..0
//* identifier[VPNR].use ^short = "Fachliche Begründung: TODO"
* identifier[VPNR].system MS
* identifier[VPNR].value MS

* address MS
* address.use MS
* address.line MS
* address.line.extension[street] MS
* address.line.extension[street].valueString MS
* address.line.extension[street].url MS
* address.line.extension[streetNumber] MS
* address.line.extension[streetNumber].valueString MS
* address.line.extension[streetNumber].url MS
* address.line.extension[floorDoorNumber] MS
* address.line.extension[floorDoorNumber].valueString MS
* address.line.extension[floorDoorNumber].url MS
* address.line.extension[additionalInformation] MS
* address.line.extension[additionalInformation].valueString MS
* address.line.extension[additionalInformation].url MS
* address.city MS
* address.state MS
* address.postalCode MS
* address.country MS

* name MS
* name.use 0..0
* name.family MS
* name.given MS
* name.prefix MS
* name.suffix MS