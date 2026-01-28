Profile: AtEmedCollectionMedikationsplan
Parent: Bundle
Id: at-emed-collection-medikationsplan
Title: "ELGA e-Medikation Bundle vom Typ Collection Medikationsplan"
Description: "**Beschreibung:** ELGA e-Medikation Bundle vom Typ Collection zur Speicherung und Auslieferung eines Medikationsplans mit Medikationsplaneinträgen. 
Beinhaltet:
- Medikationsplan 1..1 (List)
- Medikationsplaneinträge 0..* (MedicationRequest)
"

* identifier 0..1
* identifier ^short = "Persistenter Identifikator für das Bundle."

* type 1..1
* type = #collection

// Slicing legt erlaubte Ihalte fest
* entry ^slicing.discriminator[+].type = #type   //anhand welchem Pfad und Eigenschaft unterschieden wird
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // nur list und medicationrequest erlaubt
* entry ^slicing.ordered = true  //wir wollen zuerst Liste

* entry contains 
    Medikationsplan 1..1 and    
    Medikationsplaneintrag 0..*

* entry[Medikationsplan].resource 1..1
* entry[Medikationsplan].resource only AtEmedListMedikationsplan

* entry[Medikationsplaneintrag].resource 1..1
* entry[Medikationsplaneintrag].resource only AtEmedMRPlaneintrag

// TODO Fachlich abklären, ob Patient und Practitioner auch im Bundle enthalten sein müssen -> damit in der History verfügbar 