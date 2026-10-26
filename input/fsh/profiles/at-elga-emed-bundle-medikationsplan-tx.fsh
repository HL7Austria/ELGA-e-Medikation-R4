Profile: AtElgaEmedBundleMedikationsplanTx
Parent: Bundle
Id: at-elga-emed-bundle-medikationsplantx
Title: "AT ELGA e-Medikation Transaction Bundle Medikationsplan"
Description: "Profil für das Schreiben des Medikationsplans mit der $plan-write Operation."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."
 
// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ 
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erster Entry soll die Liste sein
* entry contains 
    Medikationsplan 1..1 MS and    
    Medikationsplaneintrag 0..* MS
// Liste
* entry[Medikationsplan].modifierExtension 0..0
* entry[Medikationsplan].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplan].fullUrl 1..1 MS
* entry[Medikationsplan].request 1..1 MS
* entry[Medikationsplan].request.modifierExtension 0..0
* entry[Medikationsplan].request.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplan].request.method 1..1 MS
* entry[Medikationsplan].request.method = $cs-http-codes#PUT
* entry[Medikationsplan].request.url 1..1 MS
* entry[Medikationsplan].resource only AtElgaEmedListMedikationsplan
* entry[Medikationsplan].resource 1..1 MS
* entry[Medikationsplan].resource.entry.item.extension MS
* entry[Medikationsplan].resource.entry.item.extension contains ResolveAsVersionSpecific named ResolveAsVersionSpecific 1..1 MS
* entry[Medikationsplan].resource.entry.item.extension[ResolveAsVersionSpecific].valueBoolean = true
* entry[Medikationsplan].resource.entry.item.extension[ResolveAsVersionSpecific].valueBoolean MS

// Medikationsplaneinträge
* entry[Medikationsplaneintrag].modifierExtension 0..0
* entry[Medikationsplaneintrag].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplaneintrag].fullUrl 1..1 MS
* entry[Medikationsplaneintrag].request 1..1 MS
* entry[Medikationsplaneintrag].request.modifierExtension 0..0
* entry[Medikationsplaneintrag].request.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplaneintrag].request.method 1..1 MS
* entry[Medikationsplaneintrag].request.method from AtElgaEmedValueSetMedikationsplanHTTPCodes
* entry[Medikationsplaneintrag].request.url 1..1 MS
* entry[Medikationsplaneintrag].resource 1..1 MS
* entry[Medikationsplaneintrag].resource only AtElgaEmedMedicationRequestPlaneintrag

// Allgemeine Regeln für alle Entries
* entry MS
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
