Profile: AtEmedCompositionMedikationsplan
Parent: Composition
Id: at-emed-composition-medikationsplan
Title: "ELGA e-Medikation Composition Medikationsplan"
Description: "**Beschreibung:** Composition legt Inhalte des Medikationsplans (Dokument) fest. 
Beinhaltet:
- Medikationsplan (List)
- Medikationsplaneinträge (MedicationRequest)
- Referenzen zu geplanten Abgaben (entsprechen Rezepten)

Bundle (type=document)
 ├─ Composition 
 ├─ MedicationRequest 1
 ├─ MedicationRequest 2
 └─ List (referenziert 1+2)"

* status 1..1 MS
* status = #final

* type 1..1 MS
* type.coding = $cs-sct#736378000 "Medikationsplan"

* subject 1..1 MS
* subject only Reference(HL7ATCorePatient)

* date 1..1 MS

* author 1..1 MS
* author only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)

* title 1..1 MS
* title = "Medikationsplan"

* section 1..1 MS
* section.code = #medikationsplan "Medikationsplan"
* section.entry 0..* MS
* section.entry only Reference(AtEmedMedicationRequestPlaneintrag or AtEmedListMedikationsplan)