Instance: AtElgaEmedDispenseDiscard
InstanceOf: OperationDefinition
Title: "eMed Operation $dispense-discard"
Description: "Operation für das Stornieren von Durchgeführten Abgaben"
Usage: #definition
* id = "at-emed-operation-dispense-discard"
* name = "AtElgaEmedDispenseDiscard"
* status = #draft
* kind = #operation
* affectsState = true
* system = false       
* type = false   
* instance = true
* resource[+] = #MedicationDispense
* code = #dispense-discard
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Die durchgeführte Abgabe so wie sie nach dem Ausführen der Operation am Server persistiert ist."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe)