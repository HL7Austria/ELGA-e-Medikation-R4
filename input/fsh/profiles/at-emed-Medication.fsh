Profile: AtEmedMedication
Parent: MedicationEuMpd
Id: at-emed-medication
Title: "ELGA e-Medikation Medication"
Description: "**Description:** In the course of treatment, the doctor determines that the ELGA participant must be prescribed one or more medicines. A MedicationRequest always consists of exactly one medication (= one medicine). The e-Medication prescription can consist of several MedicationRequests and thus forms a grouping over them. The prescription and it's MedicationRequests are labelled with one unique, common eMED ID. The doctor is responsible for checking the medicines, e.g. for potential interactions, contraindications, dosages, etc. and this is not part of e-Medication. Storing requests without assigning a prescription is not valid. The prescription is considered to have been checked if the associated prescription is saved in e-Medication.

**Beschreibung:** 
Im Zuge der Behandlung verordnet der GDA dem ELGA Teilnehmer ein Arzneimittel und erstellt einen Medikationsplaneintrag (MedicationRequest). "

// Im Zuge der Behandlung stellt der Arzt fest, dass dem ELGA Teilnehmer ein oder mehrere Arzneimittel verordnet werden müssen. 
// Eine Verordnung besteht immer nur aus genau einer Medikation (= ein Arzneimittel). 
// Das Rezept kann aus mehreren Verordnungen/MedicationRequests bestehen und bildet somit die Klammer über die Verordnungen/MedicationRequests. 
// Das Rezept und seine Verordnungen/MedicationRequests werden mit einer eindeutigen, gemeinsamen eMED-ID versehen. 
// Die Prüfungen der Arzneimittel z.B. auf potentielle Wechselwirkungen, Kontraindikationen, Dosierungen, etc. erfolgt in der Eigenverantwortung des Arztes und ist nicht Gegenstand der e-Medikation. 
// Eine Speicherung von Verordnungen/MedicationRequests ohne Zuordnung eines Rezeptes ist nicht gültig. Die Verordnung/MedicationRequest wird als geprüft angesehen, wenn die zugeordnete Verordnung in e-Medikation gespeichert ist."

// * ^status = #active
// * . ^short = "AT EMED MedicationRequest"
// * ^extension[$imposeProfile].valueCanonical = Canonical(MedicationRequestIPS)
// * medication[x] only CodeableConcept or Reference(AtApsMedication)


// NIK R5 Spec:

//* identifier 1..1
//* identifier ^short = " MedicationRequest ID = {eMed-ID}_{locally assigned ID} |  Verordnungs ID = {eMed-ID}_{lokal vergebene ID}"
