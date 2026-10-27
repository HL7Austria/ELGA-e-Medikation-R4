Profile: AtElgaEmedParametersOutGroupIdentifierCreate
Parent: Parameters
Id: at-elga-emed-parameters-out-groupidentifier-create
Title: "AT ELGA e-Medikation Parameters Out $groupidentifier-create"
Description: "Profil für den Rückgabewert der $groupidentifier-create Operation."

* obeys at-emed-groupidentifier-create-out-ergebnis and at-emed-groupidentifier-create-out-datamatrixcode

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

// Da neben einer Ressource (OperationOutcome) auch einfache Werte (string, Attachment) zurückgegeben werden, wird über den Namen des Parameters unterschieden
* parameter ^slicing.discriminator[+].type = #value
* parameter ^slicing.discriminator[=].path = "name"
* parameter ^slicing.rules = #closed  // als Parameter sind nur groupIdentifier, dataMatrixCode und OperationOutcome erlaubt
* parameter contains
    operationOutcome 0..1 MS and
    groupIdentifier 0..1 MS and
    dataMatrixCode 0..1 MS

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

// Neu erzeugter e-Med GroupIdentifier
* parameter[groupIdentifier] ^short = "Der neu erzeugte e-Med GroupIdentifier (nur bei Erfolg)"
* parameter[groupIdentifier].modifierExtension 0..0
* parameter[groupIdentifier].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[groupIdentifier].name 1..1 MS
* parameter[groupIdentifier].name = "groupIdentifier"
* parameter[groupIdentifier].value[x] 1..1 MS
* parameter[groupIdentifier].value[x] only string
* parameter[groupIdentifier].resource 0..0
* parameter[groupIdentifier].resource ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich einen Wert, eine Ressource ist nicht vorgesehen."
* parameter[groupIdentifier].part 0..0
* parameter[groupIdentifier].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// DataMatrix-Code des e-Med GroupIdentifiers
* parameter[dataMatrixCode] ^short = "Der DataMatrix-Code, der den neu erzeugten e-Med GroupIdentifier codiert (nur bei Erfolg)"
* parameter[dataMatrixCode].modifierExtension 0..0
* parameter[dataMatrixCode].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter[dataMatrixCode].name 1..1 MS
* parameter[dataMatrixCode].name = "dataMatrixCode"
* parameter[dataMatrixCode].value[x] 1..1 MS
* parameter[dataMatrixCode].value[x] only Attachment
* parameter[dataMatrixCode].valueAttachment.contentType 1..1 MS
// TODO fixen contentType festlegen
* parameter[dataMatrixCode].valueAttachment.contentType = #image/png
* parameter[dataMatrixCode].valueAttachment.data 1..1 MS
* parameter[dataMatrixCode].resource 0..0
* parameter[dataMatrixCode].resource ^short = "Fachliche Begründung: Der Parameter transportiert ausschließlich einen Wert, eine Ressource ist nicht vorgesehen."
* parameter[dataMatrixCode].part 0..0
* parameter[dataMatrixCode].part ^short = "Fachliche Begründung: Verschachtelte Parameter sind nicht vorgesehen."

// Allgemeine Regeln für alle Parameter
* parameter 1.. MS
* parameter.modifierExtension 0..0
* parameter.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* parameter.name MS

Invariant: at-emed-groupidentifier-create-out-ergebnis
Description: "Es ist entweder der neu erzeugte e-Med GroupIdentifier (Erfolgsfall) oder ein OperationOutcome mit einem Issue der Schwere 'error' oder 'fatal' (Fehlerfall) enthalten, nicht beides."
* severity = #error
* expression = "(parameter.where(name = 'groupIdentifier').exists() and parameter.resource.ofType(OperationOutcome).empty()) or (parameter.where(name = 'groupIdentifier').empty() and parameter.resource.ofType(OperationOutcome).issue.where(severity = 'error' or severity = 'fatal').exists())"

Invariant: at-emed-groupidentifier-create-out-datamatrixcode
Description: "Ein DataMatrix-Code darf nur enthalten sein, wenn auch der e-Med GroupIdentifier enthalten ist."
* severity = #error
* expression = "parameter.where(name = 'dataMatrixCode').exists() implies parameter.where(name = 'groupIdentifier').exists()"
