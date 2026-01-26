Profile: AtEmedBundleDocumentMedikationsplan
Parent: Bundle
Id: at-emed-bundle-document-medikationsplan
Title: "ELGA e-Medikation Document Bundle Medikationsplan"
Description: "**Beschreibung:** ELGA e-Medikation Document Bundle zur Anzeige des Medikationsplans mit allen Medikationsplaneinträgen. 
Beinhaltet:
- Medikationsplan (List)
- Medikationsplaneinträge (MedicationRequest)
- Referenzen zu geplanten Abgaben (entsprechen Rezepten)

Bundle (type=document)
 ├─ Composition  (AtEmedCompositionMedikationsplan)
 ├─ MedicationRequest 1 (AtEmedMedicationRequestPlaneintrag)
 ├─ MedicationRequest 2 (AtEmedMedicationRequestPlaneintrag)
 └─ List (referenziert 1+2) (AtEmedListMedikationsplan)" 

* identifier 0..1
* identifier ^short = "Persistenter Identifikator für das Bundle."

* type 1..1 MS
* type = #document

* entry 1..* MS
* entry.resource 1..1
// * entry.fullUrl 1..1



// composition muss first sein
Invariant: doc-1
Description: "Composition SHALL be first entry"
Expression: "entry.first().resource.is(Composition)"
Severity: #error