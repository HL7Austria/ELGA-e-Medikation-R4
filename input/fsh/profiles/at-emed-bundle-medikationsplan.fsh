Profile: AtEmedBundleMedikationsplan
Parent: Bundle
Id: at-emed-bundle-medikationsplan
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
* type ^short = "Art des Bundles. Für Medikationspläne immer 'collection'."

// TODO: prüfen 
* timestamp 1..1
* timestamp ^short = "Zeitpunkt der Erstellung des Bundles. Verwendung prüfen."

* link 0..*
* link ^short = "Verweise auf weiterführende Informationen zum Bundle. Verwendung prüfen." 

// Slicing legt fest, welche Entries erlaubt sind
* entry ^slicing.discriminator[+].type = #type   //anhand welchem Pfad und Eigenschaft unterschieden wird
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // nur list und medicationrequest erlaubt
* entry ^slicing.ordered = true  //wir wollen zuerst Liste

* entry contains 
    Medikationsplan 1..1 and    
    Medikationsplaneintrag 0..*
// Liste
* entry[Medikationsplan].resource 1..1
* entry[Medikationsplan].resource only AtEmedListMedikationsplan
// Medikationsplaneinträge
* entry[Medikationsplaneintrag].resource 1..1
* entry[Medikationsplaneintrag].resource only AtEmedMRPlaneintrag

* entry.link 0..0
* entry.link ^short = "Verweise auf weiterführende Informationen zu diesem Entry. Verwendung prüfen."
* entry.fullUrl 0..0
* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. Verwendung prüfen."


// TODO Fachlich abklären, ob Patient und Practitioner auch im Bundle enthalten sein müssen -> damit in der History verfügbar 
// dzt in List und in MedicationRequests referenziert