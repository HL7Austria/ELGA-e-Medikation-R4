Profile: AtElgaEmedBundlegeplanteAbgabenTx
Parent: Bundle
Id: at-elga-emed-bundle-geplanteabgabentx
Title: "AT ELGA e-Medikation Transaction Bundle geplante Abgaben"
Description: "Das Bundle vom Typ Transaction dient dem schreibenden Zugriff und besteht aus allen geplanten Abgaben, 
die gemeinsam geschrieben werden sollen. Es müssen entweder alle oder keine der geplanten Abgaben einen groupIdentifier enthalten. 
Ist kein groupIdentifier enthalten so erhalten alle geplanten Abgaben im Transaction Bundle einen neuen gemeinsamen groupIdentifier."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."
 
* timestamp 1..1 MS
* timestamp ^short = "Zeitpunkt der Erstellung des Bundles."

* link 0..0

* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erstes Entry soll die Liste sein
* entry contains 
    geplanteAbgaben 1..*
* entry[geplanteAbgaben].resource 1..1
* entry[geplanteAbgaben].resource only AtElgaEmedMedicationRequestGeplanteAbgabe
* entry[geplanteAbgaben].link 0..0
* entry[geplanteAbgaben].fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry[geplanteAbgaben].request.method = #POST
* entry[geplanteAbgaben].request.url = "MedicationRequest"

//TODO Invariante: entweder alle geplanten Abgaben haben einen groupIdentifier oder keine