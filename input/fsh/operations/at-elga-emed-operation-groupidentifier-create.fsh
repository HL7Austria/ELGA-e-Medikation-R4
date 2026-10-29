//ohne Kontakt
Instance: AtElgaEmedGroupIdentifierCreate
InstanceOf: OperationDefinition
Title: "AT ELGA e-Medikation Operation für $groupidentifier-create"
Description: "Die $groupidentifier-create Operation wird aufgerufen, wenn ein neuer GroupIdentifer (ohne Patientenbezug) vom Server angefordert werden soll."
Usage: #definition
* id = "at-elga-emed-operation-groupidentifier-create"
* name = "AtElgaEmedGroupIdentifierCreate"
* status = #draft
* kind = #operation
* affectsState = true  // Ändert den Zustand am Server;
* system = true       // Aufruf erfolgt auf Systemebene
* type = false   
* instance = false
* code = #groupidentifier-create

* parameter[+]
* parameter[=].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Der *return* Parameter enthält je nach Erfolg der Operation entweder den neu erzeugten e-Med GroupIdentifier und den zugehörigen DataMatrix-Code oder ein OperationOutcome mit dem Fehler, der zur Ablehnung der Operation geführt hat."
* parameter[=].type = #Resource
* parameter[=].targetProfile[+] = Canonical(AtElgaEmedParametersOutGroupIdentifierCreate)
//Quelle DataMatrix-Code: https://www.chipkarte.at/de/javadoc/at/chipkarte/client/elgaad/soap/EmedIdErstellenErgebnis.html#EmedIdErstellenErgebnis--
