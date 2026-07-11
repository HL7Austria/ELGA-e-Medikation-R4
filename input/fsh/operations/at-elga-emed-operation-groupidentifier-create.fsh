//ohne Kontakt
Instance: AtElgaEmedGroupIdentifierCreate
InstanceOf: OperationDefinition
Title: "eMed Operation für GroupIdentifier-Create"
Description: "Die $groupidentifier-create Operation wird aufgerufen, wenn ein neuer GroupIdentifer (ohne Patientenbezug) vom Server angefordert werden soll."
Usage: #definition
* id = "at-emed-operation-groupidentifier-create"
* name = "AtElgaEmedGroupIdentifierCreate"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server;
* system = true       // Aufruf erfolgt auf Systemebene
* type = false   
* instance = false
* code = #groupidentifier-create
* parameter[+]
* parameter[=].name = #groupidentifier
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *groupidentifier* Parameter enthält den angefragten GroupIdentifier."
* parameter[=].type = #string
* parameter[+]
* parameter[=].name = #datamatrixcode
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *datamatrixcode* Parameter enthält den DataMatrix-Code."
* parameter[=].type = #Attachment
//Quelle: https://www.chipkarte.at/de/javadoc/at/chipkarte/client/elgaad/soap/EmedIdErstellenErgebnis.html#EmedIdErstellenErgebnis--
* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter gibt Auskunft über den Erfolg der Operation."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(OperationOutcome)