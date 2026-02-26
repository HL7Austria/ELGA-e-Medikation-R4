Instance: At-Emed-Example-Mr-Dosierung-Freitext
InstanceOf: AtEmedMRPlaneintrag
Title: "Medikationsplaneintrag mit Freitext-Dosierung"
Description: "Medikationsplaneintrag mit Dosierung im Tageszeitenschema (morgens, mittags, abends, nachts): 1-0-1-0."
Usage: #example

* contained[medication] = contained-medication-freitext-01

// R5 Backports
* extension[renderedDosageInstruction].valueMarkdown = "2 Stück morgens zum Frühstück"

* identifier.value = "4719_202602280800000" // Eintrag_ID = {ID}_{Zeitstempel}
* status = #active
//* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent = #order
* category = MedicationRequestCategoryCS#1 
* reportedBoolean = false

// Referenz auf Contained Medication Ressource
* medicationReference.reference = "#contained-medication-freitext-01"

* subject = Reference(At-Emed-Journey-01-Patient-01)
* authoredOn = "2026-01-28T08:00:00+00:00"
* requester = Reference(At-Emed-Journey-01-Practitioner-01)

* dosageInstruction.text = "2 Stück morgens zum Frühstück"


// Contained Medication *********************************************************************
Instance: contained-medication-freitext-01
InstanceOf: AtEmedMedication
Title: "Beispiel Medikation EBETREXAT"
Usage: #inline
//* id = "contained-medication-freitext-01"
* code = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"