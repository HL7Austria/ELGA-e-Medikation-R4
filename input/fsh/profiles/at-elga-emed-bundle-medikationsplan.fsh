Profile: AtElgaEmedBundleMedikationsplan
Parent: Bundle
Id: at-elga-emed-bundle-medikationsplan
Title: "AT ELGA e-Medikation Medikationsplan-Bundle Medikationsplan"
Description: "Das Medikationsplan-Bundle vom Typ Searchset enthält: 
- 1..1 Medikationsplan (List): Liste mit Referenzen auf Medikationsplaneinträge und zur Abbildung von Reihenfolge und Änderungsstatus
- 0..* Medikationsplaneinträge (MedicationRequests): Medikation und Dosierung
- 1..1 Patient
- 1..* Authors"


* identifier 0..0 
* implicitRules 0..0

* type 1..1 MS
* type = #searchset
* type ^short = "Art des Bundles. Für Medikationspläne immer \"searchset\"."

* timestamp 0..0 //1..1 MS
//* timestamp ^short = "Zeitpunkt der Erstellung des Bundles."  ws. zeitpunkt nur in der liste relevant
//evt. für protokollierung

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ 
* entry MS
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur List und MedicationRequest erlaubt
* entry ^slicing.ordered = true  // erstes Entry soll die Liste sein

* entry contains 
    Medikationsplan 1..1 and    
    Medikationsplaneintrag 0..* and
    Patient 1..1 and
    Authors 1..*
// Liste
* entry[Medikationsplan].resource 1..1
* entry[Medikationsplan].resource only AtElgaEmedListMedikationsplan
// Medikationsplaneinträge
* entry[Medikationsplaneintrag].resource 1..1  
* entry[Medikationsplaneintrag].resource only AtElgaEmedMedicationRequestPlaneintrag
// * entry[MagistraleZubereitung].resource 1..1
// * entry[MagistraleZubereitung].resource only AtElgaEmedMedicationMedikation

* entry[Patient].resource 1..1
* entry[Patient].resource only AtElgaCorePatient

* entry[Authors].resource 1..1
* entry[Authors].resource only AtElgaCorePractitioner or AtElgaEmedDeviceFachanwendung or AtElgaCorePractitionerRole

* entry.link 0..0

* entry.fullUrl 1..1
// * entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle." //TODO: Verwendung prüfen
