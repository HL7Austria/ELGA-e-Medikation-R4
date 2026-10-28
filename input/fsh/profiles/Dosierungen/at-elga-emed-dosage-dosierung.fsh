Profile: AtElgaEmedDosageDosierung
Parent: Dosage
Id: at-elga-emed-dosage-dosierung
Title: "AT ELGA e-Medikation Dosage Dosierung"
Description: "Basisprofil für alle Dosierungschemata"

* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

// Medication IG DE https://ig.fhir.de/igs/medication/index.html
//* obeys DosageStructuredOrFreeTextWarning and DosageStructuredRequiresBoth and DosageDoseUnitSameCode and DosageWarnungViererschemaInText and FreeTextSingleDosageOnlyWarning

* extension contains AtElgaEmedExtensionDosageCategory named DosageCategory 1.. MS

* sequence 1..1 MS
* sequence ^short = "Die Reihenfolge der Dosierungsanweisungen. Entfällt bei Einzeldosierung."

* text 0..1 MS
* text ^short = "Textdarstellung der Dosierung: bei strukturierter Dosierung durch die Fachanwendung generiert, sonst Freitext-Dosierungsanweisung (wenn keine strukturierte Angabe möglich ist)."

* additionalInstruction 0..* MS // 0..1
* additionalInstruction ^short = "Codierte Anweisungen oder Warnhinweise für den Patienten, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels. (ex):
https://hl7.org/fhir/R4/valueset-additional-instruction-codes.html." 
// TODO: Nur wenn nicht ohnehin im Beipackzettel enthalten oder zusätzlich? Evtl. f. magistrale Zubereitungen, da kein Beipackzettel."
// TODO: unwahrscheinlich, dass dies strukturiert als code erfasst wird - evtl. als Dropdown mit vorgefertigten Möglichkeiten
* additionalInstruction.coding 1..1 MS
* additionalInstruction.coding.display MS
* additionalInstruction.coding.code MS
* additionalInstruction.coding.code 1..1
* additionalInstruction.coding.system MS
* additionalInstruction.coding.system 1..1
* additionalInstruction.coding.version MS
* additionalInstruction.text 0..0
* additionalInstruction.text ^short = "Fachliche Begründung: TODO"

* patientInstruction 0..1 MS
* patientInstruction ^short = "Freitext Anweisungen für den Patienten, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels."

* timing 0..1 MS
* timing only AtElgaEmedTiming
* timing ^short = "Zeitpunkt oder Zeitraum der Einnahme des Medikaments. 
Um widersprüchliche Anweisungen zu vermeiden, ist entweder Dosage.timing oder Dosage.text zu befüllen."
//* timing.code.coding from $vs-einnahmezeitpunkte (required)


// Grund für die Bedarfsmedikation (asNeededCodeableConcept) wird nicht verwendet //TODO: Vermutlich reicht ein genereller Grund für die Medikation im Planeintrag (wenn e-Diagnose verfügbar)."
* asNeeded[x] only boolean
* asNeeded[x] MS
* asNeeded[x] ^short = "Bedarfsmedikation: Ja/Nein"

* site 0..1 MS // evtl aus asp-liste? eindeutig? spezielle körperstelle betreffend;
* site ^short = "Körperstelle, an der das Medikament angewendet wird, z.B. Haut, Auge, Ohr etc."
// ASW 18.10. TODO ValueSet 
* site.coding 1..1 MS
* site.coding.display MS
* site.coding.code MS
* site.coding.code 1..1
* site.coding.system MS
* site.coding.system 1..1
* site.coding.version MS
* site.text 0..0
* site.text ^short = "Fachliche Begründung: TODO"

* route 0..1 MS
* route ^short = "Art der Anwendung der Arznei. (z.B. oral, nasal, intravenös, subkutan). Kann bei codierten Arzneien aus der ASP-Liste entnommen werden."
* route.coding 1..1 MS
* route.coding.display MS
* route.coding.code MS
* route.coding.code 1..1
* route.coding.system MS
* route.coding.system = $cs-medikationartanwendung
* route.coding.system 1..1
* route.coding.version MS
* route.text 0..0
* route.text ^short = "Fachliche Begründung: TODO"

* method 0..1 MS
* method ^short = "Verabreichungsmethode, z.B. Infusion, Injektion, Tablette, Salbe etc."
// ASW 18.10. TODO ValueSet 
* method.coding 1..1 MS
* method.coding.display MS
* method.coding.code MS
* method.coding.code 1..1
* method.coding.system MS
* method.coding.system 1..1
* method.coding.version MS
* method.text 0..0
* method.text ^short = "Fachliche Begründung: TODO"

* doseAndRate 0..1  MS 
* doseAndRate ^short =  "Menge des verabreichten Medikaments"
* doseAndRate.dose[x] ^short = "Menge des verabreichten Medikaments pro Dosis."
* doseAndRate.dose[x] MS
* doseAndRate.doseRange 0..1 MS
* doseAndRate.doseRange ^short = "Dosierungsspanne wird mit low und high angegeben, z.B. 5-10 mg."
* doseAndRate.doseRange.high MS
* doseAndRate.doseRange.high.value 1..1 MS
* doseAndRate.doseRange.high.unit 1..1 MS
* doseAndRate.doseRange.high.code 1..1 MS
* doseAndRate.doseRange.high.system 1..1 MS
* doseAndRate.doseRange.low MS
* doseAndRate.doseRange.low.value 1..1 MS
* doseAndRate.doseRange.low.unit 1..1 MS
* doseAndRate.doseRange.low.code 1..1 MS
* doseAndRate.doseRange.low.system 1..1 MS

* doseAndRate.doseQuantity 0..1 MS
* doseAndRate.doseQuantity from $vs-emed-mengenart (required) // auch Mengenart_alternativ?
* doseAndRate.doseQuantity ^short = "TODO"
* doseAndRate.doseQuantity.value 1..1 MS
* doseAndRate.doseQuantity.unit 1..1 MS
* doseAndRate.doseQuantity.code 1..1 MS
* doseAndRate.doseQuantity.system 1..1 MS
//Menge in nicht-zählbaren Einheiten -> @unit 1..1 (required) aus Value-Set ELGA_MedikationMengenart
//Menge in zählbaren Einheiten (Tabletten, Kapseln, etc.) -> @unit 0..1 (otional) mit @unit aus Value-Set ELGA_MedikationMengenartAlternativ
* doseAndRate.rate[x] MS
* doseAndRate.rate[x] ^short = "Menge des verabreichten Medikaments pro Zeiteinheit."
* doseAndRate.rateQuantity MS
* doseAndRate.rateQuantity.value 1..1 MS
* doseAndRate.rateQuantity.unit 1..1 MS
* doseAndRate.rateQuantity.code 1..1 MS
* doseAndRate.rateQuantity.system 1..1 MS
* doseAndRate.rateRange MS
* doseAndRate.rateRange.high MS
* doseAndRate.rateRange.high.value 1..1 MS
* doseAndRate.rateRange.high.unit 1..1 MS
* doseAndRate.rateRange.high.code 1..1 MS
* doseAndRate.rateRange.high.system 1..1 MS
* doseAndRate.rateRange.low MS
* doseAndRate.rateRange.low.value 1..1 MS
* doseAndRate.rateRange.low.unit 1..1 MS
* doseAndRate.rateRange.low.code 1..1 MS
* doseAndRate.rateRange.low.system 1..1 MS
* doseAndRate.rateRatio MS
* doseAndRate.rateRatio.denominator MS
* doseAndRate.rateRatio.denominator.value 1..1 MS
* doseAndRate.rateRatio.denominator.unit 1..1 MS
* doseAndRate.rateRatio.denominator.code 1..1 MS
* doseAndRate.rateRatio.denominator.system 1..1 MS
* doseAndRate.rateRatio.denominator.comparator 0..0
* doseAndRate.rateRatio.denominator.comparator ^short = "Fachliche Begründung: TODO"
* doseAndRate.rateRatio.numerator 1..1 MS
* doseAndRate.rateRatio.numerator.value 1..1 MS
* doseAndRate.rateRatio.numerator.unit 1..1 MS
* doseAndRate.rateRatio.numerator.code 1..1 MS
* doseAndRate.rateRatio.numerator.system 1..1 MS
* doseAndRate.rateRatio.numerator.comparator 0..0
* doseAndRate.rateRatio.numerator.comparator ^short = "Fachliche Begründung: TODO"

* maxDosePerPeriod 0..1 MS
* maxDosePerPeriod ^short = "Maximale Menge pro Zeiteinheit"
* maxDosePerPeriod.denominator MS
* maxDosePerPeriod.denominator.value 1..1 MS
* maxDosePerPeriod.denominator.unit 1..1 MS
* maxDosePerPeriod.denominator.code 1..1 MS
* maxDosePerPeriod.denominator.system 1..1 MS
* maxDosePerPeriod.denominator.comparator 0..0
* maxDosePerPeriod.denominator.comparator ^short = "Fachliche Begründung: TODO"
* maxDosePerPeriod.numerator 1..1 MS
* maxDosePerPeriod.numerator.value 1..1 MS
* maxDosePerPeriod.numerator.unit 1..1 MS
* maxDosePerPeriod.numerator.code 1..1 MS
* maxDosePerPeriod.numerator.system 1..1 MS
* maxDosePerPeriod.numerator.comparator 0..0
* maxDosePerPeriod.numerator.comparator ^short = "Fachliche Begründung: TODO"


* maxDosePerAdministration 0..1 MS
* maxDosePerAdministration ^short = "Maximal Menge pro Abgabe"
* maxDosePerAdministration.value 1..1 MS
* maxDosePerAdministration.unit 1..1 MS
* maxDosePerAdministration.code 1..1 MS
* maxDosePerAdministration.system 1..1 MS

* maxDosePerLifetime 0..1 MS //Relevant für Bestrahlung/Tumortherapie, nur im Kontext Krankenhausintern?
* maxDosePerLifetime ^short = "Maximale Lebenszeitdosis"
* maxDosePerLifetime.value 1..1 MS
* maxDosePerLifetime.unit 1..1 MS
* maxDosePerLifetime.code 1..1 MS
* maxDosePerLifetime.system 1..1 MS


/* Invarianten ***********************************************************************/
 // TODO

 //TODO: Invariante: wenn es mehrere Dosages mit der gleichen Sequenznummer gibt und die periodUnit 'd' ist darf es jede Tageszeit nur einmal geben
