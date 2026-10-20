Profile: AtElgaEmedMedicationMagistraleZubereitung
Parent: Medication
Id: at-elga-emed-medication-magistrale-zubereitung
Title: "AT ELGA e-Medikation Medication Magistrale Medikation"
Description: "Bildet eine Magistrale Zubereitung in der \"Medication\"-Ressource ab. Wird grundsätzlich verwendet in Planeintrag, Geplanter Abgabe und Durchgeführter Abgabe."
* id 1..1 MS
* id ^short = "Technische id der Ressource"
* meta MS
* meta.profile 1..1 MS
* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

//ASW 24.09.2026 TODO text 1..1
* text MS
//ASW 22.09.2026 TODO Beschreibung - so visualisiert wie im CDA mit XHTML -> How to fill the Narrative in -notes.html 
// Bis zum Ballot nur Drachenbox
* text.div MS
* text.status MS

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* extension contains AtElgaEmedExtensionRezeptur named Rezeptur 0..1 MS
* extension[Rezeptur].valueMarkdown 1..1 MS
* extension[Rezeptur].valueMarkdown ^short = "Angabe der Rezeptur für die Zubereitung"

* code MS
* code.text 1..1 MS
* code.text ^short = "Titel der Medikation"
* status 0..0 
* status ^short = "Keine Verwendung. Entered-in-error führt zu inkonsistenten Zuständen."

* form 0..1 MS 
* form from $vs-emed-doseform (required)
* form ^short = "Die Darreichungsform des Arzneimittels."

* amount 0..1 MS  
* amount.numerator 1..1 MS
* amount.numerator.code 1..1 MS
* amount.numerator.code from $vs-emed-mengenart (required)
* amount.numerator.comparator 0..0
* amount.numerator.comparator ^short = "Fachliche Begründung: TODO"
* amount.denominator.value = 1
* amount.denominator.code 0..0
* amount.denominator.unit 0..0
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung."

// TODO: prüfen, wie Freitext bei magistraler Zubereitung abgebildet wird:
// Evtl. in einer Substance-Ressource in der description (string).
* ingredient 1..* MS
* ingredient ^short = "Wirkstoffe."
* ingredient ^slicing.discriminator.type = #value
* ingredient ^slicing.discriminator.path = "isActive"
* ingredient ^slicing.rules = #open
* ingredient ^slicing.ordered = false
* ingredient contains 
    activeIngredient 0.. MS and
    inactiveIngredient 0.. MS 

* ingredient[activeIngredient].isActive = true
* ingredient[activeIngredient].isActive MS
* ingredient[activeIngredient].modifierExtension 0..0
* ingredient[activeIngredient].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* ingredient[activeIngredient].strength 0..1 MS
* ingredient[activeIngredient].strength ^short = "Menge der vorhandenen Zutaten."  // Menge des Wirkstoffs?

* ingredient[activeIngredient].item[x] only CodeableConcept
* ingredient[activeIngredient].itemCodeableConcept 1..1 MS 
* ingredient[activeIngredient].itemCodeableConcept.text 0..0
* ingredient[activeIngredient].itemCodeableConcept.text ^short = "Fachliche Begründung: TODO"
* ingredient[activeIngredient].itemCodeableConcept.coding 1..1 MS
//* ingredient[activeIngredient].itemCodeableConcept.coding.system 
//ASW 22.09.2026 TODO ATC Code ValueSets & CodeSysteme existieren nur teilweise am Termgit - ATC WIDO bekommt jährlich eine neue oid und kann nicht im binding verwendet werden - Problem muss gelöst werden
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.discriminator.type = #value
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.discriminator.path = "$this"
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.rules = #open
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.ordered = false
* ingredient[activeIngredient].itemCodeableConcept.coding  contains 
    ATCWidO 0..1 MS and
    WirkstoffeAges 0..1 MS 
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO] from AtElgaEmedValueSetATC (required)
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].system 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].code 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].display MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].version MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges] from https://termgit.elga.gv.at/ValueSet/elga-wirkstoffe-ages (required)
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].system 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].code 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].display MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].version MS
* ingredient[activeIngredient].itemCodeableConcept ^short = "Inhaltsstoff codiert. Wirkstoff-Codes stammen aus der ATC-Klassifikation (Anatomical Therapeutic Chemical Classification), die von der WHO herausgegeben wird. Weitere Codes, wie auch die deutsche Bezeichnung der Codes, entsprechen dem GKV-Arzneimittelindex im Wissenschaftlichen Institut der AOK (WidO), AOK Bundesverband GbR, Deutschland, welcher auf den WHO ATC basiert. Zusätzlich kommen ergänzende Codes aus dem Arzneimittelverzeichnis der AGES zum Einsatz."

* ingredient[inactiveIngredient].isActive = false
* ingredient[inactiveIngredient].isActive MS
* ingredient[inactiveIngredient].modifierExtension 0..0
* ingredient[inactiveIngredient].modifierExtension ^short = "Fachliche Begründung: Es sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* ingredient[inactiveIngredient].strength 0..1 MS
* ingredient[inactiveIngredient].strength ^short = "Menge der vorhandenen Zutaten."  // Menge des Wirkstoffs?
* ingredient[inactiveIngredient].item[x] only CodeableConcept
* ingredient[inactiveIngredient].itemCodeableConcept 1..1 MS
* ingredient[inactiveIngredient].itemCodeableConcept.text MS


* batch 0..0 // MS
//ASW 22.09.2026 offen ob 0..0
* batch ^short = "Informationen zur Charge des Arzneimittels." 
