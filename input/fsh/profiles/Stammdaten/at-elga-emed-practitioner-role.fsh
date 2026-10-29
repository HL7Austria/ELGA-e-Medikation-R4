Profile: AtElgaEmedPractitionerRole
Parent: HL7ATCorePractitionerRole
Id: at-elga-emed-practitionerrole
Title: "AT ELGA e-Medikation PractitionerRole"
Description: "Profil für die Struktur der PractitionerRole Ressource"

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