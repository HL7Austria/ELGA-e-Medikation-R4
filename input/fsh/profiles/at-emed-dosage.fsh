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

//* timing only $TimingDE  // TODO    (r5: https://hl7.org/fhir/R5/datatypes.html#Timing)
* timing MS
* timing ^short = "Zeitpunkt oder Zeitraum der Einnahme des Medikaments. 
Um widersprüchliche Anweisungen zu vermeiden, ist entweder Dosage.timing oder Dosage.text zu befüllen."
// Falls eine strukturierte Dosierung als Text abgebildet werden soll, ist dafür die GeneratedDosageInstructionsMeta Extension zu verwenden.
//  Bei einmaliger Einnahme: Zeitpunkt der Einnahme, z.B. 2026-01-28T08:00:00+00:00
//  Bei regelmäßiger Einnahme: Angabe von Frequenz und Zeitraum, z.B. 1 Kapsel täglich morgens -> frequency=1, period=1, periodUnit=d"


* asNeededBoolean 0..1 MS
* asNeededBoolean ^short = "Bedarfsmedikation: Ja/Nein"
* asNeededCodeableConcept 0..0 
* asNeededCodeableConcept ^short = "Bedarfsmedikation: Grund für die Bedarfsmedikation; Vermutlich reicht ein genereller Grund für die Medikation im Planeintrag (wenn e-Diagnose verfügbar)."

* site 0..1 // evtl aus asp-liste? eindeutig? spezielle körperstelle betreffend;
* site ^short = "Körperstelle, an der das Medikament angewendet wird, z.B. Haut, Auge, Ohr etc."

* route 0..1 
* route from $cs-medikationartanwendung (required) 
* route ^short = "Verabreichungsweg, z.B. oral, nasal, intravenös, subkutan etc."

* method 0..1 // Verabreichungsmethode, z.B. Infusion, Injektion, Tablette, Salbe etc. 
* method ^short = "Verabreichungsmethode, z.B. Infusion, Injektion, Tablette, Salbe etc. "

// * doseAndRate 0..1  //$dose-rate-type = http://terminology.hl7.org/CodeSystem/dose-rate-type
// * doseAndRate.doseQuantity
// * doseQuantity
// // inhalation 3x die woche für 30 min
// * rateRatio //evtl reicht dose aus
// * rateRange
// * rateQuantity

* doseAndRate MS
* doseAndRate ^short = "Menge des verabreichten Medikaments"
* doseAndRate.doseQuantity 0..1 MS
* doseAndRate.doseQuantity only SimpleQuantity
* doseAndRate.doseQuantity from $vs-emed-mengenart (required)
//Menge in nicht-zählbaren Einheiten -> @unit 1..1 (required) aus Value-Set ELGA_MedikationMengenart
//Menge in zählbaren Einheiten (Tabletten, Kapseln, etc.) -> @unit 0..1 (otional) mit @unit aus Value-Set ELGA_MedikationMengenartAlternativ
// * doseAndRate.doseQuantity ^sliceName = "doseQuantity"
// * doseAndRate.doseQuantity ^short = "Menge des Medikaments pro Dosis"
// * doseAndRate.doseQuantity ^definition = "Menge des Medikaments pro Dosis."
// * doseAndRate.doseQuantity ^comment = "Beachten Sie, dass dies die Menge des angegebenen Medikaments angibt, nicht die Menge für die einzelnen Wirkstoffe. Jede Wirkstoffmenge kann in der Medication-Ressource kommuniziert werden. Zum Beispiel, wenn man angeben möchte, dass eine Tablette 375 mg enthält und die Dosis eine Tablette beträgt, kann man die Medication-Ressource verwenden, um zu dokumentieren, dass die Tablette aus 375 mg des Wirkstoffs XYZ besteht. Alternativ, wenn die Dosis 375 mg beträgt, muss man möglicherweise nur angeben, dass es sich um eine Tablette handelt. Bei einer Infusion wie Dopamin, bei der 400 mg Dopamin in 500 ml einer Infusionslösung gemischt werden, würde dies alles in der Medication-Ressource kommuniziert werden. Wenn die Verabreichung nicht als sofortig vorgesehen ist (Rate ist vorhanden oder Timing hat eine Dauer), kann dies angegeben werden, um die Gesamtmenge anzugeben, die über den im Zeitplan angegebenen Zeitraum verabreicht werden soll, z. B. 500 ml in der Dosis, wobei Timing verwendet wird, um anzugeben, dass dies über 4 Stunden erfolgen soll."




// * maxDosePerPeriod 0..1 //wieviele in der studen? personenspez. pro einnahmezeitpunkt zb. maximale dosis von 4 tabetten pro einnahmezeitpunkt; zb. abweichend von beipackzettel
// * maxDosePerAdministration 0..1  // weiviele per einnahme
// * maxDosePerLifetime 0..1 // ? bestrahlung? tumortherapie // nur im kontext krankenhausintern

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