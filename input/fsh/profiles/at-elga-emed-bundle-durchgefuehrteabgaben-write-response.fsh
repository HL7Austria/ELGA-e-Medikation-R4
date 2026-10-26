Profile: AtElgaEmedBundleDurchgefuehrteAbgabenWriteResponse
Parent: Bundle
Id: at-elga-emed-bundle-durchgefuehrteabgaben-write-response
Title: "AT ELGA e-Medikation Transaction-Response Bundle Durchgeführte Abgaben"
Description: "Profil für die Antwort des Servers auf das Schreiben von Durchgeführten Abgaben mit der $dispense-write Operation. Das Bundle enthält die persistierten Durchgeführten Abgaben."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction-response
* type ^short = "Art des Bundles. Für die Antwort auf schreibenden Zugriff immer Typ \"transaction-response\"."

* link.url MS
* link.relation MS
* link.relation = #self

* entry 1..* MS
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry.resource 1..1 MS
* entry.resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
* entry.resource ^short = "Die persistierte Durchgeführte Abgabe"
* entry.response 1..1 MS
* entry.response.modifierExtension 0..0
* entry.response.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.response.status 1..1 MS
* entry.response.status ^short = "HTTP-Statuscode der Verarbeitung des Eintrags"
* entry.response.location 1..1 MS
* entry.response.location ^short = "Versionsspezifische URL der persistierten Durchgeführten Abgabe"
* entry.response.lastModified 1..1 MS
* entry.response.lastModified ^short = "Zeitpunkt der Persistierung"
