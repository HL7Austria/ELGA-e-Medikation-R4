Instance: At-Emed-Journey-01-03-Parameters-Out-GroupIdentifier-Create
InstanceOf: AtElgaEmedParametersOutGroupIdentifierCreate
Title: "Beispiel Journey 01-03: $groupidentifier-create Response"
Description: "Beispiel einer Response eines $groupidentifier-create mit dem neu erzeugten e-Med GroupIdentifier und dem zugehörigen DataMatrix-Code."
Usage: #example
* parameter[groupIdentifier].name = "groupIdentifier"
* parameter[groupIdentifier].valueString = "WYE82A2G8EEW"
* parameter[dataMatrixCode].name = "dataMatrixCode"
* parameter[dataMatrixCode].valueAttachment.contentType = #image/png
// TODO: Platzhalter (1x1 PNG), durch tatsächlichen DataMatrix-Code des GroupIdentifiers ersetzen
* parameter[dataMatrixCode].valueAttachment.data = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
