Profile: AtElgaEmedMedicationRequestGeplanteAbgabe
Parent: AtElgaEmedMedicationRequestBase
Id: at-elga-emed-medicationrequest-geplanteabgabe
Title: "At ELGA e-Medikation MedicationRequest Geplante Abgabe"
Description: "Profil einer \"Geplanten Abgabe\" eines Arzneimittels aus dem Medikationsplan."

// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."
* extension[effectiveDosePeriod] MS
* extension[effectiveDosePeriod].url MS
* extension[effectiveDosePeriod].valuePeriod MS
* extension[effectiveDosePeriod].valuePeriod.start MS
* extension[effectiveDosePeriod].valuePeriod.end MS

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige textuelle Zusammenfassung der Dosierungsanweisungen - wird von der Fachanwendung anhand der definiert Regeln befüllt."
* extension[renderedDosageInstruction] MS
* extension[renderedDosageInstruction].url MS
* extension[renderedDosageInstruction].valueMarkdown MS

// IHE extension statt Backport Extension
// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
// * extension[offLabelUse] ^short = "Hinweis, dass der verschreibende Arzt das 
// Medikament wissentlich für eine nicht zugelassene Indikation, Altersgruppe, Dosierung oder Verabreichungsform 
// verschrieben hat. Derzeit keine Verwendung in der geplanten Abgabe, implizit ist dieser Bezug in Zukunft durch Referenzierung der Diagnose herstellbar."
// ENDE Extensions  ******************

//* identifier ^short = "Logischer Identifier. Keine Verwendung in der geplanten Abgabe." // TODO: Verwendung noch zu prüfen, evtl. basedon mit logischem Identifier ausreichend."

* status 1..1 MS
* status from GeplanteAbgabeStatusVS (required)
* status ^short = "Status der geplanten Abgabe. Mögliche Ausprägung: [active | completed | entered-in-error | stopped]. Bedeutung: active: offene, Geplante Abgabe | completed: Geplante Abgabe abgeschlossen | entered-in-error: nach fehlerhafter Eingabe; Storno nur möglich, wenn noch keine zugehörige Abgabe durchgeführt wurde | stopped: Verwendung zu prüfen (Status soll analog zu e-Rezept abgebildet werden)"
//(nicht verwendet: on-hold, cancelled, draft, unknown)
// completed: evtl. implizit mittels Custom Operation gesetzt, nachdem alle Abgaben durchgeführt wurden (Rezept komplett eingelöst) (TODO: techn. prüfen)

// * statusReason ^short = "Grund des aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt einen Auftrag zur Durchführung und eine Autorisierung des Verfassers dar; daher ist intent immer \"order\"."

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
* category[mrcategory].text ^short = "Fachliche Begründung: TODO"
* category[mrcategory] ^short = "Kategorie zur Unterscheidung eines Medikationsplaneintrags von einer geplanten Abgabe (beide haben intent order)"
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


// * priority ^short = "Priorität der geplanten Abgabe. Keine Verwendung in der geplanten Abgabe."

* doNotPerform 0..0
* doNotPerform ^short = "Fachliche Begründung: Die geplante Abgabe bildet einen positiven Abgabeauftrag ab; ein ausdrückliches Verbot einer Abgabe wird nicht als eigene geplante Abgabe dokumentiert."
// * doNotPerform ^short = "Gibt an, ob die Geplante Abgabe untersagt ist. Keine Verwendung in der geplanten Abgabe."

* reported[x] 0..0
* reported[x] ^short = "Fachliche Begründung: Die geplante Abgabe wird als Auftrag dokumentiert; eine Kennzeichnung als lediglich berichteter Auftrag würde die Bedeutung der Ressource verändern und wird daher nicht verwendet."

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung)  
* medication[x] ^type.aggregation = #contained

   //ws planeintrag kann auch nur wirkstoffe enthalten; evtl. wirkstoff oder pzn; magistral, pzn, sonstige; todo bepr. mit medication ressource
* medication[x] ^short = "Das Arzneimittel wird in einer contained Medication Ressource oder als logische Referenz dokumentiert, damit Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."
* medicationReference MS
* medicationReference.reference MS
// ASW TODO 14.10. medication hat keinen identifier - conditional reference im tx bundle - wie einschränken für unterschied zw. schreiben und lesen?
//* medicationReference.identifier MS
//* medicationReference.identifier.system MS
//* medicationReference.identifier.value MS


// --- Subject ---
* subject only Reference(AtElgaCorePatient) 
* subject 1..1 MS
* subject ^short = "Patient, für den die Geplante Abgabe ausgestellt werden soll (über Zentralen Patientenindex identifiziert und Teilnehmer von ELGA e-Medikation)."
* subject.reference MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
* subject.identifier.use ^short = "Fachliche Begründung: TODO"

//* supportingInformation ^short = "Referenz auf zusätzliche Informationen (Ressource Any) (z. B. Größe und Gewicht des Patienten), die die Verschreibung des Medikaments unterstützen. Keine Verwendung in der geplanten Abgabe."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung der geplanten Abgabe."  

// -- Requester ---
* requester 1..1 MS 
* requester only Reference(AtElgaCorePractitioner or AtElgaCorePractitionerRole or HL7ATCoreOrganization) 
* requester ^short = "Der Arzt oder die Ärztin, die die Geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist 
(eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen)."
//TODO: HL7ATCore-Practitioner-Profile profilieren."

* requester.reference MS
* requester.identifier MS
* requester.identifier.system MS
* requester.identifier.value MS

//* recorder ^short = "Person der Dateineingabe. Keine Verwendung in der geplanten Abgabe." //  TODO: Gemäß Vorgaben im CDA, keine Verwendung. Abstimmung der Verwendung mit e-Diagnose." 

//* reasonCode from $cs-sct (required)
//* reasonCode ^short = "Grund für die Verordnung des Arzneimittels als Code oder Referenz. Bis zur Verfügbarkeit von e-Diagnose keine Verwendung in geplanter Abgabe."

//* instantiatesCanonical ^short = "URL, die auf eine Richtlinie/Guideline verweist, die von dieser geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

//* instantiatesUri ^short = "URL, die auf eine externe gepflegte Richtlinie/Guideline verweist, die von dieser geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1 MS
* basedOn only Reference(AtElgaEmedMedicationRequestPlaneintrag) 
* basedOn ^short = "Referenz auf die (aktuelle) Version des zugrundeliegenden Medikationsplaneintrags, auf dem diese Geplante Abgabe basiert."
// TODO: zu prüfen: zusätzliche logische Referenz: reference.identifier 
// {Medikationsplaneintrag-ID}_{Medikationsplaneintrag-ID_Version}."
* basedOn.reference MS

* groupIdentifier 0..1 MS
* groupIdentifier ^short = "Als groupIdentifier dient die eMED-ID, die auch im e-Rezept mitgeführt wird. 
Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine 
Geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."
//TODO: eMED-ID Wording ist evtl. aufgrund des Parallelbetriebs noch anzupassen"
* groupIdentifier.system MS
* groupIdentifier.value MS

//TODO ASW 12.10.2026 im Planeintrag vorhanden - hier auch relevant?
* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Keine Verwendung in der geplanten Abgabe."


//* insurance ^short = "Versicherungsinformatinen als Coverage oder ClaimResponse Resource. Keine Verwendung in der geplanten Abgabe."

* note 0..* MS  
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe (Kommunikation zwischen Arzt und Apotheke, die nicht die Dosierung betreffen)." 
//TODO: prüfen was CDA derzeit zulässt; HL7 Consultation, ob Feld benötigt" 
* note.text MS
* note.time MS

//TODO Dosage und AtElgaEmedDosageDosierung entfernen sobald Dosierungen fertig sind
* dosageInstruction MS
* dosageInstruction ^short  = "Angabe der Dosierinformationen strukturiert oder als Freitext." //TODO: Inhalte AtElgaEmedDosageDosierung fachlich prüfen.

// DISPENSE REQUEST
* dispenseRequest 1..1 MS
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels."

//* dispenseRequest.initialFill.quantity ^short = "Anzahl der Einheiten für die erste Abgabe, z.B. 30 Kapseln oder 100 mg. Keine Verwendung in der geplanten Abgabe."   

//* dispenseRequest.dispenseInterval ^short = "Mindestzeitraum zwischen den Abgaben. Keine Verwendung in der geplanten Abgabe."

* dispenseRequest.validityPeriod 1..1 MS 
* dispenseRequest.validityPeriod ^short = "Gültigkeitszeitraum einer Geplante Abgabe (abhängig von Rezeptart): Kassenrezept: ab Erstelldatum 1 Monat, bei Teilabgabe verlängert sich Gültigkeitsdauer auf 3 Monate („Besorger“-Prozess). Privatrezept: ab Erstelldatum max. 365 Tage, die Gültigkeitsdauer kann vom Arzt definiert werden. Substitutionsrezept: Max. Gültigkeitsdauer 12 Monate."
* dispenseRequest.validityPeriod ^definition = """
Zeitraum in dem die Geplante Abgabe eingelöst werden kann.
Der Gültigkeitszeitraum ist abhängig von der **Rezeptart**: 
* **Kassenrezept**: ab Erstelldatum einen Monat gültig (vom Ausstellungszeitpunkt bis zum gleichen Tag des Folgemonats 23:59 Uhr); validityPeriod.start kein Datum in der Zukunft; bei einer Teilabgabe verlängert sich die gesamte Gültigkeitsdauer auf 3 Monate („Besorger“-Prozess).
* **Privatrezept**: ab Erstelldatum maximal 365 Tage gültig, wenn die erste Einlösung innerhalb von 1 Monat ab Erstelldatum erfolgt (sonst Status abgelaufen). validityPeriod.start kein Datum in der Zukunft; Die Gültigkeitsdauer (validityPeriod.end) kann vom Arzt definiert werden.
* **Substitutionsrezept**: Maximale Gültigkeitsdauer 12 Monate. Das validityPeriod.start darf maximal einen Monat in der Zukunft liegen, gültig bis das validityPeriod.end erreicht ist.
"""
* dispenseRequest.validityPeriod.start MS
* dispenseRequest.validityPeriod.end MS
// TODO: Techn. Prüfung der Gültigkeitszeiträume
// Falls das validityPeriod.start dem authoredOn-Datum entspricht, kann das start-Datum entfallen.
// zu prüfen: Kann beim Kassenrezept validityPeriod.start in der Vergangenheit liegen, wenn die Geplante Abgabe in nachhinein erstellt wurde (z.B. wenn Arzt auf Urlaub und eine Notfallabgabe in der Apotheke durchgeführt wurde)?


* dispenseRequest.numberOfRepeatsAllowed 1..1 MS   // repeatNumber 1..1 im CDA
* dispenseRequest.numberOfRepeatsAllowed ^short = "Die Anzahl der weiteren möglichen Einlösungen (abhängig von Rezeptart): Kassenrezept: keine weitere Einlösung möglich (fixer Wert 0). Privatrezept: bis zu 6 Einlösungen, Anzahl der möglichen Einlösungen kann vom Arzt definiert werden. Substitutionsrezept: keine weitere Einlösung möglich (fixer Wert 0)"
* dispenseRequest.numberOfRepeatsAllowed ^definition = """
Anzahl der weiteren möglichen Einlösungen:
* **Kassenrezept**: keine weitere Einlösung möglich (fixer Wert 0)
* **Privatrezept**: bis zu 6 Einlösungen, Anzahl der möglichen Einlösungen kann vom Arzt definiert werden
* **Substitutionsrezept**: keine weitere Einlösung möglich (fixer Wert 0) 
"""
// TODO: Techn. Prüfung: Wenn Kassenrezept oder Substitutionsrezept, dann 0. Verpflichtende Eingabe, wenn Privatrezept, max 6.

* dispenseRequest.quantity 1..1 MS
* dispenseRequest.quantity ^short = "Menge des Medikaments, die bei jeder Abgabe bereitgestellt werden soll.
Da sich die Angaben zum Arzneimittel jeweils auf eine Packung der Arznei beziehen, MUSS die Anzahl der auszugebenden Packungen angegeben werden (mindestens 1). 
Dies gilt für Arzneimittel mit PZN und magistralen Zubereitungen."
* dispenseRequest.quantity.unit MS
* dispenseRequest.quantity.value MS
* dispenseRequest.quantity.code MS
* dispenseRequest.modifierExtension 0..0
* dispenseRequest.modifierExtension ^short = "Fachliche Begründung: Für die Abgabedetails sind keine zusätzlichen Erweiterungen vorgesehen, die deren Bedeutung verändern."


//* dispenseRequest.expectedSupplyDuration.value ^short = "Dauer, für die die bereitgestellte Menge des Medikaments voraussichtlich ausreicht. Keine Verwendung in der geplanten Abgabe."

//* dispenseRequest.performer ^short = "Apotheke oder andere Einrichtung, die die Geplante Abgabe einlösen soll. Keine Verwendung in der geplanten Abgabe."

//* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf (Absicht des Arztes, der die Geplante Abgabe erstellt). Keine Verwendung in der geplanten Abgabe." 

//* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte Geplante Abgabe verwiesen. Keine Verwendung in der geplanten Abgabe."

//* detectedIssue ^short = "Klinisches Problem mit Maßnahme, mittels Referenz auf Ressouce DetectedIssue. Keine Verwendung in der geplanten Abgabe."

// * eventHistory ^short = "Referenz auf Provenance-Ressourcen, die 
// verschiedene relevante Versionen dieser Ressource dokumentieren. 
// Keine Verwendung in der geplanten Abgabe."


// ws: invarianten: welche prüfungen innerhalb der ressource, operations, server