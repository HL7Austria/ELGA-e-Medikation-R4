Profile: AtElgaEmedParametersOutReferencePlan
Parent: Parameters
Id: at-elga-emed-parameters-out-reference-plan
Title: "AT ELGA e-Medikation Parameters Out $reference-plan"
Description: "Profil für den Rückgabewert der $reference-plan Operation."

* obeys at-emed-reference-plan-out-ergebnis

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und MedicationDispense erlaubt
* parameter contains
    operationOutcome 0.. MS and
    durchgefuehrteAbgabe 0..1 MS

// OperationOutcome
* parameter[operationOutcome] ^short = "Fehler, der zur Ablehnung der Operation geführt hat (nur bei Misserfolg)"
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

// Durchgeführte Abgabe mit hinzugefügter bzw. entfernter Referenz auf den Planeintrag
* parameter[durchgefuehrteAbgabe] ^short = "Die Durchgeführte Abgabe, zu der die Referenz auf den Planeintrag hinzugefügt bzw. von der sie entfernt wurde, so wie sie nach dem Ausführen der Operation am Server persistiert ist (nur bei Erfolg)"
* parameter[durchgefuehrteAbgabe].modifierExtension 0..0
* parameter[durchgefuehrteAbgabe].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[durchgefuehrteAbgabe].name 1..1 MS
* parameter[durchgefuehrteAbgabe].name = "durchgefuehrteAbgabe"
* parameter[durchgefuehrteAbgabe].value[x] 0..0
* parameter[durchgefuehrteAbgabe].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[durchgefuehrteAbgabe].resource 1..1 MS
* parameter[durchgefuehrteAbgabe].resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
* parameter[durchgefuehrteAbgabe].part 0..0
* parameter[durchgefuehrteAbgabe].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter: entweder die Durchgeführte Abgabe oder ein OperationOutcome
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-reference-plan-out-ergebnis
Description: "Es ist entweder die Durchgeführte Abgabe (Erfolgsfall) oder mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' (Fehlerfall) enthalten."
* severity = #error
* expression = "parameter.resource.ofType(MedicationDispense).exists() or (parameter.resource.ofType(MedicationDispense).empty() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"
