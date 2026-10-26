Profile: AtElgaEmedParametersOutPlanRead
Parent: Parameters
Id: at-elga-emed-parameters-out-plan-read
Title: "AT ELGA e-Medikation Parameters Out $plan-read"
Description: "Profil für den Rückgabewert der $plan-read Operation."

* obeys at-emed-plan-read-out-ergebnis

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und Bundle erlaubt
* parameter contains
    operationOutcome 0..* MS and
    medikationsplan 0..1 MS

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

// Medikationsplan-Bundle
* parameter[medikationsplan] ^short = "Das temporäre, für die Bearbeitung aufbereitete Medikationsplan-Bundle mit der aktuellen List-Ressource sowie sämtlichen von ihr referenzierten Ressourcen (nur bei Erfolg)"
* parameter[medikationsplan].modifierExtension 0..0
* parameter[medikationsplan].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[medikationsplan].name 1..1 MS
* parameter[medikationsplan].name = "medikationsplan"
* parameter[medikationsplan].value[x] 0..0
* parameter[medikationsplan].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[medikationsplan].resource 1..1 MS
* parameter[medikationsplan].resource only AtElgaEmedBundleMedikationsplan
* parameter[medikationsplan].part 0..0
* parameter[medikationsplan].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-plan-read-out-ergebnis
Description: "Es ist entweder das Medikationsplan-Bundle (Erfolgsfall) oder mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' (Fehlerfall) enthalten. Im Erfolgsfall dürfen OperationOutcomes nur Issues der Schwere 'information' oder 'warning' enthalten."
* severity = #error
* expression = "(parameter.resource.ofType(Bundle).exists() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').empty()) or (parameter.resource.ofType(Bundle).empty() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
