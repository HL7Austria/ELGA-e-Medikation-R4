Profile: AtEmedMedicationRequestPlaneintrag
Parent: MedicationRequest
Id: at-emed-medicationrequest-planeintrag
Title: "ELGA e-Medikation Planeintrag"
Description: "**Beschreibung:** Bildet einen Eintrag eines Medikationsplans eines ELGA Teilnehmers ab. Er enthält genau ein verordnetes Arzneimittel und dessen Dosierung. Dient in weiterer Folge dazu, eine geplante Abgabe zu erstellen (AtEmedMedicationRequestGeplanteAbgabe)."


// Vorgaben APS ***************************
// impose Profile APS 
// * ^extension[$imposeProfile].valueCanonical = Canonical(AtApsMedicationRequest)
// * medication[x] only CodeableConcept or Reference(AtApsMedication)
// * subject only Reference(AtApsPatient)
// Ende Vorgaben APS ***************************


// Vorgaben MPD ***************************
// * insert MedicationRequestEpCommon
// * medication[x] only CodeableConcept or Reference(MedicationEuMpd)
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

// Basis: MedicationRequest 
* status ^short = "active | aktiv"

