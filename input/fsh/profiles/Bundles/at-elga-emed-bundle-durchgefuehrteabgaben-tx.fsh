Profile: AtElgaEmedBundleDurchgefuehrteAbgabenTx
Parent: Bundle
Id: at-elga-emed-bundle-durchgefuehrteabgaben-tx
Title: "AT ELGA e-Medikation Transaction Bundle Durchgeführte Abgaben"
Description: "Profil für das Schreiben der Durchgeführten Abgaben mit der $dispense-write Operation."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."

* entry 1..* MS
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry.request 1..1 MS
* entry.request.modifierExtension 0..0
* entry.request.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.request.method 1..1 MS
* entry.request.method = $cs-http-codes#POST
* entry.request.url 1..1 MS
* entry.request.url = "MedicationDispense"
* entry.resource 1..1
* entry.resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe