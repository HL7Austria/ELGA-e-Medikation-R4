Profile: AtElgaEmedOrganization
Parent: HL7ATCoreOrganization
Id: at-elga-emed-organization

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
* contact.address MS
* contact.address.use MS
* contact.address.line MS
* contact.address.line.extension[street].valueString MS
* contact.address.line.extension[street].url MS
* contact.address.line.extension[streetNumber].valueString MS
* contact.address.line.extension[streetNumber].url MS
* contact.address.line.extension[floorDoorNumber].valueString MS
* contact.address.line.extension[floorDoorNumber].url MS
* contact.address.line.extension[additionalInformation].valueString MS
* contact.address.line.extension[additionalInformation].url MS
* contact.address.city MS
* contact.address.state MS
* contact.address.postalCode MS
* contact.address.country MS