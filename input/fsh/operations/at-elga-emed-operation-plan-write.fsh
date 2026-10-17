Instance: AtElgaEmedListPlanWrite
InstanceOf: OperationDefinition
Title: "e-Med Operation für $plan-write"
Description: "Die $plan-write Operation wird aufgerufen, wenn ein Medikationsplan geschrieben wird."
Usage: #definition

* id = "at-elga-emed-operation-plan-write"
* name = "AtElgaEmedListPlanWrite"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server
* system = false       
* type = true   // Aufruf auf Typeebene (Ressourcentyp)
* instance = false   // Id von Instanz muss beim Aufruf nicht bekannt sein
* code = #plan-write
* resource[+] = #List
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
* parameter[=].documentation = "Der *return* Parameter enthält die persistierten Ressourcen."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(Bundle)
//TODO Profil für Response Bundle

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter im Falle eines Fehlers."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedOperationOutcome)



// beim plan-write muss extension:patientModified false sein