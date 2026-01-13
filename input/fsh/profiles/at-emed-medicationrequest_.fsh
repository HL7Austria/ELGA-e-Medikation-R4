Profile: AtEmedMedicationRequest
Parent: MedicationRequestEuMpd
Id: at-emed-medicationrequest
Title: "ELGA e-Medikation MedicationRequest"
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

// //* priorPrescription ^short = "In case of a modification, takes a reference to the MedicationRequests that has been replaced. | Im Falle einer Änderung wird ein Verweis auf die ersetzte Verordnungen/MedicationRequests aufgenommen."

// * groupIdentifier 1..1
// * groupIdentifier ^short = "eMed-ID" //austria specific

// * status = #completed 
// * status ^short = "For CDA compatability: always completed, even if the prescription is still be acted upon. | Für CDA-Kompatibilität: immer abgeschlossen, auch wenn das Rezept noch bearbeitet werden muss."

// * intent = #order
// * intent ^short = "	The prescription represents a request/demand and authorization for action by the requestor. | Das Rezept stellt eine Anfrage/Anforderung und Ermächtigung zum Handeln durch den Antragsteller dar."

// * medication.reference 0..0
// * medication.concept 1..1 
// * medication from $asp-liste 
// * medication ^short = "Medication in conformance with the ELGA e-Medication used PZN (i.e. ASP-Liste). | Arzneimittel entsprechend der ELGA e-Medikation verwendet PZN (d.h. ASP-Liste)."

// * subject only Reference(HL7ATCorePatient) 
// * subject ^short = "Each MedicationRequest is associated with one HL7 Austria patient. | Jede Verordnung/MedicationRequest ist einem HL7 AustriaPatient zugewiesen."

// //* basedOn 0..1
// //* basedOn only Reference(LINCAProposalMedicationRequest)   
// //* basedOn ^short = "Proposal item this prescription is based on. Leave empty for ad-hoc prescriptions, or if an existing prescription is to be corrected by this item (in this case, use the priorPrescription attribute)"

// * requester 1..1
// * requester only Reference(Practitioner) 
// * requester ^short = "ToDo create austrian practitioner with hl7 austria. || The authorizing practitioner for this prescription, identified by their OID according to GDA Index. | Der approbierende Arzt für diese Verschreibung, identifiziert durch seine OID gemäß GDA-Index."

// //* supportingInformation ^short = "First Element is reserved for reference to origin (LINCARequestOrchestration) assigned on LinkedCare Platform. Used to link instantiated proposal items back to the proposal header (LINCARequestOrchestration)."

// * note ^short = "CDA eMed v2: ZINFO || not machine readable Information about the MedicationRequests | nicht maschinenlesbare Informationen über die Verordnung"

// * effectiveDosePeriod ^short = "Period over which the medication is to be taken | Zeitraum, über den das Medikament eingenommen werden soll"

// * dosageInstruction ^short = "One or more specific instructions for how the medication should be taken | Eine oder mehrere spezifische Anweisungen für die Einnahme des Medikaments"
// * dosageInstruction.patientInstruction ^short = "CDA eMed v2: ALTEIN || Patient or consumer oriented instructions | Patienten- oder verbraucherorientierte Anweisungen"
// * dosageInstruction.timing.repeat.frequency ^short = "Repetitions within the period | Wiederholungen innerhalb der Dauer"
// * dosageInstruction.timing.repeat.period ^short = "A defined period with its duration to which the frequency applies | Ein bestimmter Zeitraum mit seiner Dauer, für den die Wiederholungen gelten"
// * dosageInstruction.timing.repeat.periodUnit ^short = "Unit of period | Einheit zur Dauer"
// * dosageInstruction.timing.repeat.when from http://hl7.org/fhir/ValueSet/event-timing
// * dosageInstruction.timing.repeat.when ^short = "Code for time period of occurrence | Code für die Eintrittszeitspanne"
// * dosageInstruction.asNeeded ^short = "Take 'as needed' | Bedarfsmedikation"

// * dosageInstruction.doseAndRate.doseQuantity.value ^short = "Quantity per intake | Menge pro Einnahme"
// * dosageInstruction.doseAndRate.doseQuantity.unit ^short = "Unit for quantity per intake | Einheit zur Menge pro Einnahme"
// //* dosageInstruction.doseAndRate.doseQuantity.code from $DoseForm (extensible)
// * dosageInstruction.doseAndRate.rate[x] ^short = "Do not use any rate element for repetitions, period or any other time related information. Use timing instead. | Verwenden Sie für Wiederholungen, Perioden oder andere zeitbezogene Informationen keine der rate-Elemente. Verwenden Sie stattdessen timing."
// * dosageInstruction.doseAndRate.rateRatio 0..0
// * dosageInstruction.doseAndRate.rateRange 0..0
// * dosageInstruction.doseAndRate.rateQuantity 0..0

// * dispenseRequest.numberOfRepeatsAllowed ^short = "	Number of refills authorized | Anzahl der genehmigten Einlösungen"