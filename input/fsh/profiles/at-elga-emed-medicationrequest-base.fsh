Profile: AtElgaEmedMedicationRequestBase
Parent: MedicationRequest
Id: at-elga-emed-medicationrequest-base
Title: "At ELGA e-Medikation MedicationRequest Base"
Description: "Die Basis für alle in eMed verwendeten MedicationRequests"

// TODO: Invariante für repeating sequences * dosageInstruction.extension contains AtElgaEmedExtensionDosageRepeat??? named repeatCycle 0..1
//TODO Invariante sodass die Extension nur erlaubt ist, wenn es mehrere Dosages gibt
* dosageInstruction ^slicing.discriminator.type = #value
* dosageInstruction ^slicing.discriminator.path = "extension.value"
* dosageInstruction ^slicing.rules = #closed
* dosageInstruction ^slicing.ordered = false
* dosageInstruction 1..* MS
* dosageInstruction contains   
    otherDosage 0.. MS and
    timedDosage 0.. MS and
    frequencyDosage 0.. MS and
    freitextDosage 0.. MS and
    standardDosage 0.. MS
// DOSAGE
* dosageInstruction[otherDosage] only AtElgaEmedDosageOtherAdministration
* dosageInstruction[timedDosage] only AtElgaEmedDosageTimedAdministration
* dosageInstruction[frequencyDosage] only AtElgaEmedDosageFrequencyAdministration
* dosageInstruction[freitextDosage] only AtElgaEmedDosageFreeTextAdministration
* dosageInstruction[standardDosage] only AtElgaEmedDosageStandardAdministration

* obeys allDosagesSameCategory
* obeys FirstDosageSequenceNumberExists
//* obeys allDosagesWithSameSequenceSamePeriodAndFrequency //category = standard
//* obeys allDosagesWithSameSequenceSameDoseUnit //for the same sequence number
//* obeys allDosagesWithSameSequenceNoDuplicateWhenInTiming //for the same sequence number
//* obeys allDosagesWithSameSequenceNoDuplicateWeekdayInTiming //for the same sequence number
//* obeys allDosagesWithSameSequenceNoDuplicateDayOfMonthInTiming //for the same sequence number


Invariant: allDosagesSameCategory
Description: "Alle Dosierungsanweisungen eines MedicationRequest müssen dieselbe Dosierungskategorie aufweisen."
Expression: "dosageInstruction.extension.where(url = 'https://fhir.hl7.at/elga/emed/r4/StructureDefinition/at-elga-emed-extension-dosage-category').value.coding.code.distinct().count() = 1"
Severity: #error

Invariant: FirstDosageSequenceNumberExists
Description: "Wenn mehrere Dosierungsanweisungen vorhanden sind, muss mindestens eine davon die Sequenznummer 1 haben."
Expression: "dosageInstruction.count() <= 1 or dosageInstruction.sequence.where($this = 1).exists()"
Severity: #error


//Invariant: allDosagesWithSameSequenceSamePeriodAndPeriodUnit
//Description: "Alle strukturierten Dosierungsanweisungen mit derselben Sequenznummer müssen dieselbe period und periodUnit aufweisen."
//Expression: ""
//Severity: #error