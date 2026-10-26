Profile: AtElgaEmedPractitioner
Parent: HL7ATCorePractitioner
Id: at-elga-emed-practitioner
Title: "AT ELGA e-Medikation Practitioner"
Description: "Profil für die Struktur der Practitioner Ressource"
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

* address MS
* address.use MS
* address.line MS
* address.line.extension[street].valueString MS
* address.line.extension[street].url MS
* address.line.extension[streetNumber].valueString MS
* address.line.extension[streetNumber].url MS
* address.line.extension[floorDoorNumber].valueString MS
* address.line.extension[floorDoorNumber].url MS
* address.line.extension[additionalInformation].valueString MS
* address.line.extension[additionalInformation].url MS
* address.city MS
* address.state MS
* address.postalCode MS
* address.country MS

* name MS
* name.family MS
* name.given MS
* name.prefix MS
* name.suffix MS