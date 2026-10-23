Profile: AtElgaEmedPractitionerRole
Parent: HL7ATCorePractitionerRole
Id: at-elga-emed-practitionerrole
Title: "AT ELGA e-Medikation PractitionerRole"
Description: "Profil für die Struktur der PractitionerRole Ressource"

* practitioner MS
* practitioner only Reference(AtElgaEmedPractitioner)
* practitioner.reference MS
* organization only Reference(AtElgaEmedOrganization)
* organization MS
* organization.reference MS

* code 1..1 MS
* code.coding 1..1 MS
* code.coding.code 1..1 MS
* code.coding.system 1..1 MS
* code.coding.display MS
* code.coding.version MS
* code.text 0..0