Profile: AtEmedBundleMedikationsplan
Parent: Bundle
Id: at-emed-bundle-medikationsplan
Title: "ELGA e-Med Medikationsplan Collection Bundle"
Description: "Das Bundle vom Typ Collection bestehend aus: 
- 1..1 Medikationsplan (List): Liste mit Referenzen auf Medikationsplaneinträge und zur Abbildung von Reihenfolge und Änderungsstatus) 
- 0..* Medikationsplaneinträge (MedicationRequests): Medikation und Dosierung"

* identifier 0..1 MS
* identifier ^short = "Persistenter Identifikator für das Bundle. Verwendung prüfen."

* type 1..1 MS
* type = #collection
* type ^short = "Art des Bundles. Für Medikationspläne immer \"collection\"."

* timestamp 1..1 MS
* timestamp ^short = "Zeitpunkt der Erstellung des Bundles. Verwendung prüfen."

* link 0..0
* link ^short = "Verweise auf weiterführende Informationen zum Bundle. Verwendung prüfen." 

// Slicing legt fest, welche Entries erlaubt sind -> Unterscheidung der Slices anhand von Pfad und Typ 
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
// * entry[MagistraleZubereitung].resource 1..1
// * entry[MagistraleZubereitung].resource only AtEmedMedication

* entry.link 0..0
* entry.link ^short = "Verweise auf weiterführende Informationen zu diesem Entry. Verwendung prüfen."

* entry.fullUrl ^short = "Eindeutige URL für den Eintrag im Bundle. Verwendung prüfen."

// TODO Fachlich abklären, ob Patient und Practitioner auch im Bundle enthalten sein müssen -> damit in der History verfügbar 