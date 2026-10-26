Instance: AtElgaEmedDispenseWrite
InstanceOf: OperationDefinition
Title: "e-Med Operation für $dispense-write"
Description: "Die $dispense-write Operation wird aufgerufen, wenn Durchgeführte Abgaben geschrieben werden sollen."
Usage: #definition
* id = "at-elga-emed-operation-dispense-write"
* name = "AtElgaEmedDispenseWrite"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server
* system = false       
* type = true   // Aufruf auf Typeebene (Ressourcentyp)
* instance = false   // Id von Instanz muss beim Aufruf nicht bekannt sein
* code = #dispense-write
* resource[+] = #MedicationDispense

* parameter[+]
* parameter[=].name = #durchgefuehrteAbgaben   
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *durchgefuehrteAbgaben* Parameter dient der Übermittlung der Durchgeführten Abgaben die geschrieben werden sollen."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedBundleDurchgefuehrteAbgabenTx)

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält je nach Erfolg der Operation OperationOutcome(s) und falls die Operation erfolgreich war auch die persistierten Ressourcen."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutDispenseWrite)
