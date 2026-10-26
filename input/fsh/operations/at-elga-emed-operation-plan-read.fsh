Instance: AtElgaEmedListPlanRead
InstanceOf: OperationDefinition
Title: "e-Med Operation für $plan-read"
Description: """
Die $plan-read Operation ruft den aktuellen Medikationsplan eines
ELGA-Teilnehmers in einem für die Bearbeitung durch den GDA aufbereiteten
Zustand ab.
"""
Usage: #definition

* id = "at-elga-emed-operation-plan-read"
* name = "AtElgaEmedListPlanRead"
* status = #draft
* kind = #operation
// Die Operation kann bei noch nicht vorhandenem Medikationsplan dessen initiale List-Ressource persistieren.
* affectsState = true
//ASW TODO 28.09.2026 falls die initiale Plan erstellung doch über das berechtigungsystem getriggert wird muss dieser Wert auf false gesetzt werden
* system = false
* type = true
* instance = false
* resource[+] = #List
* code = #plan-read

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutPlanRead)
* parameter[=].documentation = """
Der *return* Parameter enthält je nach Erfolg der Operation OperationOutcome(s)
und falls die Operation erfolgreich war auch das temporäre, für die Bearbeitung
aufbereitete Medikationsplan-Bundle. Es enthält die aktuelle, gegebenenfalls
transformierte oder initial erzeugte List-Ressource sowie sämtliche von ihr
referenzierten Ressourcen.

Der ETag der aktuellen persistierten List-Version wird im HTTP-
Response-Header übermittelt und ist kein Ausgabeparameter der Operation.
"""
