Profile: AtElgaEmedParametersOutPrescriptionWrite
Parent: Parameters
Id: at-elga-emed-parameters-out-prescription-write
Title: "AT ELGA e-Medikation Parameters Out $prescription-write"
Description: "Profil für den Rückgabewert der $prescription-write Operation."

* obeys at-emed-prescription-write-out-ergebnis

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und Bundle erlaubt
* parameter contains
    operationOutcome 0..* MS and
    geplanteAbgaben 0..1 MS

// OperationOutcome(s)
* parameter[operationOutcome] ^short = "Hinweise zu ignorierten Must-Support Elementen (bei Erfolg) bzw. Fehler, der zur Ablehnung der Operation geführt hat (bei Misserfolg)"
* parameter[operationOutcome].modifierExtension 0..0
* parameter[operationOutcome].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[operationOutcome].name 1..1 MS
* parameter[operationOutcome].name = "operationOutcome"
* parameter[operationOutcome].value[x] 0..0
* parameter[operationOutcome].resource 1..1 MS
* parameter[operationOutcome].resource only AtElgaEmedOperationOutcome
* parameter[operationOutcome].part 0..0

// Transaction-Response Bundle
* parameter[geplanteAbgaben] ^short = "Transaction-Response Bundle mit den persistierten Geplanten Abgaben (nur bei Erfolg)"
* parameter[geplanteAbgaben].modifierExtension 0..0
* parameter[geplanteAbgaben].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[geplanteAbgaben].name 1..1 MS
* parameter[geplanteAbgaben].name = "geplanteAbgaben"
* parameter[geplanteAbgaben].value[x] 0..0
* parameter[geplanteAbgaben].resource 1..1 MS
* parameter[geplanteAbgaben].resource only AtElgaEmedBundleGeplanteAbgabenWriteResponse
* parameter[geplanteAbgaben].part 0..0

// Allgemeine Regeln für alle Parameter
* parameter 1..* MS

Invariant: at-emed-prescription-write-out-ergebnis
Description: "Ist kein Bundle mit persistierten Geplanten Abgaben enthalten (Fehlerfall), muss mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' enthalten sein."
* severity = #error
* expression = "parameter.resource.ofType(Bundle).exists() or (parameter.resource.ofType(OperationOutcome).count() >= 1 and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
