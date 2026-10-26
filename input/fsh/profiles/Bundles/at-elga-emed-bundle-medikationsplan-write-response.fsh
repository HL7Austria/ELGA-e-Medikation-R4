Profile: AtElgaEmedBundleMedikationsplanWriteResponse
Parent: Bundle
Id: at-elga-emed-bundle-medikationsplan-write-response
Title: "AT ELGA e-Medikation Transaction-Response Bundle Medikationsplan"
Description: "Profil für die Antwort des Servers auf das Schreiben des Medikationsplans mit der $plan-write Operation. Das Bundle enthält den persistierten Medikationsplan sowie die persistierten Medikationsplaneinträge."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction-response
* type ^short = "Art des Bundles. Für die Antwort auf schreibenden Zugriff immer Typ \"transaction-response\"."

* link.url MS
* link.relation MS
* link.relation = #self

* entry ^slicing.discriminator[+].type = #type
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erster Entry soll die Liste sein
* entry contains
    Medikationsplan 1..1 MS and
    Medikationsplaneintrag 0..* MS
// Liste
* entry[Medikationsplan].resource only AtElgaEmedListMedikationsplan
* entry[Medikationsplan].resource ^short = "Der persistierte Medikationsplan"
// Medikationsplaneinträge
* entry[Medikationsplaneintrag].resource only AtElgaEmedMedicationRequestPlaneintrag
* entry[Medikationsplaneintrag].resource ^short = "Ein persistierter Medikationsplaneintrag"

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ
* entry 1..* MS
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry.resource 1..1 MS
* entry.response 1..1 MS
* entry.response.modifierExtension 0..0
* entry.response.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry.response.status 1..1 MS
* entry.response.status ^short = "HTTP-Statuscode der Verarbeitung des Eintrags"
* entry.response.location 1..1 MS
* entry.response.location ^short = "Versionsspezifische URL der persistierten Ressource"
* entry.response.lastModified 1..1 MS
* entry.response.lastModified ^short = "Zeitpunkt der Persistierung"

