Profile: AtEmedMedicationRequestPlaneintrag
Parent: MedicationRequest
Id: at-emed-medicationrequest-planeintrag
Title: "ELGA e-Medikation Planeintrag"
Description: "**Beschreibung:** Bildet einen Eintrag eines Medikationsplans eines ELGA Teilnehmers ab. 
Er enthält genau ein Arzneimittel und dessen Dosierung.
Kann in weiterer Folge dazu dienen, eine geplante Abgabe zu erstellen (AtEmedMedicationRequestGeplanteAbgabe)."


// Vorgaben APS ***************************
// zu überprüfen - siehe geplante Abgabe
// Ende Vorgaben APS ***************************

// Vorgaben MPD ***************************
// zu überprüfen - siehe geplane Abgabe
// Ende Vorgaben MPD ***************************


* identifier 0..* 
* identifier ^short = "Zu prüfen, ob/wie in Medikationsplaneintrag verwendet. Geplante Abgabe-ID (e-Med-ID) steht jedenfalls erst zum Zeitpunkt der Erstellung einer geplanten Abgabe (Rezeptierung) zur Verfügung."

// evt. noch einschränken: unknown, draft entfernen
* status ^short = "Status des Medikationsplaneintrags (im Standardfall active oder complete): active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown" 

* statusReason 0..1 
* statusReason ^short = "Grund für den aktuellen Status des Medikationsplaneintrags: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Verwendung prüfen."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Der Medikationsplaneintrag stellt eine Anforderung und Ermächtigung zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// Kategorie damit Medikationsplaneintrag von geplanter Abgabe unterschieden werden kann, da beide "order" 
* category 1..1 MS
* category from MedicationRequestCategoryVS (required)
* category.coding = #1 "Medikationsplaneintrag"
* category ^short = "Kategorie damit Instanz einer geplanten Abgabe von Medikationsplaneintrag unterschieden werden kann"

* priority 0..0
* priority ^short = "Priorität des Medikationsplaneintrag: routine | urgent | asap | stat. Keine Verwendung in Medikationsplaneintrag."

* doNotPerform 0..1
* doNotPerform ^short = "Gibt an, ob der Medikationsplaneintrag die Verordnung einer Medikation (und somit die Erstellung einer geplanten Abgabe) untersagt ist. Verwendung prüfen."

* reported[x] 0..0
* reported[x] ^short = "Gibt an, ob dieser Datensatz als sekundärer „gemeldeter” Datensatz und nicht als ursprünglicher primärer Referenzdatensatz erfasst wurde. Er kann auch die Quelle der Meldung angeben. Keine Verwendung in Medikationsplaneintrag."

// --- Medication Choice: Code (PZN) ODER Medication-Resource ---
* medication[x] 1..1 MS  //Obligation auf obersten Ebenen, Rendering prüfen
* medication[x] only CodeableConcept or Reference(AtEmedMedication)  //Obligation auf obersten Ebenen
// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS  //Obligation auf obersten Ebenen
* medicationCodeableConcept from $cs-asp-liste (required)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1.. // evtl.zusätzlich ausländische Codes o.ä. zulassen
* medicationCodeableConcept.coding.system 1..1
* medicationCodeableConcept.coding.code 1..1
* medicationCodeableConcept.coding.display 1..1   // wie funktioniert das mit Übersetzungen?

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
* supportingInformation ^short = "Zusätzliche Informationen (z. B. Größe und Gewicht des Patienten), die die Verschreibung des Medikaments unterstützen. Verwendung im Medikationsplaneintrag prüfen."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung des Medikationsplaneintrags."

// -- Requester ---
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + organization nötig 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Der Arzt oder die Ärztin, die den Medikationsplaneintrag erstellt hat und für den Inhalt verantwortlich ist."

* performer 0..0 
* performer ^short = "Der gewünschte Ausführende der medikamentösen Behandlung (z. B. der Ausführende der Medikamentengabe). Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Rollen: https://hl7.org/fhir/R4/valueset-performer-role.html. Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Die Person, die den Medikationsplaneintrag im Auftrag eines GDA eingegeben hat. Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* reasonCode 0..* MS
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz (evtl. Invariante)."

* reasonReference 0..* MS
* reasonReference ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz (evtl. Invariante)."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll, eine Richtlinie, einen Auftragssatz oder eine andere Definition verweist, die von diesem Medikationsplaneintrag ganz oder teilweise eingehalten wird. Verwendung im Medikationsplaneintrag zu prüfen."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll, eine Richtlinie, einen Auftragssatz oder eine andere Definition verweist, die von dieser Medikamentenanforderung ganz oder teilweise eingehalten wird. Verwendung im Medikationsplaneintrag zu prüfen."

* basedOn 0..1 
* basedOn only Reference(AtEmedMedicationRequestPlaneintrag)
* basedOn ^short = "Referenz auf einen zugrundeliegenden Medikationsplaneintrag. Verwendung im Medikationsplaneintrag zu prüfen: Bsp. nach einer Änderung; evtl. priorPrescription."

* groupIdentifier 0..0 
* groupIdentifier ^short = "Keine Verwendung im Medikationsplaneintrag. Erst bei der geplanten Abgabe (Rezepterstellung) relevant."

* courseOfTherapyType 0..1 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Evtl. im Medikationsplaneintrag (dosageInstruction), paused soll im Status dokumentiert werden."

* insurance 0..0
* insurance ^short = "Keine Verwendung im Medikationsplaneintrag."

* note 0..* 
* note ^short = "Zusätzliche Informationen zum Medikationsplaneintrag, die durch die anderen Attribute nicht abgebildet werden konnten. -> Dzt. unklar, ob erforderlich, evtl einschränken"

* dosageInstruction 0..* 
* dosageInstruction ^short = "Anweisungen zur Einnahme/Verabreichung des Arzneimittels."

* dosageInstruction.patientInstruction ^short = "Anweisungen für den Patienten"
* dosageInstruction.timing.repeat.frequency ^short = "Wiederholungen innerhalb der Dauer"
* dosageInstruction.timing.repeat.period ^short = "Zeitraum, über den Wiederholungen erfolgen sollen"
* dosageInstruction.timing.repeat.periodUnit ^short = "Zeiteinheit: s | min | h | d | wk | mo | a  (UCUM)"
* dosageInstruction.timing.repeat.when from http://hl7.org/fhir/ValueSet/event-timing
* dosageInstruction.timing.repeat.when ^short = "Code für den Zeitraum des Auftretens (z.B. nach dem Frühstück) https://hl7.org/fhir/R4/valueset-event-timing.html"
* dosageInstruction.asNeeded[x] ^short = "Bedarfsmedikation"

* dosageInstruction.doseAndRate.rate[x] 0..0
* dosageInstruction.doseAndRate.rate[x] ^short = "Verabreichte Medikamentendosis. Keine Verwendung im Medikationsplaneintrag. Zu prüfen"

// * effectiveDosePeriod ^short = "Period over which the medication is to be taken | Zeitraum, über den das Medikament eingenommen werden soll"

* dispenseRequest 0..1 
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels im Medikationsplan. Zu klären."
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der möglichen Einlösungen."

* substitution 0..1
* substitution ^short = "Gibt an, ob eine Substitution Teil der Abgabe sein kann / sollte / nicht sein darf. Dieser Block erläutert die Absicht des Arztes, der den Medikationsplaneintrag erstellt. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. -> Zu prüfen ob Verwendung im Medikationsplaneintrag, Dokumentation über Substitution erfolg in der Dispenses-Resource."

* priorPrescription 0..1 
* priorPrescription ^short = "Im Falle einer Änderung wird auf den ersetzten Medikationsplaneintrag verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Bezeichnet ein tatsächliches / potenzielles klinisches Problem mit oder zwischen aktiven / vorgeschlagenen klinischen Maßnahmen für einen Patienten, z. B. Wechselwirkungen zwischen Medikamenten, doppelte Therapie, Dosierungswarnung usw. Verwendung im Medikationsplaneintrag zu prüfen."

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, die verschiedene relevante Versionen dieser Ressource dokumentieren. Verwendung im Medikationsplaneintrag zu prüfen."

// // --- XOR-Invariant: genau eines von beiden ---
// // https://hl7.org/fhirpath/N1/
// Invariant: med-1
// Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
// Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
// Severity: #error

