Profile: AtElgaEmedOrganization
Parent: HL7ATCoreOrganization
Id: at-elga-emed-organization
Title: "AT ELGA e-Medikation Organization"
Description: "Profil für die Struktur von Organisationen"

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

* identifier MS
* identifier[GDA-OID] 1..1 MS
* identifier[GDA-OID].use 0..0
* identifier[GDA-OID].use ^short = "Fachliche Begründung: TODO"
* identifier[GDA-OID].system MS
* identifier[GDA-OID].value MS

* identifier[VPNR] MS
* identifier[VPNR].use 0..0
* identifier[VPNR].use ^short = "Fachliche Begründung: TODO"
* identifier[VPNR].system MS
* identifier[VPNR].value MS

* identifier[VKZ] MS
* identifier[VKZ].use 0..0
* identifier[VKZ].use ^short = "Fachliche Begründung: TODO"
* identifier[VKZ].system MS
* identifier[VKZ].value MS

* identifier[KANR] MS
* identifier[KANR].use 0..0
* identifier[KANR].use ^short = "Fachliche Begründung: TODO"
* identifier[KANR].system MS
* identifier[KANR].value MS

* type MS
* type.coding 1..1 MS
* type.coding.code 1..1 MS
* type.coding.system 1..1 MS
* type.coding.display MS
* type.coding.version MS
* type.text 0..0
* type.text ^short = "Fachliche Begründung: TODO"

* contact MS
* contact.modifierExtension 0..0
* contact.modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* contact.address MS
* contact.address.use MS
* contact.address.line MS
* contact.address.line.extension[street] MS
* contact.address.line.extension[street].valueString MS
* contact.address.line.extension[street].url MS
* contact.address.line.extension[streetNumber] MS
* contact.address.line.extension[streetNumber].valueString MS
* contact.address.line.extension[streetNumber].url MS
* contact.address.line.extension[floorDoorNumber] MS
* contact.address.line.extension[floorDoorNumber].valueString MS
* contact.address.line.extension[floorDoorNumber].url MS
* contact.address.line.extension[additionalInformation] MS
* contact.address.line.extension[additionalInformation].valueString MS
* contact.address.line.extension[additionalInformation].url MS
* contact.address.city MS
* contact.address.state MS
* contact.address.postalCode MS
* contact.address.country MS