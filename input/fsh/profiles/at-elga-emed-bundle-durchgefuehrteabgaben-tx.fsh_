Profile: AtElgaEmedBundleDurchgefuehrteAbgabenTx
Parent: Bundle
Id: at-elga-emed-bundle-durchgefuehrteabgaben-tx
Title: "AT ELGA e-Medikation Transaction Bundle durchgeführte Abgaben"
Description: "Das Bundle vom Typ Transaction dient dem schreibenden Zugriff und besteht aus allen Durchgeführten Abgaben, 
die gemeinsam geschrieben werden sollen."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."
 
* timestamp 1..1 MS
* timestamp ^short = "Zeitpunkt der Erstellung des Bundles."

* link 0..0

* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur MedicationDispense erlaubt
* entry contains 
    durchgefuehrteAbgaben 1..*
* entry[durchgefuehrteAbgaben].resource 1..1
* entry[durchgefuehrteAbgaben].resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
* entry[durchgefuehrteAbgaben].link 0..0
* entry[durchgefuehrteAbgaben].fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry[durchgefuehrteAbgaben].request.method = #POST
* entry[durchgefuehrteAbgaben].request.url = "MedicationDispense"

//TODO Invariante?