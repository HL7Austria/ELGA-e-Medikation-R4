Profile: AtElgaEmedListMedikationsplan 
Parent: List 
Id: at-elga-emed-list-medikationsplan
Title: "AT ELGA e-Medikation List Medikationsplan"
Description: "Der Medikationsplan wird durch eine List-Ressource abgebildet. 
Diese enthält 0..* Einträge (List.entry), wobei jedes List.entry.item genau eine Referenz auf einen Medikationsplaneintrag (MedicationRequest) beinhaltet.
Die Reihung der List.entries bestimmt die Reihenfolge der Medikationsplaneinträge. 
Jeder Listeneintrag enthält im Element List.entry.flag den Änderungsstatus des jeweiligen Medikationsplaneintrags."

* id 1..1 MS
* meta MS
* text MS
//ASW 24.09.2026 TODO text 1..1
* implicitRules 0..0
* extension contains AtElgaEmedExtensionPatientModified named PatientModified 0..1 MS
* extension[PatientModified] ^short = "Boolean der angibt, ob diese Version des Plans durch Aktionen des Patienten verändert wurde (z.B. Einträge entfernt)."
* obeys at-emed-list-same-patient

* status 1..1 MS
* status from ElgaListStatusVS (required)
* status ^short = "Status des Medikationsplans. Mögliche Ausprägungen: [current | retired] Bedeutung: current: default | retired: nach Ableben des Patienten bis Ende der Aufbewahrungsfrist"

* mode 1..1 MS
* mode = #working (exactly)
* mode ^short = "Der Medikationsplan ist ein laufend gepflegtes Dokument. Fixer Wert: working."

* code 1..1 MS 
* code = $cs-sct#736378000 "Medikationsplan" (exactly)
* code ^short = "Code der den Medikationsplan identifiziert"

* subject 1..1 MS
* subject only Reference(AtElgaCorePatient) // TODO ELGA Patient ableiten
* subject ^short = "ELGA-Teilnehmer, für den der Medikationsplan dokumentiert wird."

* encounter 0..0
* encounter ^short = "Fachliche Begründung: Es wird derzeit kein Behandlungskontext dokumentiert."

* date 1..1 MS
* date ^short = "Letzte Aktualisierung des Medikationsplans."

* source 1..1 MS
//ASW 22.09.2026 Patient nicht mehr möglich -> durch patientmodified abgebildet
* source only Reference(AtElgaCorePractitioner or AtElgaCorePractitionerRole or AtElgaEmedDeviceFachanwendung)
* source ^short = "Ersteller des Medikationsplans und für den Inhalt verantwortlich. Device nur für initiale Erstellung durch die Fachanwendung."

* orderedBy 0..0
* encounter ^short = "Fachliche Begründung: TODO"
//ASW 22.09.2026 .orderedBy fachlich gelöscht
//ASW 24.09.2026 TODO: Fachliche Begründung? - eigentlich sollte hier eher ein fixed value verwendet werden?
// * orderedBy ^short = "Die Reihenfolge der Einträge wird über die List.entries durch den Ersteller vorgegeben."
// * orderedBy 1..1 MS  
// * orderedBy from http://hl7.org/fhir/ValueSet/list-order 
// * orderedBy = #user
// * orderedBy ^short = "Dokumentiert, wie die Reihenfolge der Einträge festgelegt wurde."
// Mögliche Codes: user | system | event-date | entry-date| priority | alphabetic | category | patient"

//ASW 22.09.2026 .note fachlich gelöscht
* note 0..0 
* note ^short = "Fachliche Begrüundung: Auf dieser Ebene keine Freitext-Anmerkungen im Medikationsplan. Freitext ist in den jeweiligen MedicationRequests(Planeinträgen möglich)" 

// --- Entries ---
* entry 0..* MS
* entry ^short = "Medikationsplaneinträge. Die Reihenfolge der Medikationsplaneinträge ist fachlich relevant und wird durch den Ersteller durch die Reihung der Eintries festgelegt."

* entry.flag 1..1 MS
* entry.flag from ElgaListEntryFlagVS
* entry.flag ^short = "Kennzeichnet die Art der Änderung des Medikationsplaneintrags: [New | Unchanged | Changed | Removed] Bedeutung: New: Neuer Planeintrag wird hinzugefügt | Unchanged: Bestehender Planeintrag wird beibehalten und zur Kenntnis genommen | Changed: Bestehender Planeintrag wird geändert | Removed: Bestehender Planeintrag wird entfernt"

* entry.deleted 0..0 
//ASW 22.09.2026 * entry.deleted fachlich gelöscht
* entry.deleted ^short = "Fachliche Begründung: Keine Verwendung im Medikationsplan (da list.mode immer working)."
//Kann nur verwendet werden, wenn list.mode = changes

* entry.date 0..0 
//ASW 22.09.2026 * entry.date fachlich gelöscht
//ASW 24.09.2026 relevant für directory search?
* entry.date ^short = "Fachliche Begründung: Kein Datum der initialen Aufnahme des Eintrags im Medikationsplan.
Das Datum ist nur im referenzierten Medikationsplaneintrag ersichtlich."

* entry.item 1..1 MS
* entry.item only Reference(AtElgaEmedMedicationRequestPlaneintrag)
* entry.item ^short = "Referenz auf einen Medikationsplaneintrag."

* emptyReason 0..1 MS
* emptyReason from ElgaListEmptyReasonVS (required)
//ASW 22.09.2026 code unavailable hinzufügen für den Fall, dass der Patient alle Einträge entfernt
* emptyReason ^short = "Begründung, warum der Medikationsplan leer ist. Mögliche Ausprägungen: [notstarted |  nilknown | unavailable] Bedeutung: notstarted: Intitalzustand - noch nie befüllt | nilknown: Patient nimmt derzeit keine Medikamente ein | unavailable: Plan ist leer weil alle Einträge vom Patienten entfernt wurden"

Invariant: at-emed-list-same-patient
Description: "Alle in der Liste referenzierten Patienten müssen gleich sein"
* severity = #error
* expression = "subject.resolve() = entry.item.resolve().ofType(MedicationRequest).subject.resolve()"