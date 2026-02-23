Profile: AtEmedDosage
Parent: Dosage
Id: at-emed-dosage
Title: "ELGA e-Med Dosage"
Description: "**Beschreibung:** Dosage"

// Medication IG DE https://ig.fhir.de/igs/medication/index.html
//* obeys DosageStructuredOrFreeTextWarning and DosageStructuredRequiresBoth and DosageDoseUnitSameCode and DosageWarnungViererschemaInText and FreeTextSingleDosageOnlyWarning

* sequence 0..1 MS
* sequence ^short = "Die Reihenfolge der Dosierungsanweisungen. Entfällt bei Einzeldosierung."

* text MS
* text ^short = "Freitext-Dosierungsanweisung, wenn keine strukturierte Angabe möglich ist."

* additionalInstruction 0..*  // 0..1
* additionalInstruction ^short = "Codierte Anweisungen oder Warnhinweise für den Patienten, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels. (ex):
https://hl7.org/fhir/R4/valueset-additional-instruction-codes.html. TODO: Nur wenn nicht ohnehin im Beipackzettel enthalten oder zusätzlich? Evtl. f. magistrale Zubereitungen, da kein Beipackzettel."

* patientInstruction 0..1
* patientInstruction ^short = "Freitext Anweisungen für den Patienten, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels."


* timing 0..1 MS
* timing only AtEmedTiming
* timing ^short = "Zeitpunkt oder Zeitraum der Einnahme des Medikaments. 
Um widersprüchliche Anweisungen zu vermeiden, ist entweder Dosage.timing oder Dosage.text zu befüllen."


* asNeededBoolean 0..1 MS
* asNeededBoolean ^short = "Bedarfsmedikation: Ja/Nein"
* asNeededCodeableConcept 0..0 
* asNeededCodeableConcept ^short = "Bedarfsmedikation: Grund für die Bedarfsmedikation; Vermutlich reicht ein genereller Grund für die Medikation im Planeintrag (wenn e-Diagnose verfügbar)."

* site 0..1 // evtl aus asp-liste? eindeutig? spezielle körperstelle betreffend;
* site ^short = "Körperstelle, an der das Medikament angewendet wird, z.B. Haut, Auge, Ohr etc."

* route 0..1 MS
* route from $cs-medikationartanwendung (required) 
* route ^short = "Art der Anwendung der Arznei. (z.B. oral, nasal, intravenös, subkutan)
 Kann bei codierten Arzneien aus der ASP-Liste entnommen werden."

* method 0..1 MS
* method ^short = "Verabreichungsmethode, z.B. Infusion, Injektion, Tablette, Salbe etc. "

* doseAndRate 0..1  MS 
* doseAndRate ^short =  "Menge des verabreichten Medikaments"

* doseAndRate.type 0..1
* doseAndRate.type ^short = "Art der Dosierung, z.B. berechnet, wie verordnet (ex): https://hl7.org/fhir/R4/valueset-dose-rate-type.html" //$dose-rate-type = http://terminology.hl7.org/CodeSystem/dose-rate-type

* doseAndRate.dose[x] ^short = "Menge des verabreichten Medikaments pro Dosis. 
Bei zählbaren Einheiten (z.B. Tabletten) kann die Einheit optional angegeben werden, 
bei nicht-zählbaren Einheiten muss die Einheit angegeben werden (z.B. mg)."
* doseAndRate.doseRange 0..1 MS
* doseAndRate.doseRange ^short = "Dosierungsspanne wird mit low und high angegeben, z.B. 5-10 mg."
* doseAndRate.doseQuantity 0..1 MS
* doseAndRate.doseQuantity.unit from $vs-emed-mengenart (required) // auch Mengenart_alternativ?
* doseAndRate.doseQuantity ^short = "Mapping auf doseQuantity"
//Menge in nicht-zählbaren Einheiten -> @unit 1..1 (required) aus Value-Set ELGA_MedikationMengenart
//Menge in zählbaren Einheiten (Tabletten, Kapseln, etc.) -> @unit 0..1 (otional) mit @unit aus Value-Set ELGA_MedikationMengenartAlternativ


* doseAndRate.dose[x] ^short = "Menge des verabreichten Medikaments pro Zeiteinheit."
* doseAndRate.rateRatio ^short = "TODO: prüfen" 
* doseAndRate.rateRange ^short = "TODO: prüfen" 
* doseAndRate.rateQuantity ^short = "TODO: prüfen" 

* maxDosePerPeriod 0..1 //Maximale Menge pro Zeiteinheit
* maxDosePerAdministration 0..1  //Maximal Menge pro Abgabe
* maxDosePerLifetime 0..1 //Relevant für Bestrahlung/Tumortherapie, nur im Kontext Krankenhausintern?





/* Invarianten ***********************************************************************/

// Invariant: DosageStructuredOrFreeTextWarning
// Description: "Die Dosierungsangabe darf entweder nur als Freitext oder nur als vollständige strukturierte Information erfolgen — eine Mischung ist nicht erlaubt."
// * severity = #warning
// * expression = "(%resource.ofType(MedicationRequest).dosageInstruction | \n ofType(MedicationDispense).dosageInstruction | \n ofType(MedicationStatement).dosage).all(\n  (text.exists() and timing.empty() and doseAndRate.empty()) or\n  (text.empty() and (timing.exists() or doseAndRate.exists()))\n)\n"

// Invariant: DosageStructuredRequiresBoth
// Description: "Wenn eine strukturierte Dosierungsangabe erfolgt, müssen sowohl timing als auch doseAndRate angegeben werden."
// * severity = #error
// * expression = "(%resource.ofType(MedicationRequest).dosageInstruction | \n ofType(MedicationDispense).dosageInstruction | \n ofType(MedicationStatement).dosage).all(\n  (timing.exists() implies doseAndRate.exists()) and\n  (doseAndRate.exists() implies timing.exists())\n)\n"

// Invariant: DosageDoseUnitSameCode
// Description: "Die Dosiereinheit muss über alle Dosierungen gleich sein."
// * severity = #error
// * expression = "(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(\ndoseAndRate.exists() implies\n  (\n    %resource.dosageInstruction.doseAndRate.dose.ofType(Quantity).code | \n    %resource.dosageInstruction.doseAndRate.dose.ofType(Range).low.code | \n    %resource.dosageInstruction.doseAndRate.dose.ofType(Range).high.code\n  ).distinct().count() = 1\n)"

// Invariant: DosageWarnungViererschemaInText
// Description: "Hinweis: In Dosage.text wurde ein Viererschema (z. B. 1-1-1-1) erkannt. Bitte prüfen, ob dies strukturiert abgebildet werden kann."
// * severity = #warning
// * expression = "text.exists() implies text.matches('.*\\\\d+\\\\s*[-–]\\\\s*\\\\d+\\\\s*[-–]\\\\s*\\\\d+\\\\s*[-–]\\\\d+.*').not()"

// Invariant: FreeTextSingleDosageOnlyWarning
// Description: "Wenn eine Dosierung als reiner Freitext angegeben ist, soll nur genau ein Dosage-Element existieren."
// * severity = #warning
// * expression = "(\n  (%resource.ofType(MedicationRequest).dosageInstruction |\n   %resource.ofType(MedicationDispense).dosageInstruction |\n   %resource.ofType(MedicationStatement).dosage\n  ).exists(text.exists() and timing.empty() and doseAndRate.empty())\n)\nimplies\n(\n  (%resource.ofType(MedicationRequest).dosageInstruction |\n   %resource.ofType(MedicationDispense).dosageInstruction |\n   %resource.ofType(MedicationStatement).dosage\n  ).count() = 1\n)"