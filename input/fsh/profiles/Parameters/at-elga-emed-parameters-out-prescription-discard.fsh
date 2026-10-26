Profile: AtElgaEmedParametersOutPrescriptionDiscard
Parent: Parameters
Id: at-elga-emed-parameters-out-prescription-discard
Title: "AT ELGA e-Medikation Parameters Out $prescription-discard"
Description: "Profil für den Rückgabewert der $prescription-discard Operation."

* obeys at-emed-prescription-discard-out-ergebnis

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome und MedicationRequest erlaubt
* parameter contains
    operationOutcome 0..1 MS and
    geplanteAbgabe 0..1 MS

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

// Stornierte Geplante Abgabe
* parameter[geplanteAbgabe] ^short = "Die stornierte Geplante Abgabe, so wie sie nach dem Ausführen der Operation am Server persistiert ist (nur bei Erfolg)"
* parameter[geplanteAbgabe].modifierExtension 0..0
* parameter[geplanteAbgabe].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[geplanteAbgabe].name 1..1 MS
* parameter[geplanteAbgabe].name = "geplanteAbgabe"
* parameter[geplanteAbgabe].value[x] 0..0
* parameter[geplanteAbgabe].value[x] ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich eine Ressource, ein Wert ist nicht vorgesehen."
* parameter[geplanteAbgabe].resource 1..1 MS
* parameter[geplanteAbgabe].resource only AtElgaEmedMedicationRequestGeplanteAbgabe
* parameter[geplanteAbgabe].part 0..0
* parameter[geplanteAbgabe].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter: entweder die stornierte Geplante Abgabe oder ein OperationOutcome
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-prescription-discard-out-ergebnis
Description: "Ist keine stornierte Geplante Abgabe enthalten (Fehlerfall), muss ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' enthalten sein."
* severity = #error
* expression = "parameter.resource.ofType(MedicationRequest).exists() or parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists()"
