Instance: AtEmedListWrite
InstanceOf: OperationDefinition
Title: "e-Med Operation für Write des Medikationsplans"  //TODO
Description: "Die $write Operation wird aufgerufen, wenn ein Medikationsplan geschrieben wird."
Usage: #definition

* id = "AtEmed.List.Write"
* name = "AtEmed_List_Write"
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
* parameter[=].documentation = "Der *id* Parameter dient der Zurordnung des Patienten."
* parameter[=].type = #string
* parameter[+]
* parameter[=].name = #medikationsplan   
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *medikationsplan* Parameter dient der Übermittlung der Medikationsplandaten des Patienten."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtEmedBundleTxMedikationsplan)   
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)