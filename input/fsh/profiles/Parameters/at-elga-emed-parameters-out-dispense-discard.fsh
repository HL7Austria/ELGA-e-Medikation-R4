Profile: AtElgaEmedParametersOutDispenseDiscard
Parent: Parameters
Id: at-elga-emed-parameters-out-dispense-discard
Title: "AT ELGA e-Medikation Parameters Out $dispense-discard"
Description: "Profil für den Rückgabewert der $dispense-discard Operation."

* obeys at-emed-dispense-discard-out-ergebnis and at-emed-dispense-discard-out-geplanteabgabe and at-emed-dispense-discard-out-geplanteabgabe-status

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* parameter ^slicing.discriminator[+].type = #type
* parameter ^slicing.discriminator[=].path = "resource"
* parameter ^slicing.rules = #closed  // als Parameter sind nur OperationOutcome, MedicationDispense und MedicationRequest erlaubt
* parameter contains
    operationOutcome 0..1 MS and
    durchgefuehrteAbgabe 0..1 MS and
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

// Stornierte Durchgeführte Abgabe
* parameter[durchgefuehrteAbgabe] ^short = "Die stornierte Durchgeführte Abgabe, so wie sie nach dem Ausführen der Operation am Server persistiert ist (nur bei Erfolg)"
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

// Durch die Stornierung in ihrem Status geänderte Geplante Abgabe
* parameter[geplanteAbgabe] ^short = "Die zugehörige Geplante Abgabe, sofern ihr Status durch die Stornierung der Durchgeführten Abgabe geändert wurde (z.B. completed oder cancelled -> active), so wie sie nach dem Ausführen der Operation am Server persistiert ist (nur bei Erfolg)"
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

// Allgemeine Regeln für alle Parameter: entweder die stornierte Durchgeführte Abgabe (ggf. mit der Geplanten Abgabe) oder ein OperationOutcome
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-dispense-discard-out-ergebnis
Description: "Es ist entweder die stornierte Durchgeführte Abgabe (Erfolgsfall) oder mindestens ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' (Fehlerfall) enthalten."
* severity = #error
* expression = "parameter.resource.ofType(MedicationDispense).exists()  or (parameter.resource.ofType(MedicationDispense).empty() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"

Invariant: at-emed-dispense-discard-out-geplanteabgabe
Description: "Eine Geplante Abgabe darf nur enthalten sein, wenn auch die stornierte Durchgeführte Abgabe enthalten ist."
* severity = #error
* expression = "parameter.resource.ofType(MedicationRequest).exists() implies parameter.resource.ofType(MedicationDispense).exists()"

Invariant: at-emed-dispense-discard-out-geplanteabgabe-status
Description: "Ist eine Geplante Abgabe enthalten, wurde sie durch die Stornierung der Durchgeführten Abgabe wieder aktiviert und muss daher den Status 'active' haben."
* severity = #error
* expression = "parameter.resource.ofType(MedicationRequest).all(status = 'active')"
