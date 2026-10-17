Instance: AtElgaEmedPrescriptionDiscard
InstanceOf: OperationDefinition
Title: "e-Med Operation für $prescription-discard"
Description: "Operation für das Stornieren von Geplanten Abgaben"
Usage: #definition
* id = "at-elga-emed-operation-prescription-discard"
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

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter im Falle eines Fehlers."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedOperationOutcome)