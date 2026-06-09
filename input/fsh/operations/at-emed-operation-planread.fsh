Instance: AtEmedListPlanRead
InstanceOf: OperationDefinition
Title: "e-Med Operation für Plan-Read"
Description: "Die $plan-read Operation wird aufgerufen, wenn ein Medikationsplan mit der Intention zu schreiben gelesen wird."
Usage: #definition

* id = "AtEmed.List.PlanRead"
* name = "AtEmed_List_PlanRead"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server; zu klären Version-ID
* system = true       // Aufruf erfolgt auf Systemebene, wenn noch kein Plan erstellt wurde 
* type = true   // Aufruf auf Typeebene (Ressourcentyp), wenn bereits ein Plan erstellt wurde
* instance = false   // Id von Instanz muss beim Aufruf nicht bekannt sein, nur Patient-ID
* code = #planread
* parameter[+]
* parameter[=].name = #id   // prüfen
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *id* Parameter dient der Zuordnung des Patienten."
* parameter[=].type = #string
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtEmedBundleMedikationsplan)  // Collection Bundle