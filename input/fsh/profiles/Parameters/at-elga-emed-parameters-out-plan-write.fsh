Profile: AtElgaEmedParametersOutPlanWrite
Parent: Parameters
Id: at-elga-emed-parameters-out-plan-write
Title: "AT ELGA e-Medikation Parameters Out $plan-write"
Description: "Profil für den Rückgabewert der $plan-write Operation."

* obeys at-emed-plan-write-out-ergebnis

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und Bundle erlaubt
* parameter contains
    operationOutcome 0..* MS and
    medikationsplan 0..1 MS

// OperationOutcome(s)
* parameter[operationOutcome] ^short = "Hinweise zu ignorierten Must-Support Elementen (bei Erfolg) bzw. Fehler, der zur Ablehnung der Operation geführt hat (bei Misserfolg)"
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

// Transaction-Response Bundle
* parameter[medikationsplan] ^short = "Transaction-Response Bundle mit dem persistierten Medikationsplan und den persistierten Medikationsplaneinträgen (nur bei Erfolg)"
* parameter[medikationsplan].modifierExtension 0..0
* parameter[medikationsplan].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[medikationsplan].name 1..1 MS
* parameter[medikationsplan].name = "medikationsplan"
* parameter[medikationsplan].value[x] 0..0
* parameter[medikationsplan].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[medikationsplan].resource 1..1 MS
* parameter[medikationsplan].resource only AtElgaEmedBundleMedikationsplanWriteResponse
* parameter[medikationsplan].part 0..0
* parameter[medikationsplan].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-plan-write-out-ergebnis
Description: "Ist kein Bundle mit dem persistierten Medikationsplan enthalten (Fehlerfall), muss mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' enthalten sein."
* severity = #error
* expression = "parameter.resource.ofType(Bundle).exists() or (parameter.resource.ofType(OperationOutcome).count() >= 1 and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
