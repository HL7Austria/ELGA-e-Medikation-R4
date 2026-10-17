Instance: AtElgaEmedDispenseDiscard
InstanceOf: OperationDefinition
Title: "e-Med Operation für $dispense-discard"
Description: "Operation für das Stornieren von Durchgeführten Abgaben"
Usage: #definition
* id = "at-elga-emed-operation-dispense-discard"
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
* parameter[=].documentation = "Die Durchgeführte Abgabe so wie sie nach dem Ausführen der Operation am Server persistiert ist."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe)

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter im Falle eines Fehlers."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedOperationOutcome)