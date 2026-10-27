Instance: At-Emed-Journey-01-03-Bundle-Geplante-Abgaben-Tx
InstanceOf: AtElgaEmedBundleGeplanteAbgabenTx
Title: "Beispiel Journey 01-03: Geplante-Abgaben-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles mit 2 Geplanten Abgaben."
Usage: #example

* type = #transaction
// Geplante Abgaben
* entry[+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01-vPOST
* entry[=].fullUrl = $POSTuuidGeplanteAbgabe01  // vorübergehende id vom client erzeugt bei post
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

* entry[+].resource = At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02-vPOST
* entry[=].fullUrl = $POSTuuidGeplanteAbgabe02  // vorübergehende id vom client erzeugt bei post
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"
