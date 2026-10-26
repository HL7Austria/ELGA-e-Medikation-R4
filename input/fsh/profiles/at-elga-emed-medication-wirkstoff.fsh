Profile: AtElgaEmedMedicationWirkstoff
Parent: Medication
Id: at-elga-emed-medication-wirkstoff
Title: "AT ELGA e-Medikation Medication Wirkstoff"
Description: "Bildet einen Wirkstoff in der Medication-Ressource ab. Wird grundsätzlich verwendet im Planeintrag."
* id 1..1 MS
* id ^short = "Technische id der Ressource"
* meta MS
* meta.profile 1..1 MS
* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

//ASW 24.09.2026 TODO text 1..1
* text MS
* text.status ^short = "Siehe Notes - \"Regeln für den Inhalt der narrativen Teile in den Notes\"."  
//ASW 22.09.2026 TODO Beschreibung - so visualisiert wie im CDA mit XHTML -> How to fill the Narrative in -notes.html 
* text.div MS
* text.status MS

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."

* extension contains AtElgaEmedExtensionRezeptur named Rezeptur 0..0 MS

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
* amount.numerator.value 1..1 MS
* amount.numerator.code 1..1 MS
* amount.numerator.code from $vs-emed-mengenart (required)
* amount.numerator.unit MS
* amount.numerator.comparator 0..0
* amount.numerator.comparator ^short = "Fachliche Begründung: TODO"
* amount.denominator 1..1 MS
* amount.denominator.value 1..1 MS
* amount.denominator.code MS
* amount.denominator.code from $vs-emed-mengenart (required)
* amount.denominator.unit MS
* amount.denominator.comparator 0..0
* amount.denominator.comparator ^short = "Fachliche Begründung: TODO"

// TODO: prüfen, wie Freitext bei magistraler Zubereitung abgebildet wird:
// Evtl. in einer Substance-Ressource in der description (string).
* ingredient ^slicing.discriminator.type = #value
* ingredient ^slicing.discriminator.path = "isActive"
* ingredient ^slicing.rules = #open
* ingredient ^slicing.ordered = false
* ingredient contains 
    activeIngredient 1.. MS

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
//* ingredient[activeIngredient].itemCodeableConcept.coding.system 
//ASW 22.09.2026 TODO ATC Code ValueSets & CodeSysteme existieren nur teilweise am Termgit - ATC WIDO bekommt jährlich eine neue oid und kann nicht im binding verwendet werden - Problem muss gelöst werden
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.discriminator.type = #value
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.discriminator.path = "system"
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.rules = #open
* ingredient[activeIngredient].itemCodeableConcept.coding ^slicing.ordered = false
* ingredient[activeIngredient].itemCodeableConcept.coding  contains 
    ATCWidO 0..1 MS and
    WirkstoffeAges 0..1 MS 
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].system = "https://termgit.elga.gv.at/CodeSystem/atc-deutsch-wido"
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].system 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].code 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].display MS
* ingredient[activeIngredient].itemCodeableConcept.coding[ATCWidO].version MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].system = "https://termgit.elga.gv.at/CodeSystem/medikation-ages-wirkstoffe"
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].system 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].code 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].display MS
* ingredient[activeIngredient].itemCodeableConcept.coding[WirkstoffeAges].version MS
* ingredient[activeIngredient].itemCodeableConcept.coding 1..1 MS
* ingredient[activeIngredient].itemCodeableConcept ^short = "Inhaltsstoff codiert. Wirkstoff-Codes stammen aus der ATC-Klassifikation (Anatomical Therapeutic Chemical Classification), die von der WHO herausgegeben wird. Weitere Codes, wie auch die deutsche Bezeichnung der Codes, entsprechen dem GKV-Arzneimittelindex im Wissenschaftlichen Institut der AOK (WidO), AOK Bundesverband GbR, Deutschland, welcher auf den WHO ATC basiert. Zusätzlich kommen ergänzende Codes aus dem Arzneimittelverzeichnis der AGES zum Einsatz."

* ingredient 1..* MS
* ingredient ^short = "Wirkstoffe."
* ingredient.modifierExtension 0..0
* ingredient.modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."
* ingredient.item[x] MS
* ingredient.item[x] only CodeableConcept
