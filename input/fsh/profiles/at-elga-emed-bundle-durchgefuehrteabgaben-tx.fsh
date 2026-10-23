Profile: AtElgaEmedBundleDurchgefuehrteAbgabenTx
Parent: Bundle
Id: at-elga-emed-bundle-durchgefuehrteabgaben-tx
Title: "AT ELGA e-Medikation Transaction Bundle durchgeführte Abgaben"
Description: "Profil für das Schreiben des Medikationsplans mit der $dispense-write Operation."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."

* entry MS
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur MedicationDispense erlaubt
* entry contains 
    durchgefuehrteAbgaben 1..* MS
* entry[durchgefuehrteAbgaben].modifierExtension 0..0
* entry[durchgefuehrteAbgaben].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[durchgefuehrteAbgaben].fullUrl 1..1 MS
* entry[durchgefuehrteAbgaben].fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry[durchgefuehrteAbgaben].request 1..1 MS
* entry[durchgefuehrteAbgaben].request.modifierExtension 0..0
* entry[durchgefuehrteAbgaben].request.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[durchgefuehrteAbgaben].request.method 1..1 MS
* entry[durchgefuehrteAbgaben].request.method = $cs-http-codes#POST
* entry[durchgefuehrteAbgaben].request.url 1..1 MS
* entry[durchgefuehrteAbgaben].request.url = "MedicationDispense"
* entry[durchgefuehrteAbgaben].resource 1..1
* entry[durchgefuehrteAbgaben].resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe