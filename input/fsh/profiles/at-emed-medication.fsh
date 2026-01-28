Profile: AtEmedMedication
Parent: Medication
Id: at-emed-medication
Title: "ELGA e-Medikation Medication"
Description: "Bildet ein Arzneimittel ab, das nicht über eine PZN verfügt (z.B. magistrale Zubereitungen)."


* identifier 0..*
* identifier ^short = "Eindeutiger Identifikator für das Arzneimittel. Verwendung für magistrale Zubereitungen prüfen."

// Wenn PZN vorhanden, dann im MedicationRequest angeben. Haben magistrale Zubereitungen einen code?
// gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26), (in Vorbereitung, bitte noch nicht verwenden) PCID der EMA (OID 1.2.40.0.34.4.27)
* code 0..1
* code ^short = "Code des Arzneimittels. Verwendung für magistrale Zubereitungen prüfen."

* status 0..1
* status ^short = "Der Verfügbarkeitsstatus active | inactive | entered-in-error. Verwendung für magistrale Zubereitungen prüfen"

* manufacturer 0..1 MS
* manufacturer ^short = "Der Hersteller des Arzneimittels. Für magistrale Zubereitungen die Apotheke. 1..1 ?"

* form 1..1 MS
* form ^short = "Die Darreichungsform des Arzneimittels"

* amount 0..1
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung."

* ingredient.item[x] only Reference(http://hl7.org/fhir/StructureDefinition/Substance or AtEmedMedication)
* manufacturer only Reference(HL7ATCoreOrganization)

* batch 0..1
* batch ^short = "Informationen zur Charge des Arzneimittels. Verwendung für magistrale Zubereitungen prüfen."


// Wird die Ressource nur für magistrale Zubreitungen verwendet? Wirkstoffverschreibung? manufacturer immer ATAPSOrganization?
