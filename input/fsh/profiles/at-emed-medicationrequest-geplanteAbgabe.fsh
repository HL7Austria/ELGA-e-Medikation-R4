Profile: AtEmedMedicationRequestGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-medicationrequest-geplanteAbgabe
Title: "ELGA e-Medikation Geplante Abgabe"
Description: "**Beschreibung:** Bildet eine geplante Abgabe eines Arzneimittels aus dem zugrundeliegenden Medikationsplaneintrag des ELGA-Teilnehmers ab.
Sie enthält das verordnete Arzneimittel und dessen Dosierung und spielgelt die Inhalte des e-Rezepts wider. 
Geplante Abgaben dienen somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation.
Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), die auch im e-Rezept mitgeführt wird.
Werden mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."
* . ^short = "Geplante Abgabe eines Arzneimittels aus dem Medikationsplan."

// Vorgaben APS ***************************
// impose Profile APS 
// * ^extension[$imposeProfile].valueCanonical = Canonical(AtApsMedicationRequest)
// * medication[x] only CodeableConcept or Reference(AtApsMedication)
// * subject only Reference(AtApsPatient)
// Ende Vorgaben APS ***************************


// Vorgaben MPD ***************************
// * insert MedicationRequestEpCommon
// * medication[x] only CodeableConcept or Reference(AtEmedMedication) //MedicationEuMpd)
// * reasonCode ^short = "Reason or indication for this prescription"
//   * ^binding.extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
//   * ^binding.extension[0].extension[0].url = "purpose"
//   * ^binding.extension[=].extension[=].valueCode = #candidate
//   * ^binding.extension[=].extension[+].url = "valueSet"
//   * ^binding.extension[=].extension[=].valueCanonical = $eHDSIIllnessandDisorder
//   * ^binding.extension[=].extension[+].url = "documentation"
//   * ^binding.extension[=].extension[=].valueMarkdown = """MyHealth@EU crossborder value set for diagnoses. Based on WHO ICD 10."""

// * reasonReference ^short = "Condition or observation that supports this prescription"

// * extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
// * extension[effectiveDosePeriod] ^short = "Period over which the medication should be taken."
// * extension[effectiveDosePeriod] ^definition = "Period over which the medication should be taken. Where there are multiple dosageInstruction lines (for example, tapering doses), this is the earliest date and the latest end date of the dosageInstructions."

// * extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
// * extension[renderedDosageInstruction] ^short = "Full representation of the dosage instructions"
// Ende Vorgaben MPD ***************************


// MedicationRequest 
* identifier 1..* MS
* identifier ^short = "Geplante-Abgabe-ID (früher eMed-ID), bildet 'Rezept-Klammer' bei mehreren gleichzeitig ausgestellten geplanten Abgaben."

* status ^short = "Status der geplanten Abgabe (im Standardfall active oder complete): active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown" 
* statusReason 0..0 

* statusReason ^short = "Grund für den aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt eine Anforderung und Ermächtigung zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

* category 0..0
* category ^short = "Art der Medikamentenanforderung (z.B. ambulante oder stationäre Einnahme oder Verabreichung)"

* priority 0..0
* priority ^short = "Priorität der geplanten Abgabe: routine | urgent | asap | stat. Keine Verwendung in der geplanten Abgabe."

* doNotPerform 0..0
* doNotPerform ^short = "Gibt an, ob die geplante Abgabe untersagt ist. Keine Verwendung in der geplanten Abgabe."

* reported[x] 0..0
* reported[x] ^short = "Keine Verwendung in der geplanten Abgabe."

// --- Medication Choice: Code (PZN) ODER Medication-Resource ---
* medication[x] 1..1 MS
* medication[x] only CodeableConcept or Reference(AtEmedMedication)

// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS
* medicationCodeableConcept from $cs-asp-liste (required)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1..1
* medicationCodeableConcept.coding.system 1..1
* medicationCodeableConcept.coding.code 1..1
* medicationCodeableConcept.coding.display 1..1 MS

// Reference-Variante für magistrale/Infusionen
* medicationReference 0..1 MS
* medicationReference only Reference(AtEmedMedication)
* medicationReference ^short = "Bei magistralen Anwendungen oder Infusionen ohne PZN."
* obeys med-1

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Österreichischer Patient für den die geplante Abgabe ausgestellt wird."

* encounter 0..0
* encounter ^short = "Keine Verwendung in der geplanten Abgabe."

* supportingInformation 0..0
* supportingInformation ^short = "Keine Verwendung in der geplanten Abgabe."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung der geplanten Abgabe."

// -- Requester ---
* requester 1..1 MS
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Der Arzt oder die Ärztin, die die geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist."

* performer 0..0 
* performer ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* reasonCode 0..*
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. Annahme: Keine Verwendung in der geplanten Abgabe, reasonReference ausreichend."

* reasonReference 0..* MS
* reasonReference ^short = "Grund für die Verordnung des Arzneimittels (Referenz). Verwendung erst, wenn e-Diagnose referenzierbar ist."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1
* basedOn only Reference(AtEmedMedicationRequestPlaneintrag)
* basedOn ^short = "Referenz auf den zugrundeliegenden Medikationsplaneintrag, auf dem diese geplante Abgabe basiert."

* groupIdentifier 0..1 
* groupIdentifier ^short = "Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), die auch im e-Rezept mitgeführt wird. Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."

* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Evtl. im Planeintrag (dosageInstruction), paused soll im Status dokumentiert werden."

* insurance 0..0
* insurance ^short = "Keine Verwendung in der geplanten Abgabe."

* note 0..* 
* insurance ^short = "Zusätzliche Informationen zur geplanten Abgabe, die durch die anderen Attribute nicht abgebildet werden konnten. Dzt. unklar, ob erforderlich."

* dosageInstruction 0..* 
* dosageInstruction ^short = "Anweisungen zur Einnahme/Verabreichung des Arzneimittels."


* dosageInstruction ^comment = "There are examples where a medication request may include the option of an oral dose or an Intravenous or Intramuscular dose.  For example, \"Ondansetron 8mg orally or IV twice a day as needed for nausea\" or \"Compazine® (prochlorperazine) 5-10mg PO or 25mg PR bid prn nausea or vomiting\".  In these cases, two medication requests would be created that could be grouped together.  The decision on which dose and route of administration to use is based on the patient's condition at the time the dose is needed."
// * dispenseRequest 0..1 BackboneElement^^ "Medication supply authorization" "Indicates the specific details for the dispense or medication supply part of a medication request (also known as a Medication Prescription or Medication Order).  Note that this information is not always sent with the order.  There may be in some settings (e.g. hospitals) institutional or system support for completing the dispense details in the pharmacy department."
// * dispenseRequest.initialFill 0..1 BackboneElement "First fill details" "Indicates the quantity or duration for the first dispense of the medication."
// * dispenseRequest.initialFill ^comment = "If populating this element, either the quantity or the duration must be included."
// * dispenseRequest.initialFill.quantity 0..1 http://hl7.org/fhir/StructureDefinition/SimpleQuantity "First fill quantity" "The amount or quantity to provide as part of the first dispense."
// * dispenseRequest.initialFill.duration 0..1 Duration "First fill duration" "The length of time that the first dispense is expected to last."
// * dispenseRequest.dispenseInterval 0..1 Duration "Minimum period of time between dispenses" "The minimum period of time that must occur between dispenses of the medication."
// * dispenseRequest.validityPeriod 0..1 Period "Time period supply is authorized for" "This indicates the validity period of a prescription (stale dating the Prescription)."
// * dispenseRequest.validityPeriod ^comment = "It reflects the prescribers' perspective for the validity of the prescription. Dispenses must not be made against the prescription outside of this period. The lower-bound of the Dispensing Window signifies the earliest date that the prescription can be filled for the first time. If an upper-bound is not specified then the Prescription is open-ended or will default to a stale-date based on regulations."
// * dispenseRequest.validityPeriod ^requirements = "Indicates when the Prescription becomes valid, and when it ceases to be a dispensable Prescription."
// * dispenseRequest.numberOfRepeatsAllowed 0..1 unsignedInt "Number of refills authorized" "An integer indicating the number of times, in addition to the original dispense, (aka refills or repeats) that the patient can receive the prescribed medication. Usage Notes: This integer does not include the original order dispense. This means that if an order indicates dispense 30 tablets plus \"3 repeats\", then the order can be dispensed a total of 4 times and the patient can receive a total of 120 tablets.  A prescriber may explicitly say that zero refills are permitted after the initial dispense."
// * dispenseRequest.numberOfRepeatsAllowed ^comment = "If displaying \"number of authorized fills\", add 1 to this number."
// * dispenseRequest.quantity 0..1 http://hl7.org/fhir/StructureDefinition/SimpleQuantity "Amount of medication to supply per dispense" "The amount that is to be dispensed for one fill."
// * dispenseRequest.expectedSupplyDuration 0..1 Duration "Number of days supply per dispense" "Identifies the period time over which the supplied product is expected to be used, or the length of time the dispense is expected to last."
// * dispenseRequest.expectedSupplyDuration ^comment = "In some situations, this attribute may be used instead of quantity to identify the amount supplied by how long it is expected to last, rather than the physical quantity issued, e.g. 90 days supply of medication (based on an ordered dosage). When possible, it is always better to specify quantity, as this tends to be more precise. expectedSupplyDuration will always be an estimate that can be influenced by external factors."
// * dispenseRequest.performer 0..1 Reference(http://hl7.org/fhir/StructureDefinition/Organization) "Intended dispenser" "Indicates the intended dispensing Organization specified by the prescriber."
// * substitution 0..1 BackboneElement "Any restrictions on medication substitution" "Indicates whether or not substitution can or should be part of the dispense. In some cases, substitution must happen, in other cases substitution must not happen. This block explains the prescriber's intent. If nothing is specified substitution may be done."
// * substitution.allowed[x] 1..1 boolean or CodeableConcept "Whether substitution is allowed or not" "True if the prescriber allows a different drug to be dispensed from what was prescribed."
// * substitution.allowed[x] from http://terminology.hl7.org/ValueSet/v3-ActSubstanceAdminSubstitutionCode (example)
// * substitution.allowed[x] ^comment = "This element is labeled as a modifier because whether substitution is allow or not, it cannot be ignored."
// * substitution.allowed[x] ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * substitution.allowed[x] ^binding.extension.valueString = "MedicationRequestSubstitution"
// * substitution.allowed[x] ^binding.description = "Identifies the type of substitution allowed."
// * substitution.reason 0..1 CodeableConcept "Why should (not) substitution be made" "Indicates the reason for the substitution, or why substitution must or must not be performed."
// * substitution.reason from http://terminology.hl7.org/ValueSet/v3-SubstanceAdminSubstitutionReason (example)
// * substitution.reason ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * substitution.reason ^binding.extension.valueString = "MedicationIntendedSubstitutionReason"
// * substitution.reason ^binding.description = "A coded concept describing the reason that a different medication should (or should not) be substituted from what was prescribed."
// * priorPrescription 0..1 Reference(http://hl7.org/fhir/StructureDefinition/MedicationRequest) "An order/prescription that is being replaced" "A link to a resource representing an earlier order related order or prescription."
* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte Verordnungen/MedicationRequests verwiesen."
// * detectedIssue 0..* Reference(http://hl7.org/fhir/StructureDefinition/DetectedIssue) "Clinical Issue with action" "Indicates an actual or potential clinical issue with or between one or more active or proposed clinical actions for a patient; e.g. Drug-drug interaction, duplicate therapy, dosage alert etc."
// * detectedIssue ^comment = "This element can include a detected issue that has been identified either by a decision support system or by a clinician and may include information on the steps that were taken to address the issue."
// * detectedIssue ^alias[0] = "Contraindication"
// * detectedIssue ^alias[+] = "Drug Utilization Review (DUR)"
// * detectedIssue ^alias[+] = "Alert"
// * eventHistory 0..* Reference(http://hl7.org/fhir/StructureDefinition/Provenance) "A list of events of interest in the lifecycle" "Links to Provenance records for past versions of this resource or fulfilling request or event resources that identify key state transitions or updates that are likely to be relevant to a user looking at the current version of the resource."
// * eventHistory ^comment = "This might not include provenances for all versions of the request – only those deemed “relevant” or important. This SHALL NOT include the provenance associated with this current version of the resource. (If that provenance is deemed to be a “relevant” change, it will need to be added as part of a later update. Until then, it can be queried directly as the provenance that points to this version using _revinclude All Provenances should have some historical version of this Request as their subject.)."




// --- XOR-Invariant: genau eines von beiden ---
Invariant: med-1
Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
Severity: #error



// NIK R5 Spec:

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




