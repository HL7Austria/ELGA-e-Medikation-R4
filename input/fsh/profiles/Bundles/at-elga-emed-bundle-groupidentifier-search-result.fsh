Profile: AtElgaEmedBundleGroupIdentifierSearchResult
Parent: Bundle
Id: at-elga-emed-bundle-groupidentifier-search-result
Title: "AT ELGA e-Medikation Searchset Bundle GroupIdentifier-Search"
Description: "Profil für das Ergebnis der $groupidentifier-search Operation. Das Bundle enthält die dem e-Med GroupIdentifier zugeordneten Geplanten und Durchgeführten Abgaben sowie die von ihnen referenzierten Patient- und Autoren-Ressourcen."

* obeys at-emed-bundle-groupidentifier-search-result-total and at-emed-bundle-groupidentifier-search-result-patient

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* type 1..1 MS
* type = #searchset
* type ^short = "Art des Bundles. Für Search Results immer \"searchset\"."

* total 1..1 MS
* total ^short = "Anzahl der gefundenen Geplanten und Durchgeführten Abgaben (Entries mit search.mode = match)"

* link 1.. MS
* link.url 1..1 MS
* link.relation = #self
* link.relation 1..1 MS
* link.modifierExtension 0..0
* link.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ
* entry ^slicing.discriminator[+].type = #type
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur MedicationRequest, MedicationDispense, Patient, Practitioner und PractitionerRole erlaubt
* entry contains
    GeplanteAbgabe 0..* MS and
    DurchgefuehrteAbgabe 0..* MS and
    Patient 0..1 MS and
    Authors 0..* MS

// Geplante Abgaben
* entry[GeplanteAbgabe] ^short = "Dem e-Med GroupIdentifier zugeordnete Geplante Abgaben"
* entry[GeplanteAbgabe].modifierExtension 0..0
* entry[GeplanteAbgabe].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[GeplanteAbgabe].fullUrl 1..1 MS
* entry[GeplanteAbgabe].request 0..0 MS
* entry[GeplanteAbgabe].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[GeplanteAbgabe].search 1..1 MS
* entry[GeplanteAbgabe].search.mode 1..1 MS
* entry[GeplanteAbgabe].search.mode = #match
* entry[GeplanteAbgabe].search.modifierExtension 0..0
* entry[GeplanteAbgabe].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[GeplanteAbgabe].resource 1..1 MS
* entry[GeplanteAbgabe].resource only AtElgaEmedMedicationRequestGeplanteAbgabe

// Durchgeführte Abgaben
* entry[DurchgefuehrteAbgabe] ^short = "Dem e-Med GroupIdentifier zugeordnete Durchgeführte Abgaben"
* entry[DurchgefuehrteAbgabe].modifierExtension 0..0
* entry[DurchgefuehrteAbgabe].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[DurchgefuehrteAbgabe].fullUrl 1..1 MS
* entry[DurchgefuehrteAbgabe].request 0..0 MS
* entry[DurchgefuehrteAbgabe].request ^short = "Fachliche Begründung: In einem Searchset Bundle darf kein Request vorkommen."
* entry[DurchgefuehrteAbgabe].search 1..1 MS
* entry[DurchgefuehrteAbgabe].search.mode 1..1 MS
* entry[DurchgefuehrteAbgabe].search.mode = #match
* entry[DurchgefuehrteAbgabe].search.modifierExtension 0..0
* entry[DurchgefuehrteAbgabe].search.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* entry[DurchgefuehrteAbgabe].resource 1..1 MS
* entry[DurchgefuehrteAbgabe].resource only AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe

// Patient
* entry[Patient] ^short = "ELGA-Teilnehmer, auf den sich die Geplanten und Durchgeführten Abgaben beziehen"
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
* entry[Authors] ^short = "Verordnende (requester) bzw. abgebende (performer) GDA der Geplanten und Durchgeführten Abgaben"
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
* entry[Authors].resource only AtElgaEmedPractitioner or AtElgaEmedPractitionerRole or AtElgaEmedOrganization

// Allgemeine Regeln für alle Entries
* entry MS
* entry.modifierExtension 0..0
* entry.modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

Invariant: at-emed-bundle-groupidentifier-search-result-total
Description: "Bundle.total muss der Anzahl der gefundenen Geplanten und Durchgeführten Abgaben (Entries mit search.mode = 'match') entsprechen."
* severity = #error
* expression = "total = entry.where(search.mode = 'match').count()"

Invariant: at-emed-bundle-groupidentifier-search-result-patient
Description: "Sind Geplante oder Durchgeführte Abgaben enthalten, muss auch der referenzierte Patient enthalten sein."
* severity = #error
* expression = "entry.where(search.mode = 'match').exists() implies entry.resource.ofType(Patient).exists()"
