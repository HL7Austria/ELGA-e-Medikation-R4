Profile: AtElgaEmedBundleMedikationsplanTx
Parent: Bundle
Id: at-elga-emed-bundle-medikationsplantx
Title: "AT ELGA e-Medikation Transaction Bundle Medikationsplan"
Description: "Profil für das Schreiben des Medikationsplans mit der $plan-write Operation."

* identifier 0..0
// * identifier ^short = "Persistenter Identifikator für das Bundle." 

* type 1..1 MS
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."
 

//* timestamp ^short = "Zeitpunkt der Erstellung des Bundles."
// timestamp nicht notwendig 
// total für transaction bundle nicht vorgesehen

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ 
* entry MS
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erstes Entry soll die Liste sein

* entry contains 
    Medikationsplan 1..1 and    
    Medikationsplaneintrag 0..*
// Liste
* entry[Medikationsplan].resource 1..1
* entry[Medikationsplan].resource only AtElgaEmedListMedikationsplan
* entry[Medikationsplan].resource.entry.item.extension contains ResolveAsVersionSpecific named ResolveAsVersionSpecific 1..1
* entry[Medikationsplan].resource.entry.item.extension[ResolveAsVersionSpecific].valueBoolean = true
// Medikationsplaneinträge
* entry[Medikationsplaneintrag].resource 1..1
* entry[Medikationsplaneintrag].resource only AtElgaEmedMedicationRequestPlaneintrag
// * entry[MagistraleZubereitung].resource 1..1
// * entry[MagistraleZubereitung].resource only AtElgaEmedMedicationMedikation

* entry.link 0..0

//* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. "
