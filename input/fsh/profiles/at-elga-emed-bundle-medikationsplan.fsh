Profile: AtElgaEmedBundleMedikationsplan
Parent: Bundle
Id: at-elga-emed-bundle-medikationsplan
Title: "AT ELGA e-Medikation Medikationsplan-Bundle Medikationsplan"
Description: "Profil für den Medikationsplan als Ergebnis der $plan-read Operation."

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #searchset
* type ^short = "Art des Bundles. Für Medikationspläne immer \"searchset\"."

* total 1..1 MS

* link 1.. MS
* link.url 1..1 MS
* link.relation = #self
* link.relation 1..1 MS
* link.modifierExtension 0..0
* link.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ 
* entry MS
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erstes Entry soll die Liste sein
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

* entry contains 
    Medikationsplan 1..1 MS and    
    Medikationsplaneintrag 0..* MS and
    Patient 1..1 MS and
    Authors 1..* MS
// Liste

* entry[Medikationsplan].modifierExtension 0..0
* entry[Medikationsplan].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplan].fullUrl 1..1 MS
* entry[Medikationsplan].request 0..0 MS
* entry[Medikationsplan].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[Medikationsplan].search 1..1 MS
* entry[Medikationsplan].search.mode 1..1 MS
* entry[Medikationsplan].search.mode = #match
* entry[Medikationsplan].search.modifierExtension 0..0
* entry[Medikationsplan].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplan].resource 1..1 MS
* entry[Medikationsplan].resource only AtElgaEmedListMedikationsplan

// Medikationsplaneinträge
* entry[Medikationsplaneintrag].modifierExtension 0..0
* entry[Medikationsplaneintrag].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplaneintrag].fullUrl 1..1 MS
* entry[Medikationsplaneintrag].request 0..0 MS
* entry[Medikationsplaneintrag].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[Medikationsplaneintrag].search 1..1 MS
* entry[Medikationsplaneintrag].search.mode 1..1 MS
* entry[Medikationsplaneintrag].search.mode = #include
* entry[Medikationsplaneintrag].search.modifierExtension 0..0
* entry[Medikationsplaneintrag].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Medikationsplaneintrag].resource 1..1 MS
* entry[Medikationsplaneintrag].resource only AtElgaEmedMedicationRequestPlaneintrag

//Patient
* entry[Patient].modifierExtension 0..0
* entry[Patient].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Patient].fullUrl 1..1 MS
* entry[Patient].request 0..0 MS
* entry[Patient].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[Patient].search 1..1 MS
* entry[Patient].search.mode 1..1 MS
* entry[Patient].search.mode = #include
* entry[Patient].search.modifierExtension 0..0
* entry[Patient].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Patient].resource 1..1 MS
* entry[Patient].resource only AtElgaEmedPatient


// Authors
* entry[Authors].modifierExtension 0..0
* entry[Authors].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Authors].fullUrl 1..1 MS
* entry[Authors].request 0..0 MS
* entry[Authors].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[Authors].search 1..1 MS
* entry[Authors].search.mode 1..1 MS
* entry[Authors].search.mode = #include
* entry[Authors].search.modifierExtension 0..0
* entry[Authors].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[Authors].resource 1..1 MS
* entry[Authors].resource only AtElgaEmedPractitioner or AtElgaEmedDeviceFachanwendung or AtElgaEmedPractitionerRole or AtElgaEmedOrganization

