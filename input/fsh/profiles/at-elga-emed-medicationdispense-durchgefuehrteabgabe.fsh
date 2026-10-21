Profile: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
Parent: MedicationDispense
Id: at-elga-emed-medicationdispense-durchgefuehrteabgabe
Title: "AT ELGA e-Medikation MedicationDispense Durchgeführte Abgabe"
Description: "Profil einer \"Durchgeführten Abgabe\" eines Arzneimittels aus dem Medikationsplan."

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
//ASW 22.09.2026 TODO Beschreibung - so visualisiert wie im CDA mit XHTML -> How to fill the Narrative in -notes.html 
// Bis zum Ballot nur Drachenbox
* text.div MS
* text.status MS

* implicitRules 0..0
* implicitRules ^short =  "Fachliche Begründung: Die Ressource wird nach den Regeln dieses Implementierungsleitfadens interpretiert. Zusätzliche implizite Verarbeitungsregeln werden nicht verwendet."


* contained MS
* contained ^short = "TODO"
//TODO contained short
* contained only AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung

// Extensions
* extension contains $medicationdispense-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"
* extension[renderedDosageInstruction] MS
* extension[renderedDosageInstruction].url MS
* extension[renderedDosageInstruction].valueMarkdown MS
// TODO Extension für Nacherfassung einer Abgabe  
* extension contains $medicationDispense-recorded-r5 named recorded 1..1
* extension[recorded] ^short = "Datum und Uhrzeit, zu denen die Abgabe erfasst wurde. Dies muss nicht unbedingt mit dem Zeitpunkt übereinstimmen, zu dem das Medikament dem Patienten ausgehändigt wurde (z.B. bei Nacherfassung der Abgabe)."
* extension[recorded] MS
* extension[recorded].url MS
* extension[recorded].valueDateTime MS
* extension contains $medicationDispense-statusChanged-r5  named statusChanged 0..1
* extension[statusChanged] ^short = "Datum der Statusänderung. Dies ist nur bei einem Status von: cancelled | entered-in-error | stopped relevant."
* extension[statusChanged] MS
* extension[statusChanged].url MS
* extension[statusChanged].valueDateTime MS
* extension contains AtElgaEmedExtensionGroupIdentifier named groupIdentifier 0..1
* extension[groupIdentifier] ^short = "Als groupIdentifier dient der e-Med GroupIdentifier der zugehörigen Geplanten Abgabe (wird auch im e-Rezept mitgeführt)."
* extension[groupIdentifier] MS
* extension[groupIdentifier].url MS
* extension[groupIdentifier].valueIdentifier MS
* extension[groupIdentifier].valueIdentifier.use 0..0
// Invariante: wenn eine Referenz auf eine geplante Abgabe existiert dann muss auch der groupIdentifier befüllt sein. Ausnahme: Alle GroupIdentifier eines Transaction Bundles sind noch leer -> werden von der Fachanwendung befüllt


* status 1..1 MS
//* status from AtElgaEmedValueSetMedicationDispenseStatusVS
* status ^short = "Status der Durchgeführten Abgabe. Mögliche Ausprägungen: [completed | cancelled | entered-in-error ] Bedeutung: completed: Die Durchgeführte Abgabe ist abgeschlossen. | cancelled: Leerabgabe | entered-in-error: Die Durchgeführte Abgabe wird aufgrund falscher Eingabe storniert."
// TODO: zu prüfen: 
// * ob es einen Status in-progress / preparation geben soll, z.B. wenn Bestellvorgang gestartet wurde und der typ First Fill - Part Fill ist.
// * Technische Prüfungen bezüglich Abhängigkeiten von status, typ, Rezeptart? (z.B. in-progress bei Bestellung o.ä.), evtl Operation 


// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung)  
* medication[x] ^type.aggregation = #contained

* medication[x] ^short = "Das Arzneimittel wird in einer contained Medication Ressource oder als conditional reference dokumentiert, damit Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."
* medicationReference MS
* medicationReference.reference 1..1 MS

// --- Subject ---
* subject only Reference(AtElgaEmedPatient) 
* subject 1..1 MS
* subject ^short = "Patient, für den die Geplante Abgabe ausgestellt werden soll (über Zentralen Patientenindex identifiziert und Teilnehmer von ELGA e-Medikation)."
* subject.reference MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
* subject.identifier.use ^short = "Fachliche Begründung: TODO"


* performer 1..1 MS
* performer ^short = "Durchführende Person" 
* performer.function from AtElgaEmedValueSetMedicationDispensePerformerFunctionVS
* performer.function ^short = "Rolle der Person, die die Abgabe durchgeführt hat."
* performer.actor only Reference(AtElgaEmedPractitioner or AtElgaEmedPractitionerRole or HL7ATCoreOrganization)
* performer.actor ^short = "Refrenz auf Practitioner, PractitionerRole, Organization,der/die die Durchgeführte Abgabe erstellt hat und für den Inhalt verantwortlich ist (identifiziert über den GDA-Index und berechtigt 
auf die ELGA e-Medikation des Patienten zuzugreifen)."
* performer ^slicing.discriminator[+].type = #value
* performer ^slicing.discriminator[=].path = "function"
* performer ^slicing.rules = #closed
* performer ^slicing.ordered = false
* performer contains dispenseGDA 0..1 MS and referenceGDA 0.. MS

* performer[dispenseGDA].modifierExtension 0..0
* performer[dispenseGDA].function 1..1 MS
* performer[dispenseGDA].function.coding 1..1 MS
* performer[dispenseGDA].function.coding.code 1..1 MS
* performer[dispenseGDA].function.coding.code = #dispenseGDA
* performer[dispenseGDA].function.coding.system 1..1 MS
* performer[dispenseGDA].function.coding.system = Canonical(AtElgaEmedValueSetMedicationDispensePerformerFunctionCS)
* performer[dispenseGDA].function.coding.display MS
* performer[dispenseGDA].function.coding.version MS
* performer[dispenseGDA].function.text 0..0
* performer[dispenseGDA].actor 1..1 MS

* performer[referenceGDA].modifierExtension 0..0
* performer[referenceGDA].function 1..1 MS
* performer[referenceGDA].function.coding 1..1 MS
* performer[referenceGDA].function.coding.code 1..1 MS
* performer[referenceGDA].function.coding.code = #referenceGDA
* performer[referenceGDA].function.coding.system 1..1 MS
* performer[referenceGDA].function.coding.system = Canonical(AtElgaEmedValueSetMedicationDispensePerformerFunctionCS)
* performer[referenceGDA].function.coding.display MS
* performer[referenceGDA].function.coding.version MS
* performer[referenceGDA].function.text 0..0
* performer[referenceGDA].actor 1..1 MS

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
* authorizingPrescription ^short = "Referenz auf zugehörige Geplante Abgabe (MedicationRequest), sofern diese existiert bzw. 
Planeintrag (MedicationRequest). Es muss nicht zwingend eine Geplante Abgabe referenziert werden, da es auch durchgeführte 
Abgaben ohne Geplante Abgabe geben kann (z.B. Notfall oder OTC-Medikation)."
// TODO Invariante oder Ergänzung durch Fachanwendung: Wenn Geplante Abgabe referenziert, muss auch auf den Planeintrag referenziert werden. 

// zu prüfen (gemäß CDA): 'Ohne Verordnungsbezug kann nur die Abgabe jener OTC-Präparate in der e-Medikation 
// gespeichert werden, die auch wechselwirkungsrelevant sind.'"

* type 1..1 MS
* type from AtElgaEmedMedicationDispenseTypeVS
* type ^short = "Art der Abgabe (z.B. für Teilabgaben). Mögliche Ausprägungen: [FFC | FFP | RFP | RFC | EM]. Bedeutung: FFC: First Fill - Complete | FFP: First Fill - Part Fill | RFP: Refill - Part Fill | RFC: Refill - Complete | EM: Emergency Supply."
//z.B. FFC (First-Fill Complete für vollständig erfüllte Bestellungen), FFP (First-Fill Part Fill für teilweise erfüllte Bestellungen), 
 //ffc, ffp, Refill - Part Fill, refill complete: evtl. selbst definieren
// für Leerabgabe: complete-Ausprägung; Emergency supply offen (OTC), complete

// EM	Emergency Supply: kein Geplante Abgabe (Rezept) für ein verschreibungspflichtes Rezept vorhanden
// SO	Script Owing: kein Geplante Abgabe (Rezept) für ein verschreibungspflichtes Rezept vorhanden, geplante Verordnung wird im nachhinen vom GDA erstellt (Rezept nachbringen)
// FFPS First fill, part fill, partial strength: Eine Erstabgabe, bei der die gelieferte Menge weniger als eine vollständige Wiederholung der bestellten Menge beträgt. (Beispiel: Bei einer Bestellung von 90 Tabletten und 3 Nachfüllungen könnte eine Teilabgabe nur 30 Tabletten umfassen.) Dies gilt auch, wenn die gelieferte Stärke geringer ist als die bestellte Stärke (z. B. 10 mg bei einer Bestellung von 50 mg, wobei bei einer späteren Abgabe 40-mg-Tabletten ausgegeben werden).
// FFCS first fill complete, partial strength: A first fill where the quantity supplied is equal to one full repetition of the ordered amount. (e.g. If the order was 90 tablets, 3 refills, a complete fill would be for the full 90 tablets) and also where the strength supplied is less than the ordered strength (e.g. 10mg for an order of 50mg where a subsequent fill will dispense 40mg tablets).

// Gemäß CDA: Der Prozess des „Besorgers“ (wenn ein Arzneimittel nicht lagernd ist und bestellt werden muss) wird in der e-Medikation abgebildet. 
// Dabei wird das Rezept von der Apotheke eingelöst, und die Abgabe wird als Teilabgabe gekennzeichnet 
// (siehe Markierung FFP „First Fill, Part Fill“ oder RFP „Refill - Part Fill“). 
// Die Verordnung wird nicht in den Status EINGELÖST versetzt und es können solange weitere Abgaben dispensiert werden, 
// bis eine Abgabe mit der Markierung RFC „Refill - Complete“ gespeichert wird. Die Kennzeichnung zeigt, 
// dass das Arzneimittel dem Patienten noch nicht ausgehändigt wurde. Die Kennzeichnung zeigt auch, ob alle Packungen einer Verordnung bzw. 
// teilweise Packungen einer Verordnung bestellt werden. Solange eine Abgabe mit der Kennzeichnung „Besorger“ vorhanden ist, muss die Abgabe mit der eMED-ID abrufbar sein.

* quantity 1..1 MS 
* quantity ^short = "Abgegebene Packungsanzahl."

* whenHandedOver 1..1 MS
* whenHandedOver ^short = "Der Zeitpunkt, zu dem das abgegebene Produkt dem Patienten oder seinem Vertreter zur Verfügung gestellt wurde."

* note 0..1 MS // analog zur geplanten abgabe
* note ^short = "Zusätzliche Informationen zur Abgabe, die nicht anders dokumentiert werden kann."
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
* dosageInstruction ^short = "Gibt an, wie das abgegebene Arzneimittel vom Patienten einzunehmen ist. 
Der Apotheker überprüft die Medikamentenverordnung vor der Abgabe und passt die Dosierungsanweisung gegebenenfalls auf Grundlage des tatsächlich abgegebenen Produkts an."

// * substitution.wasSubstituted 1..1
// * substitution.wasSubstituted ^short = "TRUE, wenn der Apotheker ein anderes Medikament oder Produkt als das verschriebene abgegeben hat."

// * substitution.type 0..1 MS
// * substitution.type ^short = "Typ der Substitution: z.B. E equivalent, http://terminology.hl7.org/ValueSet/v3-ActSubstanceAdminSubstitutionCode" 

// * substitution.reason 0..* MS
// * substitution.reason ^short = "Grund für die Substitution: z.B. OS out of stock, https://hl7.org/fhir/R4/v3/SubstanceAdminSubstitutionReason/vs.html"

// * substitution.responsibleParty 0..1 MS 
// * substitution.responsibleParty ^short = "Für die Subistution Verantwortlicher."
// * substitution.responsibleParty only Reference(AtElgaEmedPractitioner or AtElgaEmedPractitionerRole)
