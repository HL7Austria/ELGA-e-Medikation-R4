Profile: AtEmedListMedikationsplan
Parent: List
Id: at-emed-list-medikationsplan
Title: "ELGA e-Med Medikationsplan"
Description: "Bildet den Medikationsplan eines ELGA-Teilnehmers ab (\"List\"-Ressource). 
Die Liste beinhaltet Referenzen auf 0..* Medikationsplaneinträge (MedicationRequests), die alle geplanten Medikationen und deren Dosierung abbilden.
Die Reihenfolge der Listenelemente kann duch den User festgelegt werden. Jedes Listenelement enthält einen Änderungsstatus."

//TODO: Invariante, dass überall in der List der gleiche Patient enthalten sein muss

* identifier 0..1 MS
* identifier ^short = "Logischer Identfier der Liste (des Medikationsplans) zur Schreibintegritätsprüfung."

* status 1..1 MS
* status from ElgaListStatusVS (required)
* status ^short = "Mögliche Ausprägungen: [current | retired] Bedeutung: current: default | retired: nach Ableben des Patienten bis Ende der Aufbewahrungsfrist"

* mode 1..1 MS
* mode = #working (exactly)
* mode ^short = "Der Medikationsplan ist ein laufend gepflegtes Dokument. Fixer Wert: working."

* title 0..0
* title ^short = "Titel der Liste."

* code 1..1 MS 
* code = $cs-sct#736378000 "Medikationsplan" (exactly)
* code ^short = "Code, der den Typ der Liste beschreibt."

* subject 1..1 MS
* subject only Reference(HL7ATCorePatient) // TODO ELGA Patient ableiten
* subject ^short = "Patient, für den der Medikationsplan dokumentiert wird, der über den 
Zentralen Patientenindex identifizierbar und Teilnehmer von ELGA e-Medikation ist."

* encounter 0..0
* encounter ^short = "Behandlungskontext, in dem die Liste erstellt wurde."

* date 1..1 MS
* date ^short = "Letzte Aktualisierung des Medikationsplans."

* source 1..1 MS
* source only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or Device or HL7ATCorePatient)  // TODO ELGA Profile
* source ^short = "Arzt oder Ärztin, die den Medikationsplans erstellt hat und für den Inhalt verantwortlich ist. 
Eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation 
des Patienten zuzugreifen. Device nur für initiale Erstellung durch die Fachanwendung. Patient nur zur Änderung der Reihenfolge der Planeinträge oder nachdem er Einträge gelöscht hat."

* orderedBy 1..1 MS
* orderedBy from http://hl7.org/fhir/ValueSet/list-order 
* orderedBy = #user
* orderedBy ^short = "Die Reihenfolge der Einträge im Medikationsplan ist fachlich relevant und wird durch den Ersteller vorgegeben. Da nicht verpflichtend, könnte das Element auch 0..0 gesetzt werden.
Evtl. Unterscheidung user und patient.
Mögliche Codes: user | system | event-date | entry-date| priority | alphabetic | category | patient (TODO: nur user oder andere Reihenfolge ermöglichen?)"

// note: Mögliches Kommentar auf Ebene des Medikationsplans
* note 0..* MS
* note ^short = "Freitextliche Anmerkungen zum Medikationsplan. TODO: prüfen, ob fachlich sinnvoll."

// --- Entries ---
* entry 0..* MS

* entry.flag 1..1 MS
* entry.flag from ElgaListEntryFlagVS
* entry.flag ^short = "Kennzeichnet die Art der Änderung des Medikationsplaneintrags: [New | Unchanged | Changed | Removed] Bedeutung: New: Neuer Planeintrag wird hinzugefügt | Unchanged: Bestehender Planeintrag wird beibehalten und zur Kenntnis genommen | Changed: Bestehender Planeintrag wird geändert | Removed: Bestehender Planeintrag wird entfernt"

* status ^short = "Mögliche Ausprägungen: [current | retired] Bedeutung: current: default | retired: nach Ableben des Patienten bis Ende der Aufbewahrungsfrist"


* entry.deleted 0..0 MS // removed, löschen: planeintrag aus liste entfernen
* entry.deleted ^short = "Gibt an, ob der referenzierte Medikationsplaneintrag zur Entfernung markiert wurde. Unklar, ob Löschen so abgebildet werden soll oder einfach der Eintrag nicht mehr enthalten ist."

* entry.date 0..1 MS
* entry.date ^short = "Datum der Aufnahme / Änderung des Medikationsplaneintrags. Fachlich zu klären."

* entry.item 1..1 MS
* entry.item only Reference(AtEmedMRPlaneintrag)
* entry.item ^short = "Referenz auf einen Medikationsplaneintrag."

* emptyReason 0..1 MS
* emptyReason from ElgaListEmptyReasonVS (required)
* emptyReason ^short = "Begründung, warum der Medikationsplan leer ist. Mögliche Ausprägungen: [notstarted |  nilknown] Bedeutung: notstarted: Intitalzustand - noch nie befüllt | nilknown: Patient nimmt derzeit keine Medikamente ein"