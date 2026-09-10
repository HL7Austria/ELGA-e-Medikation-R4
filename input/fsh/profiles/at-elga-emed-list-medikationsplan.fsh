Profile: AtElgaEmedListMedikationsplan 
Parent: List 
Id: at-elga-emed-list-medikationsplan
Title: "AT ELGA e-Medikation List Medikationsplan"
Description: "Der Medikationsplan wird durch eine List-Ressource abgebildet. 
Diese enthält 0..* Einträge (List.entry), wobei jedes List.entry.item genau eine Referenz auf einen Medikationsplaneintrag (MedicationRequest) beinhaltet.
Die Reihung der List.entries bestimmt die Reihenfolge der Medikationsplaneinträge. 
Jeder Listeneintrag enthält im Element List.entry.flag den Änderungsstatus des jeweiligen Medikationsplaneintrags."

//TODO: Invariante, dass überall in der List der gleiche Patient enthalten sein muss

* identifier 0..1 MS   //TODO: optional lassen? 
* identifier ^short = "Logischer Identfier der Liste (des Medikationsplans)." 

* status 1..1 MS
* status from ElgaListStatusVS (required)
* status ^short = "Status des Medikationsplans. Mögliche Ausprägungen: [current | retired] Bedeutung: current: default | retired: nach Ableben des Patienten bis Ende der Aufbewahrungsfrist"

* mode 1..1 MS
* mode = #working (exactly)
* mode ^short = "Der Medikationsplan ist ein laufend gepflegtes Dokument. Fixer Wert: working."

* title 0..0
* title ^short = "Der Medikationsplan hat keinen Titel."

* code 1..1 MS 
* code = $cs-sct#736378000 "Medikationsplan" (exactly)
* code ^short = "Code, der den Typ der Liste beschreibt."

* subject 1..1 MS
* subject only Reference(AtElgaCorePatient) // TODO ELGA Patient ableiten
* subject ^short = "ELGA-Teilnehmer, für den der Medikationsplan dokumentiert wird."

* encounter 0..0
* encounter ^short = "Es wird kein Behandlungskontext dokumentiert."

* date 1..1 MS
* date ^short = "Letzte Aktualisierung des Medikationsplans."

* source 1..1 MS
* source only Reference(AtElgaCorePractitioner or AtElgaCorePractitionerRole or Device or AtElgaCorePatient)  // TODO ELGA Profile
* source ^short = "Ersteller des Medikationsplans und für den Inhalt verantwortlich. 
Im Falle eines GDA: Eindeutig identifiziert über den GDA-Index und berechtigt auf die e-Medikation 
des Patienten zuzugreifen. Device nur für initiale Erstellung durch die Fachanwendung. ELGA-Teilnehmer nur Ausübung seiner Teilnehmerrechte (Löschen von Einträgen)."

* orderedBy 0..0 
* orderedBy ^short = "Die Reihenfolge der Einträge wird über die List.entries durch den Ersteller vorgegeben."
// * orderedBy 1..1 MS  
// * orderedBy from http://hl7.org/fhir/ValueSet/list-order 
// * orderedBy = #user
// * orderedBy ^short = "Dokumentiert, wie die Reihenfolge der Einträge festgelegt wurde."
// Mögliche Codes: user | system | event-date | entry-date| priority | alphabetic | category | patient"

* note 0..0 
* note ^short = "Keine Freitext-Anmerkungen im Medikationsplan." 

// --- Entries ---
* entry 0..* MS
* entry ^short = "Medikationsplaneinträge. Die Reihenfolge der Medikationsplaneinträge ist fachlich relevant und wird durch den Ersteller durch die Reihung der Eintries festgelegt."

* entry.flag 1..1 MS
* entry.flag from ElgaListEntryFlagVS
* entry.flag ^short = "Kennzeichnet die Art der Änderung des Medikationsplaneintrags: [New | Unchanged | Changed | Removed] Bedeutung: New: Neuer Planeintrag wird hinzugefügt | Unchanged: Bestehender Planeintrag wird beibehalten und zur Kenntnis genommen | Changed: Bestehender Planeintrag wird geändert | Removed: Bestehender Planeintrag wird entfernt"

* entry.deleted 0..0 
* entry.deleted ^short = "Keine Verwendung im Medikationsplan (da list.mode immer working)."
//Kann nur verwendet werden, wenn list.mode = changes

* entry.date 0..0 
* entry.date ^short = "Kein Datum der Aufnahme bzw. Änderung des Eintrags im Medikationsplan. Das Datum ist nur im referenzierten Medikationsplaneintrag ersichtlich."

* entry.item 1..1 MS
* entry.item only Reference(AtElgaEmedMedicationRequestPlaneintrag)
* entry.item ^short = "Referenz auf einen Medikationsplaneintrag."

* emptyReason 0..1 MS
* emptyReason from ElgaListEmptyReasonVS (required)
* emptyReason ^short = "Begründung, warum der Medikationsplan leer ist. Mögliche Ausprägungen: [notstarted |  nilknown] Bedeutung: notstarted: Intitalzustand - noch nie befüllt | nilknown: Patient nimmt derzeit keine Medikamente ein"