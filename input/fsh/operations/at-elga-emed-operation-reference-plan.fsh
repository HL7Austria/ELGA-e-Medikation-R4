Instance: AtElgaEmedReferencePlan
InstanceOf: OperationDefinition
Title: "e-Med Operation für $reference-plan"
Description: "Operation für das Verknüpfen von durchgeführten Abgaben und Planeinträgen."
Usage: #definition
* id = "at-elga-emed-operation-reference-plan"
* name = "AtElgaEmedReferencePlan"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server;
* system = false       
* type = false   
* instance = true
* resource[+] = #MedicationDispense
* code = #reference-plan

* parameter[+]
* parameter[=].name = #planentry-reference
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Referenz auf den Planeintrag mit welchem die Durchgeführte Abgabe verbunden werden soll."
* parameter[=].type = #Reference

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