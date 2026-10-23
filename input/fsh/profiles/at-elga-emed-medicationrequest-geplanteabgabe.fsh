Profile: AtElgaEmedMedicationRequestGeplanteAbgabe
Parent: AtElgaEmedMedicationRequestBase
Id: at-elga-emed-medicationrequest-geplanteabgabe
Title: "At ELGA e-Medikation MedicationRequest Geplante Abgabe"
Description: "Profil einer Geplanten Abgabe eines Arzneimittels aus dem Medikationsplan."

// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Geplanter Einnahmezeitraum. Beginn: aktuelles Datum oder in der Zukunft, Ende: Datum in der Zukunft oder unbefristet. Der geplante Einnahmezeitraum muss mit den zeitlichen Einschränkungen der Dosage übereinstimmen."
* extension[effectiveDosePeriod] MS
* extension[effectiveDosePeriod].url MS
* extension[effectiveDosePeriod].valuePeriod MS
* extension[effectiveDosePeriod].valuePeriod.start MS
* extension[effectiveDosePeriod].valuePeriod.end MS

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige textuelle Zusammenfassung der Dosierungsanweisungen - wird von der Fachanwendung anhand der definierten Regeln befüllt.."  // Todo Link zum Kapitel, sobald vorhanden. akl 21.10.2026
* extension[renderedDosageInstruction] MS
* extension[renderedDosageInstruction].url MS
* extension[renderedDosageInstruction].valueMarkdown MS

// IHE extension: Verwendung zu klären
// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 

* status 1..1 MS
* status from GeplanteAbgabeStatusVS (required)
* status ^short = "Status der Geplanten Abgabe. Mögliche Ausprägung: [active | completed | entered-in-error | stopped | cancelled]. Bedeutung: active: offene, Geplante Abgabe | completed: Geplante Abgabe abgeschlossen (automatisch durch Fachanwendung gesetzt)| entered-in-error: nach fehlerhafter Eingabe (Storno nur möglich, wenn noch keine Abgabe durchgeführt wurde) | stopped: Geplante Abgabe zeitlich abgelaufen (automatisch durch Fachanwendung gesetzt) | cancelled: Geplante Abgabe cancelled, wenn alle Durchgeführten Abgaben (jede Einlösung) den Status cancelled haben (automatisch durch Fachanwendung gesetzt)"

* intent 1..1 MS
* intent = #order 
* intent ^short = "Fixer Wert: \"order\"."

// Slicing Kategorie:  
// - Kategorie zur Unterscheidung der MedicationRequests: Planeintrag und Geplante Abgabe
// - Kategorie zur Unterscheidung von Kassenrezept und Privatrezept
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category ^slicing.ordered = false

* category contains   
    mrcategory 1..1 MS and
    recipetype 1..1 MS
//TODO ASW BUG in this slicing
* category[mrcategory] from MedicationRequestCategoryVS (required)
* category[mrcategory].coding.system = Canonical(MedicationRequestCategoryCS)
* category[mrcategory].coding.code MS
* category[mrcategory].coding.system MS
* category[mrcategory].coding.display MS
* category[mrcategory].coding.version MS
* category[mrcategory].coding.code = #GeplAbgabe (exactly)
* category[mrcategory].text 0..0
//* category[mrcategory].text ^short = "Fachliche Begründung: TODO"
* category[mrcategory] ^short = "Kategorie zur Unterscheidung einer Geplanten Abgabe von einem Planeintrag (beide haben intent order)."
//* category[recipetype] from $vs-medication-rezeptart (required)
//* category[recipetype] from elga-medikationrezeptart (required)
* category[recipetype].coding 1..1
* category[recipetype].coding.code 1..1 MS
* category[recipetype].coding.display MS
* category[recipetype].coding.version MS
* category[recipetype] from elga-medikationrezeptart (required)
* category[recipetype].coding.system = "https://termgit.elga.gv.at/CodeSystem/medikationrezeptart"
* category[recipetype].coding.system 1..1 MS
* category[recipetype].text 0..0
* category[recipetype].text ^short = "Fachliche Begründung: TODO"
* category[recipetype]  ^short = "Kategorie zur Unterscheidung, ob ein Kassen-, Privat- oder Substitutionsrezept erstellt wurde."

* doNotPerform 0..0
* doNotPerform ^short = "Fachliche Begründung: Die Geplante Abgabe bildet einen positiven Abgabeauftrag ab; ein ausdrückliches Verbot einer Abgabe wird nicht als eigene Geplante Abgabe dokumentiert."

* reported[x] 0..0
* reported[x] ^short = "Fachliche Begründung: Die Geplante Abgabe wird als Auftrag dokumentiert; eine Kennzeichnung als lediglich berichteter Auftrag würde die Bedeutung der Ressource verändern und wird daher nicht verwendet."

// --- Medication 
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung)  
* medication[x] ^type.aggregation = #contained
* medication[x] ^short = "Das Arzneimittel wird in einer contained Medication Ressource oder als Conditional Reference dokumentiert. Muss bei der Erstellung mit der medication im zugehörigen Planeintrag übereinstimmen."
* medicationReference MS
* medicationReference.reference 1..1 MS
// ASW TODO 14.10. medication hat keinen identifier - conditional reference im tx bundle - wie einschränken für unterschied zw. schreiben und lesen?
//* medicationReference.identifier MS
//* medicationReference.identifier.system MS
//* medicationReference.identifier.value MS

// --- Subject ---
* subject only Reference(AtElgaEmedPatient) 
* subject 1..1 MS
* subject ^short = "ELGA-Teilnehmer, für den die Geplante Abgabe erstellt wird."
* subject.reference MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
//* subject.identifier.use ^short = "Fachliche Begründung: TODO"

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Erstellung der Geplanten Abgabe."  

// -- Requester ---
* requester 1..1 MS 
* requester only Reference(AtElgaEmedPractitioner or AtElgaEmedPractitionerRole or HL7ATCoreOrganization) 
* requester ^short = "GDA, welcher die Geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist."
* requester.reference MS
* requester.identifier MS
* requester.identifier.system MS
* requester.identifier.value MS

//* recorder ^short = "Person der Dateineingabe. Keine Verwendung in der Geplanten Abgabe." //  TODO: Gemäß Vorgaben im CDA, keine Verwendung. Abstimmung der Verwendung mit e-Diagnose." 

//* reasonCode from $cs-sct (required)
//* reasonCode ^short = "Grund für die Verordnung des Arzneimittels als Code oder Referenz. Bis zur Verfügbarkeit von e-Diagnose keine Verwendung in Geplanter Abgabe."

* basedOn 1..1 MS
* basedOn only Reference(AtElgaEmedMedicationRequestPlaneintrag) 
* basedOn ^short = "Referenz auf die aktuelle Version des zugrundeliegenden Planeintrags, auf dem diese Geplante Abgabe basiert."
// TODO: zu prüfen: zusätzliche logische Referenz: reference.identifier 
// {Medikationsplaneintrag-ID}_{Medikationsplaneintrag-ID_Version}."
* basedOn.reference MS

* groupIdentifier 0..1 MS
* groupIdentifier ^short = "Der \"e-Med GroupIdentifier\" bildet die Rezept-Klammer. Geplante Abgaben, die demselben e-Rezept zugeordnet sind, führen denselben e-Med GroupIdentifier."
* groupIdentifier.system MS
* groupIdentifier.value MS

//TODO ASW 12.10.2026 im Planeintrag vorhanden - hier auch relevant?
* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Art der Medikation. Keine Verwendung in der Geplanten Abgabe."

* note 0..1 MS  
* note ^short = "Zusätzliche Informationen zur Geplanten Abgabe, die nicht die Dosierung betreffen." 
* note.text MS

//TODO Dosage und AtElgaEmedDosageDosierung entfernen sobald Dosierungen fertig sind
* dosageInstruction MS
* dosageInstruction ^short  = "Angabe der Dosierinformationen strukturiert oder als Freitext. Muss bei der Erstellung mit der dosageInstruction im zugehörigen Planeintrag übereinstimmen." //TODO: Inhalte AtElgaEmedDosageDosierung fachlich prüfen.

// DISPENSE REQUEST
* dispenseRequest 1..1 MS
* dispenseRequest ^short = "Informationen zur vorgesehenen Abgabe des Arzneimittels."

* dispenseRequest.validityPeriod 1..1 MS 
* dispenseRequest.validityPeriod ^short = "Gültigkeitszeitraum der Geplante Abgabe (u.a. abhängig von der Rezeptart)."
* dispenseRequest.validityPeriod.start MS
* dispenseRequest.validityPeriod.end MS
* dispenseRequest.numberOfRepeatsAllowed 1..1 MS   
* dispenseRequest.numberOfRepeatsAllowed ^short = "Die Anzahl der möglichen weiteren Einlösungen (u.a. abhängig von der Rezeptart)."
* dispenseRequest.quantity 1..1 MS
* dispenseRequest.quantity ^short = "Bereitzustellende Menge bei jeder Einlösung."
* dispenseRequest.quantity.unit MS
* dispenseRequest.quantity.value MS
* dispenseRequest.quantity.code MS
* dispenseRequest.modifierExtension 0..0
* dispenseRequest.modifierExtension ^short = "Fachliche Begründung: Für die Abgabedetails sind keine zusätzlichen Erweiterungen vorgesehen, die deren Bedeutung verändern."


