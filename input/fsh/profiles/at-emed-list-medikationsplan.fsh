Profile: AtEmedListMedikationsplan
Parent: List
Id: at-emed-list-medikationsplan
Title: "ELGA e-Medikation Medikationsplan"
Description: "**Beschreibung:** Bildet den Medikationsplan eines ELGA Teilnehmers ab. Enthält verordnete Arzneimittel und deren Dosierung in Form von 0..* Medikationsplaneinträgen (AtEmedMedicationRequestPlaneintrag). Die Reihenfolge der Einträge ist fachlich relevant."

* identifier ^short = "Eindeutige Kennung der Liste. Keine Verwendung in der Liste für den Medikationsplan."

* status 1..1 MS
* status = #current
* status ^short = "Der Medikationsplan ist aktuell: current | retired | entered-in-error. https://hl7.org/fhir/R4/valueset-list-status.html"

* mode 1..1 MS
* mode = #working
* mode ^short = "Der Medikationsplan ist ein Arbeitsdokument: working | snapshot | changes. https://hl7.org/fhir/R4/valueset-list-mode.html"

* code ^short = "Code, der den Typ der Liste beschreibt. https://hl7.org/fhir/R4/valueset-list-example-codes.html. Zu prüfen, ob/wie in Medikationsplan verwendet."
// * code 1..1 MS
// * code.coding 1..1
// * code.coding.system 1..1
// * code.coding.code 1..1
// * code.coding.display 1..1

// * subject 1..1 MS
// * subject only Reference(HL7ATCorePatient)
* subject 0..0
* subject ^short = "Keine Verwendung in der Liste für den Medikationsplan."

* encounter 0..0
* encounter ^short = "Keine Verwendung in der Liste für den Medikationsplan."

* date 0..0
* date ^short = "Letzte Aktualisierung der Liste des Medikationsplans."

// * source 1..1 MS
// * source only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole)
* source 0..0
* source ^short = "Ersteller der Liste des Medikationsplans."

* orderedBy 0..1 MS
* orderedBy from http://hl7.org/fhir/ValueSet/list-order 
* orderedBy = #user
* orderedBy ^short = "Die Reihenfolge der Einträge im Medikationsplan ist fachlich relevant und wird durch den Ersteller der Liste vorgegeben. Mögliche Codes: user | system | event-date | entry-date| priority | alphabetic | category | patient."

// --- Entries ---

* entry.flag 1..1 MS
* entry.flag from http://hl7.org/fhir/ValueSet/list-item-flag
* entry.flag ^short = "Kennzeichnet die Art der Änderung des Medikationsplaneintrags"

* entry.deleted 0..1 MS
* entry.deleted ^short = "Gibt an, ob der referenzierte Medikationsplaneintrag aus dem Medikationsplan entfernt wurde."

* entry 0..* MS
* entry.item 1..1 MS
* entry.item only Reference(AtEmedMedicationRequestPlaneintrag)
* entry.item ^short = "Referenz auf einen Medikationsplaneintrag."

* emptyReason 0..1
* emptyReason ^short = "Grund, warum die Liste keine Einträge enthält. Zu prüfen, ob/wie in Liste des Medikationsplan verwendet."


