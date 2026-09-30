Instance: AtElgaEmedListPlanRead
InstanceOf: OperationDefinition
Title: "e-Med Operation für Plan-Read"
Description: "Die $plan-read Operation ruft den aktuellen Medikationsplan eines ELGA-Teilnehmers in einem für die Bearbeitung aufbereiteten Zustand ab. Existiert noch kein Medikationsplan, wird ein initialer Medikationsplan erzeugt."
Usage: #definition

* id = "AtElgaEmed.List.PlanRead"
* name = "AtElgaEmed_List_PlanRead"
* status = #draft
* kind = #operation
// Die Operation kann bei noch nicht vorhandenem Medikationsplan dessen initiale List-Ressource persistieren.
* affectsState = true
//ASW TODO 28.09.2026 falls die initiale Plan erstellung doch über das berechtigungsystem getriggert wird muss dieser Wert auf false gesetzt werden
* system = false
* type = true
* instance = false
* code = #plan-read


* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter im Falle eines Fehlers."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Das für die Bearbeitung aufbereitete Medikationsplan-Bundle. Es enthält die aktuelle oder gegebenenfalls initial erzeugte List-Ressource sowie alle von ihr referenzierten Ressourcen."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedBundleMedikationsplan)  // Medikationsplan-Bundle