Instance: AtElgaEmedPrescriptionDiscard
InstanceOf: OperationDefinition
Title: "eMed Operation $prescription-discard"
Description: "Operation für das Stornieren von Geplanten Abgaben"
Usage: #definition
* id = "at-emed-operation-prescription-discard"
* name = "AtElgaEmedPrescriptionDiscard"
* status = #draft
* kind = #operation
* affectsState = true
* system = false       
* type = false   
* instance = true
* resource[+] = #MedicationRequest
* code = #prescription-discard
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Die Geplante Abgabe so wie sie nach dem Ausführen der Operation am Server persistiert ist."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedMedicationRequestGeplanteAbgabe)