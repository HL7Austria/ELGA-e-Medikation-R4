Profile: AtEmedBundleMedikationsplanTx
Parent: Bundle
Id: at-emed-bundle-tx-medikationsplan
Title: "ELGA e-Med Medikationsplan Transaction Bundle"
Description: "**Beschreibung:** Das Bundle vom Typ Transaction dient dem schreibenden Zugriff auf den ELGA Medikationsplan bestehend aus: 
- 1..1 List: Liste der Medikationsplaneinträge und deren Änderungsstatus
- 0..* MedicationRequests: Medikationsplaneinträge 
"

* identifier 0..1 // 1..1 MS
* identifier ^short = "Persistenter Identifikator für das Bundle."

* type 1..1
* type = #transaction
* type ^short = "Art des Bundles. Für schreibenden Zugriff immer Typ \"transaction\"."
 
* timestamp 1..1
* timestamp ^short = "Zeitpunkt der Erstellung des Bundles. Verwendung prüfen."

* link 0..*
* link ^short = "Verweise auf weiterführende Informationen zum Bundle. Verwendung prüfen." 

// Slicing legt fest, welche Entries erlaubt sind
// Unterscheidung der Slices anhand von Pfad und Typ 
* entry ^slicing.discriminator[+].type = #type   
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed  // als Entries sind nur list und medicationrequest erlaubt
* entry ^slicing.ordered = true  // erstes Entry soll die Liste sein

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