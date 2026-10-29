Instance: AtElgaEmedDispenseDiscard
InstanceOf: OperationDefinition
Title: "AT ELGA e-Medikation Operation für $dispense-discard"
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
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält je nach Erfolg der Operation entweder die stornierte Durchgeführte Abgabe (sowie ggf. die dadurch in ihrem Status geänderte Geplante Abgabe), so wie sie nach dem Ausführen der Operation am Server persistiert ist oder ein OperationOutcome mit dem Fehler, der zur Ablehnung der Operation geführt hat."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutDispenseDiscard)
