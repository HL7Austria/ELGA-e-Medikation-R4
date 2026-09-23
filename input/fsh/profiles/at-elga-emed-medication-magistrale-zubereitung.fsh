Profile: AtElgaEmedMedicationMagistraleZubereitung
Parent: Medication
Id: at-elga-emed-medication-magistrale-zubereitung
Title: "AT ELGA e-Medikation Medication Magistrale Medikation"
Description: "Bildet eine Magistrale Zubereitung in der \"Medication\"-Ressource ab. Wird grundsätzlich verwendet in Planeintrag, Geplanter Abgabe und Durchgeführter Abgabe."
* id 1..1 MS
* meta MS
* text MS
* implicitRules 0..0

* code ^short = "Code des Arzneimittels."
//ASW 22.09.2026 TODO muss noch geklärt werden in welcher Form in der magistralen Zubereitung
* code MS

* status 0..0 
* status ^short = "Keine Verwendung. Entered-in-error führt zu inkonsistenten Zuständen."

* form 0..1 MS 
* form from $vs-emed-doseform (required)
* form ^short = "Die Darreichungsform des Arzneimittels."

* amount 0..1 MS  
* amount.numerator 1..1 MS
* amount.numerator.code 1..1 MS
* amount.numerator.code from $vs-emed-mengenart (required)
* amount.denominator.value = 1
* amount.denominator.code 0..0
* amount.denominator.unit 0..0
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung."

// TODO: prüfen, wie Freitext bei magistraler Zubereitung abgebildet wird:
// Evtl. in einer Substance-Ressource in der description (string).
* ingredient 1..* MS
* ingredient ^short = "Wirkstoffe."
* ingredient.item[x] only CodeableConcept or Reference(AtElgaEmedSubstanceWirkstoff or AtElgaEmedMedicationStandardMedikation) 
//ASW 22.09.2026 TODO hier alle 3 Varianten erlaubt? Substance nur contained?
//* ingredient.itemCodeableConcept.coding.system 
//ASW 22.09.2026 TODO ATC Code ValueSets & CodeSysteme existieren nur teilweise am Termgit - ATC WIDO bekommt jährlich eine neue oid und kann nicht im binding verwendet werden - Problem muss gelöst werden
//ASW 22.09.2026 ingredient.itemCodeableConcept slice einfügen

* ingredient.itemCodeableConcept.coding ^slicing.discriminator.type = #value
* ingredient.itemCodeableConcept.coding ^slicing.discriminator.path = "$this"
* ingredient.itemCodeableConcept.coding ^slicing.rules = #open
* ingredient.itemCodeableConcept.coding ^slicing.ordered = false
* ingredient.itemCodeableConcept.coding  contains 
    ATCWidO 0..1 MS and
    WirkstoffeAges 0..1 MS 

* ingredient.itemCodeableConcept.coding[ATCWidO].system = "TODO"
* ingredient.itemCodeableConcept.coding[ATCWidO].system 1..1
* ingredient.itemCodeableConcept.coding[WirkstoffeAges] from https://termgit.elga.gv.at/ValueSet/elga-wirkstoffe-ages (required)
* ingredient.itemCodeableConcept.coding[WirkstoffeAges].system 1..1
* ingredient.itemCodeableConcept ^short = "Inhaltsstoff codiert. Wirkstoff-Codes stammen aus der ATC-Klassifikation (Anatomical Therapeutic Chemical Classification), die von der WHO herausgegeben wird. Weitere Codes, wie auch die deutsche Bezeichnung der Codes, entsprechen dem GKV-Arzneimittelindex im Wissenschaftlichen Institut der AOK (WidO), AOK Bundesverband GbR, Deutschland, welcher auf den WHO ATC basiert. Zusätzlich kommen ergänzende Codes aus dem Arzneimittelverzeichnis der AGES zum Einsatz."

* ingredient.itemReference 0..1 MS
* ingredient.itemReference ^short = "Referenz auf Substance oder enthaltene Medikation von magistraler Anwendung."

* ingredient.isActive 0..1 MS
* ingredient.isActive ^short = "Aktive Wirkstoff TRUE/FALSE"

* ingredient.strength 0..1 MS
* ingredient.strength ^short = "Menge der vorhandenen Zutaten."

* batch 0..0 // MS
//ASW 22.09.2026 offen ob 0..0
* batch ^short = "Informationen zur Charge des Arzneimittels." 
