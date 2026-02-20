Profile: AtEmedDosage
Parent: Dosage
Id: at-emed-dosage
Title: "ELGA e-Med Dosage"
Description: "**Beschreibung:** Dosage"

// * sequence 0..1
// * sequence ^short = "Tagesdosierung: Reihenfolge 1
// Reihenfolge der Dosierungsanweisung bei mehreren Dosierungsanweisungen für einen Medikationsplaneintrag. 
// Einzeldosieung -> nicht nötig,  Bei nur einer Dosierungsanweisung kann die Angabe entfallen."
// * text 0..1
// * text ^short = "Freitext Dosierungsanweisung, falls keine strukturierte Angabe möglich."
// * additionalInstruction 0..*  //offen
// * additionalInstruction ^short = "Codierte Angaben zu zusätzlichen Anweisungen, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels.
// https://hl7.org/fhir/R4/valueset-additional-instruction-codes.html -> zusätzliche angabe durch den gda / beipackzettel info / nur magistrale zubereitungen?"
// * patientInstruction 0..1
// * patientInstruction ^short = "Freitext Anweisungen für den Patienten, z.B. zur Einnahme oder zur Aufbewahrung des Arzneimittels."
// * timing 0..1  //einzelprofile? constraints (r5: https://hl7.org/fhir/R5/datatypes.html#Timing)? invarianten? damit technisch prüfbar
// * timing ^short = "Zeitpunkt oder Zeitraum der Einnahme des Arzneimittels. 
//  Bei einmaliger Einnahme: Zeitpunkt der Einnahme, z.B. 2026-01-28T08:00:00+00:00
//  Bei regelmäßiger Einnahme: Angabe von Frequenz und Zeitraum, z.B. 1 Kapsel täglich morgens -> frequency=1, period=1, periodUnit=d"
// * asNeededBoolean 0..1  // Bedarfsmedikation auf Folie nicht abgebildet?
// * asNeededCodeableConcept 0..1  //fachlich klären; vermutlich noch nicht
// * site 0..1 // evtl aus asp-liste? eindeutig? spezielle körperstelle betreffend;
// * route 0..1 // wie gelangt medkament in den körper? zb über die haut
// * method 0..1 // Verabreichungsmethode, z.B. Infusion, Injektion, Tablette, Salbe etc. 
// * doseAndRate 0..1  //$dose-rate-type = http://terminology.hl7.org/CodeSystem/dose-rate-type
// * doseAndRate.doseQuantity
// * doseQuantity
// // inhalation 3x die woche für 30 min
// * rateRatio //evtl reicht dose aus
// * rateRange
// * rateQuantity

// * maxDosePerPeriod 0..1 //wieviele in der studen? personenspez. pro einnahmezeitpunkt zb. maximale dosis von 4 tabetten pro einnahmezeitpunkt; zb. abweichend von beipackzettel
// * maxDosePerAdministration 0..1  // weiviele per einnahme
// * maxDosePerLifetime 0..1 // ? bestrahlung? tumortherapie // nur im kontext krankenhausintern