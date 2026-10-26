Instance: AtElgaEmedPrescriptionWrite
InstanceOf: OperationDefinition
Title: "e-Med Operation für $prescription-write"
Description: "Die $prescription-write Operation wird aufgerufen, wenn Geplante Abgaben geschrieben werden sollen."
Usage: #definition
* id = "at-elga-emed-operation-prescription-write"
* name = "AtElgaEmedPrescriptionWrite"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server
* system = false       
* type = true   // Aufruf auf Typeebene (Ressourcentyp)
* instance = false   // Id von Instanz muss beim Aufruf nicht bekannt sein
* code = #prescription-write
* resource[+] = #MedicationRequest

* parameter[+]
* parameter[=].name = #geplanteAbgaben   
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *geplanteAbgaben* Parameter dient der Übermittlung der Geplanten Abgaben die geschrieben werden sollen."
* parameter[=].type = #Bundle
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedBundleGeplanteAbgabenTx)

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält je nach Erfolg der Operation OperationOutcome(s) und falls die Operation erfolgreich war auch die persistierten Ressourcen."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutPrescriptionWrite)