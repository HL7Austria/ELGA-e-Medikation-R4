Profile: AtElgaEmedParametersOutDispenseWrite
Parent: Parameters
Id: at-elga-emed-parameters-out-dispense-write
Title: "AT ELGA e-Medikation Parameters Out $dispense-write"
Description: "Profil für den Rückgabewert der $dispense-write Operation."

* obeys at-emed-dispense-write-out-ergebnis

* parameter 1..* MS
* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und Bundle erlaubt
* parameter contains
    operationOutcome 0..* MS and
    durchgefuehrteAbgaben 0..1 MS

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
* parameter[durchgefuehrteAbgaben] ^short = "Transaction-Response Bundle mit den persistierten Durchgeführten Abgaben (nur bei Erfolg)"
* parameter[durchgefuehrteAbgaben].modifierExtension 0..0
* parameter[durchgefuehrteAbgaben].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[durchgefuehrteAbgaben].name 1..1 MS
* parameter[durchgefuehrteAbgaben].name = "durchgefuehrteAbgaben"
* parameter[durchgefuehrteAbgaben].value[x] 0..0
* parameter[durchgefuehrteAbgaben].resource 1..1 MS
* parameter[durchgefuehrteAbgaben].resource only AtElgaEmedBundleDurchgefuehrteAbgabenWriteResponse
* parameter[durchgefuehrteAbgaben].part 0..0

Invariant: at-emed-dispense-write-out-ergebnis
Description: "Ist kein Bundle mit persistierten Durchgeführten Abgaben enthalten (Fehlerfall), muss mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' enthalten sein."
* severity = #error
* expression = "parameter.resource.ofType(Bundle).exists() or (parameter.resource.ofType(OperationOutcome).count() >= 1 and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
