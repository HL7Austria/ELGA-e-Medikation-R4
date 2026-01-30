Profile: AtEmedMRPlaneintrag
Parent: MedicationRequest
Id: at-emed-mr-planeintrag
Title: "ELGA e-Med Planeintrag"
Description: "**Beschreibung:** Bildet einen Medikationsplaneintrag im Medikationsplan eines ELGA Teilnehmers ab (\"MedicationRequest\"-Ressource).
Er enthält genau ein Arzneimittel und dessen Dosierung.
Kann in weiterer Folge dazu dienen, eine geplante Abgabe zu erstellen. Verwendet R5 Backport Extensions."

// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig

// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. 
Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), 
entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"

// IHE extension statt Backport Extension: Verwendung zu klären
* extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
* extension[offLabelUse] ^short = "Weist darauf hin, dass der verschreibende Arzt das Medikament wissentlich für eine Indikation, Altersgruppe, Dosierung oder Verabreichungsform verschrieben hat, die nicht von den Aufsichtsbehörden zugelassen ist und in der Verschreibungsinformation für das Produkt nicht erwähnt wird."

* identifier 0..* MS // 1..1 MS ?
* identifier ^short = "TODO: Verwendung im Medikationsplaneintrag zu prüfen. 
Geplante-Abgabe-ID (e-Med-ID) steht jedenfalls erst zum Zeitpunkt der Erstellung einer 
geplanten Abgabe (Rezeptierung) zur Verfügung."

// evt. noch einschränken: unknown, draft entfernen
* status MS
* status ^short = "Status des Medikationsplaneintrags (im Standardfall active oder complete): 
active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown -> entfernen: draft, unknown" 

* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status des Medikationsplaneintrags: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Verwendung prüfen."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Der Medikationsplaneintrag stellt eine Anforderung und Ermächtigung 
zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// Kategorie damit Medikationsplaneintrag von geplanter Abgabe unterschieden werden kann, da beide "order" 
* category 1..1 MS
* category = MedicationRequestCategoryCS#1  //"Medikationsplaneintrag" Display nicht fixieren -> Übersetzungen
* category ^short = "Kategorie damit Instanz einer geplanten Abgabe von Medikationsplaneintrag
 unterschieden werden kann (beide haben intent order)"

* priority 0..0
* priority ^short = "Priorität des Medikationsplaneintrag: routine | urgent | asap | stat. Keine Verwendung in Medikationsplaneintrag."

// z.B. Wenn bestimmtes Medikment nicht verordnet werden darf ? Gibt es diesen Usecase?
* doNotPerform 0..1 MS
* doNotPerform ^short = "Gibt an, ob der Medikationsplaneintrag die Verordnung einer Medikation 
(und somit die Erstellung einer geplanten Abgabe) untersagt ist. Verwendung prüfen."

* reported[x] 0..0
* reported[x] ^short = "Gibt an, ob dieser Datensatz als sekundärer „gemeldeter” Datensatz und nicht als ursprünglicher primärer Referenzdatensatz erfasst wurde. 
Er kann auch die Quelle der Meldung angeben. Keine Verwendung in Medikationsplaneintrag."

// --- Medication Choice: Code (PZN) ODER Medication-Resource ---
* medication[x] 1..1 MS  //Obligation auf obersten Ebenen, Rendering prüfen
* medication[x] only CodeableConcept or Reference(AtEmedMedication)  
// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS  
* medicationCodeableConcept from $cs-asp-liste (required)   // gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26), (in Vorbereitung) PCID der EMA (OID 1.2.40.0.34.4.27)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1.. // zusätzlich ausländische Codes o.ä. zulassen
// * medicationCodeableConcept.coding.system 1..
// * medicationCodeableConcept.coding.code 1..
// * medicationCodeableConcept.coding.display 1..   // Übersetzungen ermöglichen

// Reference-Variante für magistrale Zubereitung/Infusionen
* medicationReference 0..1 MS
* medicationReference only Reference(AtEmedMedication)
* medicationReference ^short = "Bei magistralen Anwendungen oder Infusionen ohne PZN."
* obeys med-1


// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Österreichischer Patient für den der Medikationsplaneintrag ausgestellt wird."

* encounter 0..0
* encounter ^short = "Die Begegnung, während der Medikationsplaneintrag erstellt wurde. Verwendung im Medikationsplaneintrag prüfen."

* supportingInformation 0..0
* supportingInformation ^short = "Zusätzliche Informationen 
(z. B. Größe und Gewicht des Patienten), die die Verschreibung des Medikaments unterstützen. 
Es müsste eigene Ressource verlinkt werden, daher keine Verwendung im Medikationsplaneintrag."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung des Medikationsplaneintrags."

// -- Requester ---
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + HL7ATCoreOrganization nötig 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Der Arzt oder die Ärztin, die den Medikationsplaneintrag erstellt hat 
und für den Inhalt verantwortlich ist."

* performer 0..0 
* performer ^short = "Der gewünschte Ausführende der medikamentösen Behandlung 
(z. B. der Ausführende der Medikamentengabe). Keine Verwendung im Planeintrag."

* performerType 0..0
* performerType ^short = "Rollen: https://hl7.org/fhir/R4/valueset-performer-role.html. 
Keine Verwendung im Planeintrag."

* recorder 0..0
* recorder ^short = "Die Person, die den Medikationsplaneintrag im Auftrag eines GDA eingegeben hat. 
Keine Verwendung im Planeintrag."

// Grund für die Medikation
* reasonCode 0..* MS
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. 
Entweder Code oder Referenz (evtl. Invariante)."
* reasonCode.coding 1..*
// * reasonCode.coding.system 1..1 
// * reasonCode.coding.code 1..1
// * reasonCode.coding.display 1..1
* reasonReference 0..* MS
* reasonReference ^short = "Grund für die Verordnung des Arzneimittels. 
Entweder Code oder Referenz (evtl. Invariante)."

* instantiatesCanonical 0..1 MS 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll, eine Richtlinie, 
eine Guideline oder eine andere Definition verweist, die von diesem 
Medikationsplaneintrag ganz oder teilweise eingehalten wird. TODO: Verwendung 
im Medikationsplaneintrag zu prüfen."

* instantiatesUri 0..1 MS
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll, 
eine Richtlinie, eine Guideline oder eine andere Definition verweist, 
die von dieser Medikamentenanforderung ganz oder teilweise eingehalten wird. 
TODO: Verwendung im Medikationsplaneintrag zu prüfen."

* basedOn 0..0 
//* basedOn only Reference(AtEmedMRPlaneintrag)
* basedOn ^short = "TODO: Verwendung im Medikationsplaneintrag zu prüfen. Vermutlich nicht möglich, 
da keine versionsspezifischen Referenzen verwendet werden."

* groupIdentifier 0..0
* groupIdentifier ^short = "TODO: Verwendung im Medikationsplaneintrag zu prüfen. 
Erst bei der geplanten Abgabe (Rezepterstellung) relevant. Evtl ein Verweis auf erstellte Rezepte?
Würde Extension erfordern, da Kardinalität nur 0..1 zulässig"

* courseOfTherapyType 0..1 MS
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). 
Verwendung im Medikationsplaneintrag prüfen (dosageInstruction), paused soll im Status dokumentiert werden."

* insurance 0..0
* insurance ^short = "Keine Verwendung im Medikationsplaneintrag."

* note 0..* MS
* note ^short = "Zusätzliche Informationen zum Medikationsplaneintrag. TODO: zu prüfen im Kontext Korrekturvermerk"

* dosageInstruction 1..* MS
* dosageInstruction ^short = "Anweisungen zur Einnahme/Verabreichung des Arzneimittels. TODO: alle Elemente + R5 Extensions prüfen"
// * dosageInstruction.patientInstruction ^short = "Anweisungen für den Patienten"
// * dosageInstruction.timing.repeat.frequency ^short = "Wiederholungen innerhalb der Dauer"
// * dosageInstruction.timing.repeat.period ^short = "Zeitraum, über den Wiederholungen erfolgen sollen"
// * dosageInstruction.timing.repeat.periodUnit ^short = "Zeiteinheit: s | min | h | d | wk | mo | a  (UCUM)"
// * dosageInstruction.timing.repeat.when from $cs-event-timing
// * dosageInstruction.timing.repeat.when ^short = "Code für den Zeitraum des Auftretens (z.B. nach dem Frühstück) https://hl7.org/fhir/R4/valueset-event-timing.html"
// * dosageInstruction.asNeeded[x] ^short = "Bedarfsmedikation"
// * dosageInstruction.doseAndRate.rate[x] 0..0
// * dosageInstruction.doseAndRate.rate[x] ^short = "Verabreichte Medikamentendosis. Keine Verwendung im Medikationsplaneintrag."
// * effectiveDosePeriod ^short = "Period over which the medication is to be taken | Zeitraum, über den das Medikament eingenommen werden soll"

* dispenseRequest 0..0 
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels im Medikationsplan.
Keine Verwendung im Medikationsplaneintrag."

* substitution 0..1 MS
* substitution ^short = "Gibt an, ob eine Substitution Teil der Abgabe sein kann/sollte/nicht sein darf. 
Dieser Block erläutert die Absicht des Arztes, der den Medikationsplaneintrag erstellt. 
Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. 
TODO: Zu prüfen ob Verwendung im Medikationsplaneintrag; Dokumentation über Substitution erfolg in der Dispense-Resource. 
Usecase: mit welchem Medikament der Patient das Medikament ersetzen kann. Hinweis: vor allem bei
OTC Medikamenten sinnvoll, da keine geplante Abgabe dazu existiert"

* priorPrescription 0..1 MS
* priorPrescription ^short = "Im Falle einer Änderung wird auf den ersetzten 
Medikationsplaneintrag verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Bezeichnet ein tatsächliches/potenzielles klinisches Problem mit oder 
zwischen aktiven/vorgeschlagenen klinischen Maßnahmen für einen Patienten, 
z. B. Wechselwirkungen zwischen Medikamenten, doppelte Therapie, Dosierungswarnung usw. 
TODO: Es wäre eine eigene Ressource nötig, daher unrealistisch."

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, 
die verschiedene relevante Versionen dieser Ressource dokumentieren. 
TODO: Verwendung im Medikationsplaneintrag zu prüfen."

// --- XOR-Invariant: genau eines von beiden ---
// https://hl7.org/fhirpath/N1/
Invariant: med-1
Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
Severity: #error


// Invariant: epa-datetime
// Description: "dateTime muss mindestens aus Tag, Monat und Jahr bestehen"
// * severity = #error
// * expression = "toString().matches('^([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\\\.[0-9]+)?(Z|(\\\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?$')"


