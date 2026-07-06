//ohne Kontakt nur mit groupIdentifier
Instance: AtEmedGroupIdentifierPrescriptionSearch
InstanceOf: OperationDefinition
Title: "eMed Operation für GroupIdentifier Prescription Search"
Description: "Die $groupidentifier-prescription-search Operation wird aufgerufen, wenn ein Zugriff auf geplante Abgaben mittels e-Med Groupidentifier erfolgen soll."
Usage: #definition
* id = "at-emed-operation-groupidentifier-prescription-search"
* name = "AtEmedGroupIdentifierPrescriptionSearch"
* status = #draft
* kind = #operation
* affectsState = false  // Ändert den Zustand am Server;
* system = true       // Aufruf erfolgt auf Systemebene
* type = false   
* instance = false
* code = #groupidentifier-prescription-search
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
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält die angefragte(n) geplante(n) Abgabe(n)."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(Bundle) //TODO evtl. eigenes Bundle Profil
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)