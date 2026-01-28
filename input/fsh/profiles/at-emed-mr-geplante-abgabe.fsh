// Alias: $rendered = http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction
// Alias: $effective = http://hl7.org/fhir/StructureDefinition/medicationrequest-effectivedoseperiod-r5
// Alias: $extension-MedicationRequest.effectiveDosePeriod = http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod
// Alias: $extension-MedicationRequest.renderedDosageInstruction = http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction


Profile: AtEmedMRGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-mr-geplante-abgabe
Title: "ELGA e-Medikation Geplante Abgabe"
Description: "**Beschreibung:** Bildet eine geplante Abgabe eines Arzneimittels aus dem zugrundeliegenden Medikationsplaneintrag des ELGA-Teilnehmers ab.
Sie enthält das verordnete Arzneimittel und dessen Dosierung und spielgelt die Inhalte des e-Rezepts wider. Geplante Abgaben dienen somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation.
Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), die auch im e-Rezept mitgeführt wird.
Werden mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer'). Verwendet R5 Backport Extensions."
* . ^short = "Geplante Abgabe eines Arzneimittels aus dem Medikationsplan. Verwendet R5 Backport Extensions."

// Vorgaben APS ***************************
// impose Profile APS 
// * ^extension[$imposeProfile].valueCanonical = Canonical(AtApsMedicationRequest)
// Ende Vorgaben APS ***************************


// Vorgaben MPD ***************************
// Abhängigkeiten zu anderen IGS sind zu diskutieren
// * insert MedicationRequestEpCommon
// * medication[x] only CodeableConcept or Reference(MedicationEuMpd) //AtEmedMedication
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


// RuleSet: MedicationRequestEpCommon

// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
// * extension[offLabelUse] ^short = "Indicates that the prescriber has knowingly prescribed the medication for an indication, age group, dosage, or route of administration that is not approved by the regulatory agencies and is not mentioned in the prescribing information for the product." 
// * identifier 
//   * ^short = "Prescription/prescribed item ID"
//   * ^comment = "It is the prescription ID if the presciption includes only one prescribed item"
// * status ^short = "Current state of the order"
// //* intent = $medicationrequest-intent#order 
// * subject only Reference( PatientEuCore )
// * authoredOn 1..
// * requester 1..
// * groupIdentifier 
//   * ^short = "Prescription this is part of. Not needed if a presciption includes only one prescribed item."
// * dosageInstruction ^short = "How the medication should be taken."
//   * timing ^short = "Administration schedule"
//     * repeat
//       * duration ^short = "Duration of the treatment"
//       * frequency ^short = "Frequency times per period"
//       * period ^short = "Duration of time over which repetitions are to occur"
//       * periodUnit  ^short = "Unit of the period (e.g. day)"
//     * code ^short = "A code for the timing schedule."
//   * route ^short = "Route of administration"
//   * text ^short = "Free text dosage instructions"
//   * doseAndRate.doseQuantity ^short = "Amount of medication per dose"
// * dispenseRequest
//   * extension contains $ihe-ext-medicationrequest-prescribedquantity named prescribedQuantity 0..1
//   * extension[prescribedQuantity] ^short = "Overall amount of product prescribed, independent from the number of repeats."
//   * extension[prescribedQuantity] ^definition = "When Medication resource implies a pack size, prescribedQuantity should convey number of packages. When the Medication does not imply an amount, overall amount could be in tablets or millilitres."


// Ende Vorgaben MPD ***************************


// R5 Backport Extensions  -> https://gemspec.gematik.de/ig/fhir/epa-medication/1.3.0/StructureDefinition-emp-medication-request.profile.json.html

// * extension contains
//     $extension-MedicationRequest.effectiveDosePeriod named effectiveDosePeriod 0..1 MS and
//     $extension-MedicationRequest.renderedDosageInstruction named renderedDosageInstruction 0..1 MS and

//* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
//* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."
// * extension[renderedDosageInstruction].extension[text].valueMarkdown 0..1
// * extension[renderedDosageInstruction].extension[language].valueCode 0..1
// * extension[effectiveDosePeriod].valuePeriod 0..1
// * extension[effectiveDosePeriod].value[x].start obeys epa-datetime
// * extension[effectiveDosePeriod].value[x].end obeys epa-datetime


* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Period over which the medication should be taken."
* extension[effectiveDosePeriod] ^definition = "Period over which the medication should be taken. Where there are multiple dosageInstruction lines (for example, tapering doses), this is the earliest date and the latest end date of the dosageInstructions."

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Full representation of the dosage instructions"

//Fachlich zu klären, ob verwendet -> IHE extension und keine Backport Extension
* extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
* extension[offLabelUse] ^short = "Indicates that the prescriber has knowingly prescribed the medication for an indication, age group, dosage, or route of administration that is not approved by the regulatory agencies and is not mentioned in the prescribing information for the product." 



// Obligations für alle MS Elemente!, kein 0..0 nötig
// MedicationRequest 
* identifier 1..* MS  
* identifier ^short = "MedicationRequest identifier = {eMed-ID}_{locally assigned ID}  Setzt sich zusammen aus groupIdentifier (Rezept-Klammer) und individueller Identifikation der geplanten Abgabe."

// evt. noch einschränken: unknown, draft entfernen  
* status ^short = "Status der geplanten Abgabe (im Standardfall active oder complete): active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown -> entfernen: draft, unknown"

* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt eine Anforderung und Ermächtigung zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann, da beide "order" 
* category 1..1 MS
* category from MedicationRequestCategoryVS (required)
* category.coding = #2 "Geplante Abgabe"
// * category.coding.code = #2 
// * category.coding.display = "Geplante Abgabe"
// * category.coding.system = "http://hl7.org/fhir/medicationrequest-category"    // derzeit nur lokal
* category ^short = "Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann."

* priority 0..0
* priority ^short = "Priorität der geplanten Abgabe: routine | urgent | asap | stat. Keine Verwendung in der geplanten Abgabe."

* doNotPerform 0..0
* doNotPerform ^short = "Gibt an, ob die geplante Abgabe untersagt ist. Keine Verwendung in der geplanten Abgabe."

* reported[x] 0..0
* reported[x] ^short = "Keine Verwendung in der geplanten Abgabe."

// --- Medication Choice: Code (PZN) ODER Medication-Resource ---
* medication[x] 1..1 MS  //Obligation auf obersten Ebenen, Rendering prüfen
* medication[x] only CodeableConcept or Reference(AtEmedMedication)  //Obligation auf obersten Ebenen
// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS  //Obligation auf obersten Ebenen
* medicationCodeableConcept from $cs-asp-liste (required)  // gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26), (in Vorbereitung) PCID der EMA (OID 1.2.40.0.34.4.27)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1.. // zusätzlich ausländische Codes o.ä. zulassen
// * medicationCodeableConcept.coding.system 1..
// * medicationCodeableConcept.coding.code 1..
// * medicationCodeableConcept.coding.display 1..   // Übersetzungen?
// Reference-Variante für magistrale Zubereitung/Infusionen
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
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + organization nötig 
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

* reasonCode 0..* MS
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz (evtl. Invariante)."
* reasonCode.coding 1..*
* reasonCode.coding.system 1..1 
* reasonCode.coding.code 1..1
* reasonCode.coding.display 1..1

* reasonReference 0..* MS
* reasonReference ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz (evtl. Invariante)."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll, eine Richtlinie, einen Auftragssatz oder eine andere Definition verweist, die von diesem MedicationRequest ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll, eine Richtlinie, einen Auftragssatz oder eine andere Definition verweist, die von dieser Medikamentenanforderung ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1
* basedOn only Reference(AtEmedMRPlaneintrag)
* basedOn ^short = "Referenz auf den zugrundeliegenden Medikationsplaneintrag, auf dem diese geplante Abgabe basiert."

* groupIdentifier 1..1 MS 
* groupIdentifier ^short = "Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), die auch im e-Rezept mitgeführt wird. Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."

* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Evtl. im Planeintrag (dosageInstruction), paused soll im Status dokumentiert werden."

* insurance 0..0
* insurance ^short = "Keine Verwendung in der geplanten Abgabe."

* note 0..* 
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe, die durch die anderen Attribute nicht abgebildet werden konnten. -> Dzt. unklar, ob erforderlich, evtl einschränken"

* dosageInstruction 0..* 
* dosageInstruction ^short = "Anweisungen zur Einnahme/Verabreichung des Arzneimittels."

* dosageInstruction.patientInstruction ^short = "Anweisungen für den Patienten"
* dosageInstruction.timing.repeat.frequency ^short = "Wiederholungen innerhalb der Dauer"
* dosageInstruction.timing.repeat.period ^short = "Zeitraum, über den Wiederholungen erfolgen sollen"
* dosageInstruction.timing.repeat.periodUnit ^short = "Zeiteinheit: s | min | h | d | wk | mo | a  (UCUM)"
* dosageInstruction.timing.repeat.when from $cs-event-timing
* dosageInstruction.timing.repeat.when ^short = "Code für den Zeitraum des Auftretens (z.B. nach dem Frühstück) https://hl7.org/fhir/R4/valueset-event-timing.html"
* dosageInstruction.asNeeded[x] ^short = "Bedarfsmedikation"

* dosageInstruction.doseAndRate.rate[x] 0..0
* dosageInstruction.doseAndRate.rate[x] ^short = "Verabreichte Medikamentendosis. Keine Verwendung in der geplanten Abgabe. Zu prüfen"

// * effectiveDosePeriod ^short = "Period over which the medication is to be taken | Zeitraum, über den das Medikament eingenommen werden soll"

* dispenseRequest 0..1 
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels."
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der möglichen Einlösungen."

* substitution 0..1
* substitution ^short = "Gibt an, ob eine Substitution Teil der Abgabe sein kann / sollte / nicht sein darf. Dieser Block erläutert die Absicht des verschreibenden Arztes. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. -> Eher keine Verwendung in der geplanten Abgabe, Dokumentation über Substitution erfolg in der Dispenses-Resource."

* priorPrescription 0..1 
* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte geplante Abgabe verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Bezeichnet ein tatsächliches / potenzielles klinisches Problem mit oder zwischen aktiven / vorgeschlagenen klinischen Maßnahmen für einen Patienten, z. B. Wechselwirkungen zwischen Medikamenten, doppelte Therapie, Dosierungswarnung usw. -> Keine Verwendung in der geplanten Abgabe"

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, die verschiedene relevante Versionen dieser Ressource dokumentieren. -> Keine Verwendung in der geplanten Abgabe."

// --- XOR-Invariant: genau eines von beiden ---
// https://hl7.org/fhirpath/N1/
Invariant: med-1
Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
Severity: #error

// Invariant: epa-datetime
// Description: "dateTime muss mindestens aus Tag, Monat und Jahr bestehen"
// * severity = #error
// * expression = "toString().matches('^([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\\\.[0-9]+)?(Z|(\\\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?$')"


