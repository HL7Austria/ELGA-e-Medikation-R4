Profile: AtElgaEmedParametersOutGroupIdentifierSearch
Parent: Parameters
Id: at-elga-emed-parameters-out-groupidentifier-search
Title: "AT ELGA e-Medikation Parameters Out $groupidentifier-search"
Description: "Profil für den Rückgabewert der $groupidentifier-search Operation."

* obeys at-emed-groupidentifier-search-out-ergebnis

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und Bundle erlaubt
* parameter contains
    operationOutcome 0..* MS and
    groupIdentifierSearchResult 0..1 MS

// OperationOutcome(s)
* parameter[operationOutcome] ^short = "Hinweise mit der Schwere 'information' oder 'warning' (bei Erfolg) bzw. Fehler, der zur Ablehnung der Operation geführt hat (bei Misserfolg)"
* parameter[operationOutcome].modifierExtension 0..0
* parameter[operationOutcome].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[operationOutcome].name 1..1 MS
* parameter[operationOutcome].name = "operationOutcome"
* parameter[operationOutcome].value[x] 0..0
* parameter[operationOutcome].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[operationOutcome].resource 1..1 MS
* parameter[operationOutcome].resource only AtElgaEmedOperationOutcome
* parameter[operationOutcome].part 0..0
* parameter[operationOutcome].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Searchset Bundle
* parameter[groupIdentifierSearchResult] ^short = "Bundle vom Typ 'searchset' mit den dem e-Med GroupIdentifier zugeordneten Geplanten und Durchgeführten Abgaben (nur bei Erfolg)"
* parameter[groupIdentifierSearchResult].modifierExtension 0..0
* parameter[groupIdentifierSearchResult].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[groupIdentifierSearchResult].name 1..1 MS
* parameter[groupIdentifierSearchResult].name = "groupIdentifierSearchResult"
* parameter[groupIdentifierSearchResult].value[x] 0..0
* parameter[groupIdentifierSearchResult].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[groupIdentifierSearchResult].resource 1..1 MS
* parameter[groupIdentifierSearchResult].resource only AtElgaEmedBundleGroupIdentifierSearchResult
* parameter[groupIdentifierSearchResult].part 0..0
* parameter[groupIdentifierSearchResult].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-groupidentifier-search-out-ergebnis
Description: "Es ist entweder das Bundle mit den Geplanten und Durchgeführten Abgaben (Erfolgsfall) oder mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' (Fehlerfall) enthalten. Im Erfolgsfall dürfen OperationOutcomes nur Issues der Schwere 'information' oder 'warning' enthalten."
* severity = #error
* expression = "(parameter.resource.ofType(Bundle).exists() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').empty()) or (parameter.resource.ofType(Bundle).empty() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
