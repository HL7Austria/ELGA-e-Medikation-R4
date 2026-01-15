Profile: AtEmedMedicationRequestGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-medicationrequest-geplanteAbgabe
Title: "ELGA e-Medikation geplante Abgabe"
Description: "**Beschreibung:**Bildet eine geplante Abgabe eines Arzneimittels aus dem entsprechendem Medikationsplaneintrag des ELGA Teilnehmers ab (Rezeptierung). Sie enthält das verordnetes Arzneimittel und dessen Dosierung, der Status ist bei Ausstellung aktiv. 
Als groupIdentifier dient die eMED-ID, die auch im e-Rezept mitgeführt wird.
Werden mehrere Arzneimittel gleichzeitig verordnet, so wird für jedes Arzneimittel eine eigene geplante Abgabe erstellt, der groupIdentifier ist aber für diese geplanten Abgaben gleich (Bildet 'Rezept-Klammer')."

* status ^short = "active | aktiv"

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




// medicationrequest resource

// * identifier 0..* Identifier "External ids for this request" "Identifiers associated with this medication request that are defined by business processes and/or used to refer to it when a direct URL reference to the resource itself is not appropriate. They are business identifiers assigned to this resource by the performer or other systems and remain constant as the resource is updated and propagates from server to server."
// * identifier ^comment = "This is a business identifier, not a resource identifier."
// * status 1..1 ?! SU code "active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown" "A code specifying the current state of the order.  Generally, this will be active or completed state."
// * status from http://hl7.org/fhir/ValueSet/medicationrequest-status|4.0.1 (required)
// * status ^comment = "This element is labeled as a modifier because the status contains codes that mark the resource as not currently valid."
// * status ^isModifierReason = "This element is labeled as a modifier because it is a status element that contains status entered-in-error which means that the resource should not be treated as valid"
// * status ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * status ^binding.extension.valueString = "MedicationRequestStatus"
// * status ^binding.description = "A coded concept specifying the state of the prescribing event. Describes the lifecycle of the prescription."
// * statusReason 0..1 CodeableConcept "Reason for current status" "Captures the reason for the current state of the MedicationRequest."
// * statusReason from http://hl7.org/fhir/ValueSet/medicationrequest-status-reason (example)
// * statusReason ^comment = "This is generally only used for \"exception\" statuses such as \"suspended\" or \"cancelled\". The reason why the MedicationRequest was created at all is captured in reasonCode, not here."
// * statusReason ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * statusReason ^binding.extension.valueString = "MedicationRequestStatusReason"
// * statusReason ^binding.description = "Identifies the reasons for a given status."
// * intent 1..1 ?! SU code "proposal | plan | order | original-order | reflex-order | filler-order | instance-order | option" "Whether the request is a proposal, plan, or an original order."
// * intent from http://hl7.org/fhir/ValueSet/medicationrequest-intent|4.0.1 (required)
// * intent ^comment = "It is expected that the type of requester will be restricted for different stages of a MedicationRequest.  For example, Proposals can be created by a patient, relatedPerson, Practitioner or Device.  Plans can be created by Practitioners, Patients, RelatedPersons and Devices.  Original orders can be created by a Practitioner only.\r\rAn instance-order is an instantiation of a request or order and may be used to populate Medication Administration Record.\r\rThis element is labeled as a modifier because the intent alters when and how the resource is actually applicable."
// * intent ^isModifierReason = "This element changes the interpretation of all descriptive attributes. For example \"the time the request is recommended to occur\" vs. \"the time the request is authorized to occur\" or \"who is recommended to perform the request\" vs. \"who is authorized to perform the request"
// * intent ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * intent ^binding.extension.valueString = "MedicationRequestIntent"
// * intent ^binding.description = "The kind of medication order."
// * category 0..* CodeableConcept "Type of medication usage" "Indicates the type of medication request (for example, where the medication is expected to be consumed or administered (i.e. inpatient or outpatient))."
// * category from http://hl7.org/fhir/ValueSet/medicationrequest-category (example)
// * category ^comment = "The category can be used to include where the medication is expected to be consumed or other types of requests."
// * category ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * category ^binding.extension.valueString = "MedicationRequestCategory"
// * category ^binding.description = "A coded concept identifying the category of medication request.  For example, where the medication is to be consumed or administered, or the type of medication treatment."
// * priority 0..1 SU code "routine | urgent | asap | stat" "Indicates how quickly the Medication Request should be addressed with respect to other requests."
// * priority from http://hl7.org/fhir/ValueSet/request-priority|4.0.1 (required)
// * priority ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * priority ^binding.extension.valueString = "MedicationRequestPriority"
// * priority ^binding.description = "Identifies the level of importance to be assigned to actioning the request."
// * doNotPerform 0..1 ?! SU boolean "True if request is prohibiting action" "If true indicates that the provider is asking for the medication request not to occur."
// * doNotPerform ^comment = "If do not perform is not specified, the request is a positive request e.g. \"do perform\"."
// * doNotPerform ^isModifierReason = "This element is labeled as a modifier because this element negates the request to occur (ie, this is a request for the medication not to be ordered or prescribed, etc)"
// * reported[x] 0..1 SU boolean or Reference(http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/Practitioner or http://hl7.org/fhir/StructureDefinition/PractitionerRole or http://hl7.org/fhir/StructureDefinition/RelatedPerson or http://hl7.org/fhir/StructureDefinition/Organization) "Reported rather than primary record" "Indicates if this record was captured as a secondary 'reported' record rather than as an original primary source-of-truth record.  It may also indicate the source of the report."
// * medication[x] 1..1 SU CodeableConcept or Reference(http://hl7.org/fhir/StructureDefinition/Medication) "Medication to be taken" "Identifies the medication being requested. This is a link to a resource that represents the medication which may be the details of the medication or simply an attribute carrying a code that identifies the medication from a known list of medications."
// * medication[x] from http://hl7.org/fhir/ValueSet/medication-codes (example)
// * medication[x] ^comment = "If only a code is specified, then it needs to be a code for a specific product. If more information is required, then the use of the Medication resource is recommended.  For example, if you require form or lot number or if the medication is compounded or extemporaneously prepared, then you must reference the Medication resource."
// * medication[x] ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * medication[x] ^binding.extension.valueString = "MedicationCode"
// * medication[x] ^binding.description = "A coded concept identifying substance or product that can be ordered."
// * subject 1..1 SU Reference(http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/Group) "Who or group medication request is for" "A link to a resource representing the person or set of individuals to whom the medication will be given."
// * subject ^comment = "The subject on a medication request is mandatory.  For the secondary use case where the actual subject is not provided, there still must be an anonymized subject specified."
// * encounter 0..1 Reference(http://hl7.org/fhir/StructureDefinition/Encounter) "Encounter created as part of encounter/admission/stay" "The Encounter during which this [x] was created or to which the creation of this record is tightly associated."
// * encounter ^comment = "This will typically be the encounter the event occurred within, but some activities may be initiated prior to or after the official completion of an encounter but still be tied to the context of the encounter.\"    If there is a need to link to episodes of care they will be handled with an extension."
// * supportingInformation 0..* Reference(http://hl7.org/fhir/StructureDefinition/Resource) "Information to support ordering of the medication" "Include additional information (for example, patient height and weight) that supports the ordering of the medication."
// * authoredOn 0..1 SU dateTime "When request was initially authored" "The date (and perhaps time) when the prescription was initially written or authored on."
// * requester 0..1 SU Reference(http://hl7.org/fhir/StructureDefinition/Practitioner or http://hl7.org/fhir/StructureDefinition/PractitionerRole or http://hl7.org/fhir/StructureDefinition/Organization or http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/RelatedPerson or http://hl7.org/fhir/StructureDefinition/Device) "Who/What requested the Request" "The individual, organization, or device that initiated the request and has responsibility for its activation."
// * performer 0..1 Reference(http://hl7.org/fhir/StructureDefinition/Practitioner or http://hl7.org/fhir/StructureDefinition/PractitionerRole or http://hl7.org/fhir/StructureDefinition/Organization or http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/Device or http://hl7.org/fhir/StructureDefinition/RelatedPerson or http://hl7.org/fhir/StructureDefinition/CareTeam) "Intended performer of administration" "The specified desired performer of the medication treatment (e.g. the performer of the medication administration)."
// * performerType 0..1 SU CodeableConcept "Desired kind of performer of the medication administration" "Indicates the type of performer of the administration of the medication."
// * performerType from http://hl7.org/fhir/ValueSet/performer-role (example)
// * performerType ^comment = "If specified without indicating a performer, this indicates that the performer must be of the specified type. If specified with a performer then it indicates the requirements of the performer if the designated performer is not available."
// * performerType ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * performerType ^binding.extension.valueString = "MedicationRequestPerformerType"
// * performerType ^binding.description = "Identifies the type of individual that is desired to administer the medication."
// * recorder 0..1 Reference(http://hl7.org/fhir/StructureDefinition/Practitioner or http://hl7.org/fhir/StructureDefinition/PractitionerRole) "Person who entered the request" "The person who entered the order on behalf of another individual for example in the case of a verbal or a telephone order."
// * reasonCode 0..* CodeableConcept "Reason or indication for ordering or not ordering the medication" "The reason or the indication for ordering or not ordering the medication."
// * reasonCode from http://hl7.org/fhir/ValueSet/condition-code (example)
// * reasonCode ^comment = "This could be a diagnosis code. If a full condition record exists or additional detail is needed, use reasonReference."
// * reasonCode ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * reasonCode ^binding.extension.valueString = "MedicationRequestReason"
// * reasonCode ^binding.description = "A coded concept indicating why the medication was ordered."
// * reasonReference 0..* Reference(http://hl7.org/fhir/StructureDefinition/Condition or http://hl7.org/fhir/StructureDefinition/Observation) "Condition or observation that supports why the prescription is being written" "Condition or observation that supports why the medication was ordered."
// * reasonReference ^comment = "This is a reference to a condition or observation that is the reason for the medication order.  If only a code exists, use reasonCode."
// * instantiatesCanonical 0..* SU canonical "Instantiates FHIR protocol or definition" "The URL pointing to a protocol, guideline, orderset, or other definition that is adhered to in whole or in part by this MedicationRequest."
// * instantiatesUri 0..* SU uri "Instantiates external protocol or definition" "The URL pointing to an externally maintained protocol, guideline, orderset or other definition that is adhered to in whole or in part by this MedicationRequest."
// * basedOn 0..* SU Reference(http://hl7.org/fhir/StructureDefinition/CarePlan or http://hl7.org/fhir/StructureDefinition/MedicationRequest or http://hl7.org/fhir/StructureDefinition/ServiceRequest or http://hl7.org/fhir/StructureDefinition/ImmunizationRecommendation) "What request fulfills" "A plan or request that is fulfilled in whole or in part by this medication request."
// * groupIdentifier 0..1 SU Identifier "Composite request this is part of" "A shared identifier common to all requests that were authorized more or less simultaneously by a single author, representing the identifier of the requisition or prescription."
// * groupIdentifier ^requirements = "Requests are linked either by a \"basedOn\" relationship (i.e. one request is fulfilling another) or by having a common requisition. Requests that are part of the same requisition are generally treated independently from the perspective of changing their state or maintaining them after initial creation."
// * courseOfTherapyType 0..1 CodeableConcept "Overall pattern of medication administration" "The description of the overall patte3rn of the administration of the medication to the patient."
// * courseOfTherapyType from http://hl7.org/fhir/ValueSet/medicationrequest-course-of-therapy (example)
// * courseOfTherapyType ^comment = "This attribute should not be confused with the protocol of the medication."
// * courseOfTherapyType ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * courseOfTherapyType ^binding.extension.valueString = "MedicationRequestCourseOfTherapy"
// * courseOfTherapyType ^binding.description = "Identifies the overall pattern of medication administratio."
// * insurance 0..* Reference(http://hl7.org/fhir/StructureDefinition/Coverage or http://hl7.org/fhir/StructureDefinition/ClaimResponse) "Associated insurance coverage" "Insurance plans, coverage extensions, pre-authorizations and/or pre-determinations that may be required for delivering the requested service."
// * note 0..* Annotation "Information about the prescription" "Extra information about the prescription that could not be conveyed by the other attributes."
// * dosageInstruction 0..* Dosage "How the medication should be taken" "Indicates how the medication is to be used by the patient."
// * dosageInstruction ^comment = "There are examples where a medication request may include the option of an oral dose or an Intravenous or Intramuscular dose.  For example, \"Ondansetron 8mg orally or IV twice a day as needed for nausea\" or \"Compazine® (prochlorperazine) 5-10mg PO or 25mg PR bid prn nausea or vomiting\".  In these cases, two medication requests would be created that could be grouped together.  The decision on which dose and route of administration to use is based on the patient's condition at the time the dose is needed."
// * dispenseRequest 0..1 BackboneElement "Medication supply authorization" "Indicates the specific details for the dispense or medication supply part of a medication request (also known as a Medication Prescription or Medication Order).  Note that this information is not always sent with the order.  There may be in some settings (e.g. hospitals) institutional or system support for completing the dispense details in the pharmacy department."
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
// * detectedIssue 0..* Reference(http://hl7.org/fhir/StructureDefinition/DetectedIssue) "Clinical Issue with action" "Indicates an actual or potential clinical issue with or between one or more active or proposed clinical actions for a patient; e.g. Drug-drug interaction, duplicate therapy, dosage alert etc."
// * detectedIssue ^comment = "This element can include a detected issue that has been identified either by a decision support system or by a clinician and may include information on the steps that were taken to address the issue."
// * detectedIssue ^alias[0] = "Contraindication"
// * detectedIssue ^alias[+] = "Drug Utilization Review (DUR)"
// * detectedIssue ^alias[+] = "Alert"
// * eventHistory 0..* Reference(http://hl7.org/fhir/StructureDefinition/Provenance) "A list of events of interest in the lifecycle" "Links to Provenance records for past versions of this resource or fulfilling request or event resources that identify key state transitions or updates that are likely to be relevant to a user looking at the current version of the resource."
// * eventHistory ^comment = "This might not include provenances for all versions of the request – only those deemed “relevant” or important. This SHALL NOT include the provenance associated with this current version of the resource. (If that provenance is deemed to be a “relevant” change, it will need to be added as part of a later update. Until then, it can be queried directly as the provenance that points to this version using _revinclude All Provenances should have some historical version of this Request as their subject.)."
