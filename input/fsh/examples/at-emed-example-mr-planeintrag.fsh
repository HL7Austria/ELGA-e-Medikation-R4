Instance: At-Emed-Example-Mr-Planeintrag
InstanceOf: AtElgaEmedMedicationRequestPlaneintrag   
Title: "Beispiel Example Medikationsplaneintrag"
Description: "Bildet einen Medikationsplaneintrag mit dem Medikament EBETREXAT und zugehörigen Dosierungsanweisungen ab (MedicationRequest)."
Usage: #example

* contained[+] = ContainedMedication01

// R5 Backports
* extension[effectiveDosePeriod].valuePeriod.start = "2026-02-27"
* extension[effectiveDosePeriod].valuePeriod.end = "2026-03-06"
* extension[renderedDosageInstruction].valueMarkdown = "1 Kapsel täglich morgens"

//* meta[+].profile = "http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd"
* identifier.value = "4712_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
//* status = $cs-medication-request-status#active
* status = $cs-medication-request-status#active
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* category = MedicationRequestCategoryCS#1 "Medikationsplaneintrag" 

* reportedBoolean = false

// Referenz auf Inline Medication Ressource
* medicationReference.reference = "#ContainedMedication01"

* subject = Reference(At-Emed-Example-Patient-01)
* authoredOn = "2026-02-27T10:20:00+00:00"
* requester = Reference(At-Emed-Example-Practitioner-01)

//* reasonCode = $cs-sct#59621000 "Essentielle Hypertonie"
* note.text = "Freitext Informationen zum Medikationsplaneintrag."

* dosageInstruction[otherDosage].extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#other
* dosageInstruction[otherDosage].sequence = 1
* dosageInstruction[otherDosage].text = "1 Kapsel täglich morgens"
* dosageInstruction[otherDosage].patientInstruction = "Nehmen Sie die Kapsel jeden Morgen mit ausreichend Flüssigkeit ein."
//* dosageInstruction[otherDosage].additionalInstruction = $sct#1153465004 "Education about overdosing"
* dosageInstruction[otherDosage].timing.repeat.frequency = 1
* dosageInstruction[otherDosage].timing.repeat.period = 1
* dosageInstruction[otherDosage].timing.repeat.periodUnit = #d
// * dosageInstruction[otherDosage].timing.period = 4
// * dosageInstruction[otherDosage].timing.periodMax = 6
// * dosageInstruction[otherDosage].timing.periodUnit = "h"
// * dosageInstruction[otherDosage].asNeededCodeableConcept = $sct#56018004 "wheezing"
* dosageInstruction[otherDosage].route = https://termgit.elga.gv.at/CodeSystem-medikationartanwendung.html#100000073619 "zum Einnehmen"
* dosageInstruction[otherDosage].doseAndRate.doseQuantity = 5 'mg' "mg"
// * dosageInstruction[otherDosage].maxDosePerPeriod.numerator = 6 '{spray}' "{spray}"
// * dosageInstruction[otherDosage].maxDosePerPeriod.denominator = 1 '{day}' "{day}"



// Contained Medication *********************************************************************
Instance: ContainedMedication01
InstanceOf: AtElgaEmedMedicationMedikation
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "ContainedMedication01"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"


