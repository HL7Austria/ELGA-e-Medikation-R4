Profile: AtElgaEmedBundleGeplanteAbgabenTx
Parent: Bundle
Id: at-elga-emed-bundle-geplanteabgaben-tx
Title: "AT ELGA e-Medikation Transaction Bundle Geplante Abgaben"
Description: "Das Bundle vom Typ Transaction dient dem schreibenden Zugriff und besteht aus allen geplanten Abgaben, 
die gemeinsam geschrieben werden sollen. Es müssen entweder alle oder keine der geplanten Abgaben einen groupIdentifier enthalten. 
Ist kein groupIdentifier enthalten so erhalten alle geplanten Abgaben im Transaction Bundle einen neuen gemeinsamen groupIdentifier."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."

* entry MS
//* entry.modifierExtension 0..0
//* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry ^slicing.discriminator[+].type = #type
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed
* entry contains 
    geplanteAbgaben 1..* MS
* entry[geplanteAbgaben].modifierExtension 0..0
* entry[geplanteAbgaben].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[geplanteAbgaben].fullUrl 1..1 MS
* entry[geplanteAbgaben].fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
* entry[geplanteAbgaben].request 1..1 MS
* entry[geplanteAbgaben].request.modifierExtension 0..0
* entry[geplanteAbgaben].request.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[geplanteAbgaben].request.method 1..1 MS
* entry[geplanteAbgaben].request.method = $cs-http-codes#POST
* entry[geplanteAbgaben].request.url 1..1 MS
* entry[geplanteAbgaben].request.url = "MedicationRequest"
* entry[geplanteAbgaben].resource only AtElgaEmedMedicationRequestGeplanteAbgabe
* entry[geplanteAbgaben].resource 1..1 MS

* entry obeys at-emed-geplante-abgaben-group-identifier-einheitlich

Invariant: at-emed-geplante-abgaben-group-identifier-einheitlich
Description: "Entweder müssen alle geplanten Abgaben einen groupIdentifier enthalten oder keine."
* severity = #error
* expression = "resource.ofType(MedicationRequest).groupIdentifier.exists().not() or resource.ofType(MedicationRequest).groupIdentifier.exists().count() = resource.ofType(MedicationRequest).count()"