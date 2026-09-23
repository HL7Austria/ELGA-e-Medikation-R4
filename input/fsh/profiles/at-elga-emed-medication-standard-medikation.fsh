Profile: AtElgaEmedMedicationStandardMedikation
Parent: Medication
Id: at-elga-emed-medication-standard-medikation
Title: "AT ELGA e-Medikation Medication Medikation"
Description: "Bildet ein Arzneimittel in der \"Medication\"-Ressource ab. Wird grundsätzlich verwendet in Planeintrag, Geplanter Abgabe und Durchgeführter Abgabe."
// TODO: Medication aktuell nur geprüft im Kontext Planeintrag.
// Unterschieden werden folgende Fälle:
// 1. Arzneimittel besitzt eine PZN und wird über diese identifiziert, die weiteren Informationen werden durch die Fachanwendung angereichert.
//     a. Identifikation nur über PZN: eine Befüllung jener Felder, die über die ASP-Liste angereichert werden können, durch den GDA wird technisch verhindert (Invariante oder eigene Medication Ressource).
//     b. Identifikation über PZN und Handelsname: damit eine Prüfung auf Übereinstimmung durchgeführt werden kann. TODO: Juristisch zu prüfen. 
// 3. Arzneimittel besitzt keine PZN, alle benötigten Informationen sind verpflichtend vom GDA zu befüllen:
//     a. Bei Verschreibung von Wirkstoffen
//     b. Bei magistraler Anwendung, Infusionen 

* id 1..1 MS
* meta MS
* text MS
* implicitRules 0..0


//ASW 22.09.2026 TODO slice entfernen
//ASW 22.09.2026 TODO beschreibung von PZN aus CDA
//* code 1..1 MS
//* code.coding ^slicing.discriminator.type = #value
//* code.coding ^slicing.discriminator.path = "system"
//* code.coding ^slicing.rules = #closed
//* code.coding ^slicing.ordered = false
//* code.coding contains   
//    PZN 0..1 MS and
//    PCID 0..1 MS
    //ASW 21.09.2026 TODO: noch zu klären welche weiteren identifikatoren erlaubt sind
// Invariante eines der beiden muss vorhanden sein
* code.coding.system = $cs-asp-liste
* code.coding.code 1..1
//* code.coding[PCID].system = "1.2.40.0.34.4.27" //ASW 21.09.2026: TODO Codesystem
//* code.coding[PCID].code 1..1
* code ^short = "Code des Arzneimittels. Hier muss die Pharmazentralnummer (PZN) aus der ASP-Liste angegeben werden."
* code 1..1 MS
// TODO: Slicing für meherere Codings
// Gem. CDA V3: 
// Das Codesystem Pharmazentralnummer {1.2.40.0.34.4.16} wird am Terminologieserver in der ASP-Liste (Liste der humanen Arzneispezialitäten gelistet nach PZN) publiziert, 
// die ASP-Liste enthält neben der Pharmazentralnummer {1.2.40.0.34.4.17} auch die korrespondierende Zulassungsnummer und Package Reference Number der AGES {1.2.40.0.34.4.26}. 
// Für die Kompatibilität zum EU Kontext wird zukünftig auch die PCID der EMA {1.2.40.0.34.4.27} ermöglicht."  
// * code.coding.code 0..1
// * code.coding.display 0..1
// * code.coding.display ^short = "Juristisch zu prüfen, ob mindestens ein Displayname (Handelsname) zur PZN angegeben werden muss (Zwecks Prüfung auf Übereinstimmung und 
// historischer Verfügbarkeit, im Falle von sich ändernden PZNs; evtl. könnte die Fachanwendung."

* status 0..0 
* status ^short = "Verfügbarkeitsstatus des Arzneimittels:(req) active | inactive | entered-in-error. https://hl7.org/fhir/R4/valueset-medication-status.html.
 Keine Verwendung."


* form 0..1 MS
* form from $vs-emed-doseform (required)
* form ^short = "Die Darreichungsform des Arzneimittels."
// Gem. CDA V3: 
// Für die e-Medikation ist das CodeSystem ​Medikation_Darreichungsform 1.2.40.0.10.1.4.3.4.3.5 zu verwenden.
// Für den eHDSI Kontext ist das CodeSystem 0.4.0.127.0.16.1.1.2.1 zu verwenden."

* amount 0..1 MS  
* amount.numerator 1..1 MS
* amount.numerator.code 1..1 MS
* amount.numerator.code from $vs-emed-mengenart (required)
* amount.denominator 0..0
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung."

* ingredient 0..* MS
* ingredient ^short = "Wirkstoffe."
* ingredient.item[x] only CodeableConcept or Reference(AtElgaEmedSubstanceWirkstoff or AtElgaEmedMedicationStandardMedikation) // TODO Substance profilieren
* ingredient.itemCodeableConcept 0..1 MS 
// * ingredient.itemCodeableConcept ^short = "Inhaltsstoff codiert." TODO: prüfen, Einschränkung auf SPOR (EMA). Gemüß CDA v3:
// Wirkstoff-Codes stammen aus der ATC-Klassifikation (Anatomical Therapeutic Chemical Classification), die von der WHO herausgegeben wird. 
// Weitere Codes, wie auch die deutsche Bezeichnung der Codes, entsprechen dem GKV-Arzneimittelindex im Wissenschaftlichen Institut der AOK (WidO), 
// AOK Bundesverband GbR, Deutschland, welcher auf den WHO ATC basiert.
// Zusätzlich kommen ergänzende Codes aus dem Arzneimittelverzeichnis der AGES zum Einsatz.
* ingredient.itemReference 0..1 MS
* ingredient.itemReference ^type.aggregation = #contained
//* ingredient.itemReference.reference obeys contained-sub  // contained Substance
* ingredient.itemReference ^short = "Referenz auf Ressourcen Substance im Fall von magistraler Anwendung."

* ingredient.isActive 0..1 MS
* ingredient.isActive ^short = "Aktive Wirkstoff TRUE/FALSE"

* ingredient.strength 0..1 MS
* ingredient.strength ^short = "Menge der vorhandenen Zutaten."

* batch 0..0 // MS
* batch ^short = "Informationen zur Charge des Arzneimittels." 


// Invariant: contained-sub
// Description: "Substance must be contained"
// Severity: #error
// Expression: "reference.startsWith('#')"