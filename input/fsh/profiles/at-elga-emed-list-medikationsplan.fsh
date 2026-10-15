Profile: AtElgaEmedListMedikationsplan 
Parent: List 
Id: at-elga-emed-list-medikationsplan
Title: "AT ELGA e-Medikation List Medikationsplan"
Description: "Der Medikationsplan wird durch eine List-Ressource abgebildet und enthält:
- 0..* Einträge (List.entry). 
Jedes List.entry.item enhält genau eine Referenz auf einen Medikationsplaneintrag (MedicationRequest).
Die Reihung der List.entries bestimmt die Reihenfolge der Medikationsplaneinträge. 
Jeder Listeneintrag enthält im Element List.entry.flag den Änderungsstatus des jeweiligen Medikationsplaneintrags."

* id 1..1 MS
* id ^short = "Technische id der Ressource"
* meta MS
* meta.versionId MS
* meta.lastUpdated MS
* meta.profile 1..1 MS
* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

// ws: meta.version.id = kann für etag verwendet werden
//* id + meta für etag

//ASW 24.09.2026 TODO text 1..1
* text MS
* text.div MS
* text.status MS

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* extension contains AtElgaEmedExtensionPatientModified named PatientModified 0..1 MS
* extension[PatientModified] ^short = "Boolean der angibt, ob diese Version des Plans durch Aktionen des Patienten verändert wurde (z.B. Einträge entfernt)."
* extension[PatientModified].valueBoolean MS
* extension[PatientModified].url MS

//ASW 11.10.2026 TODO Invariante prüfen
* obeys at-emed-list-same-patient

* status 1..1 MS
* status = #current
* status ^short = "Status des Medikationsplans. Fixer Wert: current"

* mode 1..1 MS
* mode = #working (exactly)
* mode ^short = "Der Medikationsplan ist ein laufend gepflegtes Dokument. Fixer Wert: working."


* code 1..1 MS 
* code ^short = "Code der den Medikationsplan identifiziert"
* code.coding 1..1 MS
* code.coding.code 1..1 MS
* code.coding.code = #736378000 (exactly)
* code.coding.system 1..1 MS
* code.coding.system = $cs-sct
* code.coding.display MS
//ASW 11.10.2026 TODO ist * code.coding.version MS?
* code.coding.version MS
* code.text 0..0
* code.text ^short = "Fachliche Begründung: TODO"

* subject 1..1 MS
* subject ^short = "ELGA-Teilnehmer, für den der Medikationsplan dokumentiert wird."
* subject only Reference(AtElgaCorePatient) // TODO ELGA Patient ableiten
* subject.reference MS
* subject.type MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
* subject.identifier.use ^short = "Fachliche Begründung: TODO"
//ASW 11.10.2026 TODO subject.identifier.type MS?
//* subject.identifier.type MS

//ASW 11.10.2026 TODO Invariante sodass entweder Reference.reference XOR Reference.identifier befüllt sein muss

* encounter 0..0
* encounter ^short = "Fachliche Begründung: Es wird derzeit kein Behandlungskontext dokumentiert."

* date 0..1 MS
* date ^short = "Letzte Aktualisierung des Medikationsplans."

* source 1..1 MS
//ASW 22.09.2026 Patient nicht mehr möglich -> durch patientmodified abgebildet
* source only Reference(AtElgaCorePractitioner or AtElgaCorePractitionerRole or AtElgaEmedDeviceFachanwendung)
* source ^short = "Ersteller des Medikationsplans und für den Inhalt verantwortlich. Device nur für initiale Erstellung durch die Fachanwendung."
* source.reference MS
* source.type MS
* source.identifier MS
* source.identifier.system MS
* source.identifier.value MS
* source.identifier.use 0..0
* source.identifier.use ^short = "Fachliche Begründung: TODO"
//ASW 11.10.2026 TODO Invariante sodass entweder Reference.reference XOR Reference.identifier befüllt sein muss


* orderedBy 0..0
* orderedBy ^short = "Fachliche Begründung: TODO"

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
* entry.flag.coding MS
* entry.flag.coding 1..1
* entry.flag.coding.code MS
* entry.flag.coding.code 1..1
* entry.flag.coding.system MS
* entry.flag.coding.system 1..1
* entry.flag.coding.display MS
//ASW 11.10.2026 TODO ist * entry.flag.coding.version MS?
* entry.flag.coding.version MS
* entry.flag ^short = "Kennzeichnet die Art der Änderung des Medikationsplaneintrags: [New | Unchanged | Changed | Removed] Bedeutung: New: Neuer Planeintrag wird hinzugefügt | Unchanged: Bestehender Planeintrag wird beibehalten und zur Kenntnis genommen | Changed: Bestehender Planeintrag wird geändert | Removed: Bestehender Planeintrag wird entfernt"
* entry.flag.text 0..0
* entry.flag.text ^short = "Fachliche Begründung: TODO"

* entry.deleted 0..0 
//ASW 22.09.2026 * entry.deleted fachlich gelöscht
* entry.deleted ^short = "Fachliche Begründung: Keine Verwendung im Medikationsplan (da list.mode immer working)."
//Kann nur verwendet werden, wenn list.mode = changes

* entry.date 0..0 
//ASW 22.09.2026 * entry.date fachlich gelöscht
//ASW 24.09.2026 relevant für directory search?
* entry.date ^short = "Fachliche Begründung: Das Datum der initialen Aufnahme eines Eintrags wird nicht auf Ebene der Liste dokumentiert. Datumsinformationen werden im referenzierten Medikationsplaneintrag dokumentiert."

* entry.item 1..1 MS
* entry.item only Reference(AtElgaEmedMedicationRequestPlaneintrag)
* entry.item ^short = "Referenz auf einen Medikationsplaneintrag."
* entry.item.reference MS
* entry.item.reference 1..1

* emptyReason 0..1 MS
* emptyReason from ElgaListEmptyReasonVS (required)
* emptyReason ^short = "Begründung, warum der Medikationsplan leer ist. Mögliche Ausprägungen: [notstarted |  nilknown ] Bedeutung: notstarted: Intitalzustand - noch nie befüllt; nilknown: Der Plan wurde vom GDA explizit als leer dokumentiert oder alle Einträge wurden abgesetzt, storniert oder gelöscht."
* emptyReason.coding MS
* emptyReason.coding 1..1
* emptyReason.coding.code MS
* emptyReason.coding.code 1..1
* emptyReason.coding.system MS
* emptyReason.coding.system 1..1
* emptyReason.coding.display MS
//ASW 11.10.2026 TODO ist * emptyReason.coding.version MS?
* emptyReason.coding.version MS
* emptyReason.text 0..0
* emptyReason.text ^short = "Fachliche Begründung: TODO"


Invariant: at-emed-list-same-patient
Description: "Alle in der Liste referenzierten Patienten müssen gleich sein"
* severity = #error
* expression = "subject.resolve() = entry.item.resolve().ofType(MedicationRequest).subject.resolve()"