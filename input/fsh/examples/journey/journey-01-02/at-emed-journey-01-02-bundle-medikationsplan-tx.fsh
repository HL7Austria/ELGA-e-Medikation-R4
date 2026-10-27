Instance: At-Emed-Journey-01-02-Bundle-Medikationsplan-Tx
InstanceOf: AtElgaEmedBundleMedikationsplanTx   
Title: "Beispiel Journey 01-02: Mediaktionsplan-Transaction-Bundle"
Description: "Beispiel eines Transaction Bundles, das einen Mediaktionsplan (List) mit 2 neuen Planeinträgen (MedicationRequests) enthält."
Usage: #example

* type = #transaction
// Liste 
* entry[Medikationsplan][+].resource = At-Emed-Journey-List-Medikationsplan-v2-tx
* entry[Medikationsplan][=].fullUrl = $srPlan // -> vom server vergebene id verwenden, bei jedem put der liste verwenden
* entry[Medikationsplan][=].request.method = #PUT 
* entry[Medikationsplan][=].request.url = $rrPlan

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-01-Ramipril-vPOST
* entry[Medikationsplaneintrag][=].fullUrl = $POSTuuidPlaneintrag01  // vorübergehende id vom client erzeugt bei post
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"

* entry[Medikationsplaneintrag][+].resource = At-Emed-Journey-Planeintrag-02-Magistral-Dexpanthenol-vPOST
* entry[Medikationsplaneintrag][=].fullUrl = $POSTuuidPlaneintrag02 // vorübergehende id vom client erzeugt bei post
* entry[Medikationsplaneintrag][=].request.method = #POST 
* entry[Medikationsplaneintrag][=].request.url = "MedicationRequest"


