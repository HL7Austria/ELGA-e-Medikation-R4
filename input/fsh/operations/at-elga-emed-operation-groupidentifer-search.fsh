//ohne Kontakt nur mit groupIdentifier
Instance: AtElgaEmedGroupIdentifierSearch
InstanceOf: OperationDefinition
Title: "e-Med Operation für $groupidentifier-search"
Description: "Die $groupidentifier-prescription-search Operation wird aufgerufen, wenn ein Zugriff auf Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier erfolgen soll."
Usage: #definition
* id = "at-elga-emed-operation-groupidentifier-search"
* name = "AtElgaEmedGroupIdentifierSearch"
* status = #draft
* kind = #operation
* affectsState = false 
* system = true
* type = false   
* instance = false
* code = #groupidentifier-search

* parameter[+]
* parameter[=].name = #groupidentifier
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *groupidentifier* Parameter enthält den angefragten GroupIdentifier."
* parameter[=].type = #string

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält je nach Erfolg der Operation OperationOutcome(s) und falls die Operation erfolgreich war auch das Bundle mit den angefragten Geplanten und Durchgeführten Abgaben."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutGroupIdentifierSearch)
