Profile: AtElgaEmedDeviceFachanwendung
Parent: Device
Id: at-elga-emed-device-fachanwendung
Title: "At ELGA e-Medikation Device Fachanwendung"
Description: "Das Device, welches die eMed Fachanwendung abbildet"
* status = #active
* status 1..1 MS
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

