Instance: AtElgaEmedListPlanWrite
InstanceOf: OperationDefinition
Title: "e-Med Operation für Plan-Write"  //TODO
Description: "Die $plan-write Operation wird aufgerufen, wenn ein Medikationsplan geschrieben wird."
Usage: #definition

* id = "AtElgaEmed.List.PlanWrite"
* name = "AtElgaEmed_List_PlanWrite"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server
* system = false       
* type = true   // Aufruf auf Typeebene (Ressourcentyp)
* instance = false   // Id von Instanz muss beim Aufruf nicht bekannt sein, nur Patient-ID
* code = #write
* parameter[+]
* parameter[=].name = #id   // prüfen
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *id* Parameter dient der Zuordnung des Patienten."
* parameter[=].type = #string
* parameter[+]
* parameter[=].name = #medikationsplan   
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *medikationsplan* Parameter dient der Übermittlung der Medikationsplandaten des Patienten."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedBundleMedikationsplanTx)   
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)