Profile: AtEmedMedication
Parent: Medication
Id: at-emed-medication
Title: "ELGA e-Med Medikation"
Description: "**Beschreibung:** Bildet ein Arzneimittel ab, das nicht über eine PZN verfügt, z.B. magistrale Zubereitungen (\"Medication\"-Ressource).
Wird die Ressource nur für magistrale Zubreitungen verwendet? Wirkstoffverschreibung? manufacturer immer ATAPSOrganization?"


* identifier 0..*  // hier zulassungsnummer statt im code
* identifier ^short = "Eindeutiger Identifikator für das Arzneimittel. Verwendung für magistrale Zubereitungen prüfen."

// Wenn PZN vorhanden, dann im MedicationRequest angeben. 
// gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26), (in Vorbereitung) PCID der EMA (OID 1.2.40.0.34.4.27)
* code 0..1  
* code ^short = "Code des Arzneimittels. Verwendung für magistrale Zubereitungen prüfen."

* status 0..1
* status ^short = "Verfügbarkeitsstatus des Arzneimittels:(req) active | inactive | entered-in-error. Verwendung für magistrale Zubereitungen prüfen"

* manufacturer 0..1 MS
* manufacturer only Reference(HL7ATCoreOrganization)
* manufacturer ^short = "Der Hersteller des Arzneimittels. Für magistrale Zubereitungen die Apotheke (1..1?)" 

* form 1..1 MS
* form ^short = "Die Darreichungsform des Arzneimittels: (ex) powder | tablets | capsule + https://hl7.org/fhir/R4/valueset-medication-form-codes.html"

* amount 0..1 MS
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung."

* ingredient 1..* MS
* ingredient.item[x] only CodeableConcept or Reference(http://hl7.org/fhir/StructureDefinition/Substance or AtEmedMedication)
* ingredient.itemCodeableConcept 0..1 MS
* ingredient.itemCodeableConcept ^short = "Inhaltsstoff codiert"
* ingredient.itemReference 0..1 MS
* ingredient.itemReference ^short = "Referenz auf Ressourcen Substance oder Medication"

* ingredient.isActive 0..1 MS
* ingredient.isActive ^short = "Aktive Wirkstoff TRUE/FALSE"

* ingredient.strength 0..1 MS
* ingredient.strength ^short = "Menge der vorhandenen Zutat"

* batch 0..1 MS
* batch ^short = "Informationen zur Charge des Arzneimittels. Verwendung für magistrale Zubereitungen prüfen."

* batch.lotNumber 0..1 MS
* batch.lotNumber ^short = "Identifkation der Charge"

* batch.expirationDate 0..1 MS
* batch.expirationDate ^short = "Ablaufdatum"

