Profile: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
Parent: MedicationDispense
Id: at-elga-emed-medicationdispense-durchgefuehrteabgabe
Title: "AT ELGA e-Medikation MedicationDispense Durchgeführte Abgabe"
Description: "Profil einer \"Durchgeführten Abgabe\" eines Arzneimittels."

* id 0..1 MS
* id ^short = "Technische id der Ressource"
* meta MS
* meta.versionId MS
* meta.lastUpdated MS
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

* contained MS
* contained ^short = "Es sind nur die hier definierten contained Medication-Ressourcen zulässig. Contained (eingebettete) Ressourcen werden nicht separat versioniert, sondern ausschließlich im Rahmen der übergeordneten Ressource versioniert."
* contained only AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung

// Extensions
* extension contains $medicationdispense-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige textuelle Zusammenfassung der Dosierungsanweisungen - wird von der Fachanwendung anhand der definierten Regeln befüllt.."  // Todo Link zum Kapitel, sobald vorhanden. akl 21.10.2026
* extension[renderedDosageInstruction] MS
* extension[renderedDosageInstruction].url MS
* extension[renderedDosageInstruction].valueMarkdown MS
// Extension für Nacherfassung einer Abgabe  
* extension contains $medicationDispense-recorded-r5 named recorded 1..1
* extension[recorded] ^short = "Datum und Uhrzeit, zu denen die Geplante Abgabe erfasst wurde."
* extension[recorded] MS
* extension[recorded].url MS
* extension[recorded].valueDateTime MS
* extension contains $medicationDispense-statusChanged-r5  named statusChanged 0..1
* extension[statusChanged] ^short = "Datum der Statusänderung. Dies ist nur bei einem Status von entered-in-error relevant."  //Todo: kann nicht bei reference-plan verwendet werden, da kein Statuswechsel erfolgt; akl 22.10.2026
* extension[statusChanged] MS
* extension[statusChanged].url MS
* extension[statusChanged].valueDateTime MS
* extension contains AtElgaEmedExtensionGroupIdentifier named groupIdentifier 0..1
* extension[groupIdentifier] ^short = "Als groupIdentifier dient der \"e-Med GroupIdentifier\" der zugehörigen Geplanten Abgabe (wird auch im e-Rezept mitgeführt)."
* extension[groupIdentifier] MS
* extension[groupIdentifier].url MS
* extension[groupIdentifier].valueIdentifier MS
* extension[groupIdentifier].valueIdentifier.use 0..0
// Invariante: wenn eine Referenz auf eine geplante Abgabe existiert dann muss auch der groupIdentifier befüllt sein. Ausnahme: Alle GroupIdentifier eines Transaction Bundles sind noch leer -> werden von der Fachanwendung befüllt

* status 1..1 MS
//* status from AtElgaEmedValueSetMedicationDispenseStatusVS
* status ^short = "Status der Durchgeführten Abgabe. Mögliche Ausprägungen: [completed | cancelled | entered-in-error ] Bedeutung: completed: Die Durchgeführte Abgabe ist abgeschlossen (Einzel- oder Teilabgabe durchgeführt) | cancelled: Leerabgabe wird durchgeführt | entered-in-error: Die Durchgeführte Abgabe wird aufgrund eines Fehlers storniert."

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung)  
* medication[x] ^type.aggregation = #contained

* medication[x] ^short = "Das Arzneimittel wird in einer contained Medication Ressource oder als Conditional Reference dokumentiert. Diese kann, sofern ein zugehöriger Planeintrag und eine Geplante Abgabe vorliegen, von der dort angegebenen Medikation abweichen."
* medicationReference MS
* medicationReference.reference 1..1 MS


// --- Subject ---
* subject only Reference(AtElgaEmedPatient) 
* subject 1..1 MS
* subject ^short = "ELGA-Teilnehmer, für den die Durchgeführte Abgabe dokumentiert wird."
* subject.reference MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
//* subject.identifier.use ^short = "Fachliche Begründung: TODO"

// --- performer ---
* performer 1..1 MS
//* performer ^short = "Verantwortlicher GDA." 
* performer.function from AtElgaEmedValueSetMedicationDispensePerformerFunctionVS
//* performer.function ^short = "Rolle der Person, die die Abgabe durchgeführt hat."
* performer.actor only Reference(AtElgaEmedPractitioner or AtElgaEmedPractitionerRole or HL7ATCoreOrganization)
* performer ^slicing.discriminator[+].type = #value
* performer ^slicing.discriminator[=].path = "function.coding.code"
* performer ^slicing.rules = #closed
* performer ^slicing.ordered = false
* performer contains dispenseGDA 0..1 MS and referenceGDA 0.. MS

* performer[dispenseGDA].modifierExtension 0..0
* performer[dispenseGDA].function 1..1 MS
* performer[dispenseGDA].function ^short = "Rolle des der Abgabe durchführenden GDA. Fester Wert: dispenseGDA."
* performer[dispenseGDA].function.coding 1..1 MS
* performer[dispenseGDA].function.coding.code 1..1 MS
* performer[dispenseGDA].function.coding.code = #dispenseGDA
* performer[dispenseGDA].function.coding.system 1..1 MS
* performer[dispenseGDA].function.coding.system = Canonical(AtElgaEmedValueSetMedicationDispensePerformerFunctionCS)
* performer[dispenseGDA].function.coding.display MS
* performer[dispenseGDA].function.coding.version MS
* performer[dispenseGDA].function.text 0..0
* performer[dispenseGDA].actor 1..1 MS
* performer[dispenseGDA].actor ^short = "GDA, der die Abgabe durchführt und verantwortet."

* performer[referenceGDA].modifierExtension 0..0
* performer[referenceGDA].function 1..1 MS
* performer[referenceGDA].function ^short = "Rolle des den Planeintrag nachträglich referenzierenden GDA. Fester Wert: referenceGDA."
* performer[referenceGDA].function.coding 1..1 MS
* performer[referenceGDA].function.coding.code 1..1 MS
* performer[referenceGDA].function.coding.code = #referenceGDA
* performer[referenceGDA].function.coding.system 1..1 MS
* performer[referenceGDA].function.coding.system = Canonical(AtElgaEmedValueSetMedicationDispensePerformerFunctionCS)
* performer[referenceGDA].function.coding.display MS
* performer[referenceGDA].function.coding.version MS
* performer[referenceGDA].function.text 0..0
* performer[referenceGDA].actor 1..1 MS
* performer[referenceGDA].actor ^short = "GDA, der nachträglich eine Referenz zu einem Planeintrag herstellt."

// Slicing authorizingPrescription:  
* authorizingPrescription 0..2 MS
// - authorizingPrescription zur Unterscheidung der MedicationRequest-Referenzen: Planeintrag und Geplante Abgabe
* authorizingPrescription ^slicing.discriminator[+].type = #value
* authorizingPrescription ^slicing.discriminator[=].path = "resolve().category.coding.system"
* authorizingPrescription ^slicing.discriminator[+].type = #value
* authorizingPrescription ^slicing.discriminator[=].path = "resolve().category.coding.code"
* authorizingPrescription ^slicing.rules = #closed
* authorizingPrescription ^slicing.ordered = false

* authorizingPrescription contains   
    geplanteAbgabe 0..1 MS and
    planeintrag 0..1 MS

* authorizingPrescription[geplanteAbgabe] only Reference(AtElgaEmedMedicationRequestGeplanteAbgabe)
* authorizingPrescription[planeintrag] only Reference(AtElgaEmedMedicationRequestPlaneintrag)
* authorizingPrescription ^short = "Verpflichtende Referenzen auf zugehörige Geplante Abgabe (MedicationRequest) bzw. zugehörigen 
Planeintrag (MedicationRequest), sofern diese existieren."
// TODO Invariante oder Ergänzung durch Fachanwendung: Wenn Geplante Abgabe referenziert, muss auch auf den Planeintrag referenziert werden. 

* type 1..1 MS
* type from AtElgaEmedMedicationDispenseTypeVS
* type ^short = "Art der Abgabe. Mögliche Ausprägungen: [FFC | FFP | RFP | RFC | EM]. Bedeutung: FFC: First Fill - Complete (Beendigung einer Einzelabgabe) | FFP: First Fill - Part Fill (1. Teilabgabe oder Besorgerprozess) | RFP: Refill - Part Fill (weitere Teilabgabe) | RFC: Refill - Complete (letzte Teilabgabe) | EM: Emergency Supply."

* quantity 1..1 MS 
* quantity ^short = "Abgegebene Packungsanzahl."

* whenHandedOver 1..1 MS  
* whenHandedOver ^short = "Der Zeitpunkt, zu dem das Arzneimittel aushändigt wurde. Kann vom Erstellzeitpunkt der Durchgeführten Abgabe abweichen (z.B. bei Nacherfassung der Abgabe)."

* note 0..1 MS 
* note ^short = "Zusätzliche Informationen zur Abgabe, die nicht die Dosierung betreffen."
* note.text MS

// TODO: Invariante für repeating sequences * dosageInstruction.extension contains AtElgaEmedExtensionDosageRepeat??? named repeatCycle 0..1
//TODO Invariante sodass die Extension nur erlaubt ist, wenn es mehrere Dosages gibt
* dosageInstruction ^slicing.discriminator.type = #value
* dosageInstruction ^slicing.discriminator.path = "extension.value.ofType(CodeableConcept).coding.code"
* dosageInstruction ^slicing.rules = #closed
* dosageInstruction ^slicing.ordered = false
* dosageInstruction 1..* MS
* dosageInstruction contains   
    //otherDosage 0.. MS and //TODO zukünftige Erweiterung
    //timedDosage 0.. MS and //TODO zukünftige Erweiterung
    //frequencyDosage 0.. MS and //TODO zukünftige Erweiterung
    freitextDosage 0.. MS and
    standardDosage 0.. MS
// DOSAGE
//* dosageInstruction[otherDosage] only AtElgaEmedDosageOtherAdministration
//* dosageInstruction[timedDosage] only AtElgaEmedDosageTimedAdministration
//* dosageInstruction[frequencyDosage] only AtElgaEmedDosageFrequencyAdministration
* dosageInstruction[freitextDosage] only AtElgaEmedDosageFreeTextAdministration
* dosageInstruction[standardDosage] only AtElgaEmedDosageStandardAdministration

//TODO Dosage und AtElgaEmedDosageDosierung entfernen sobald Dosierungen fertig sind
* dosageInstruction ^short = "Gibt an, wie das abgegebene Arzneimittel vom Patienten einzunehmen ist. Diese kann, sofern ein zugehöriger Planeintrag und eine Geplante Abgabe vorliegen, von der dort angegebenen Dosierung abweichen."
