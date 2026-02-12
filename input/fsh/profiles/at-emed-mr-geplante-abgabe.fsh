Profile: AtEmedMRGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-mr-geplante-abgabe
Title: "ELGA e-Med Geplante Abgabe"
Description: "**Beschreibung:** Bildet eine geplante Abgabe eines Arzneimittels aus dem zugrundeliegenden Medikationsplaneintrag des ELGA-Teilnehmers ab (\"MedicationRequest\"-Ressource).
Sie enthält das verordnete Arzneimittel und dessen Dosierung und spielgelt die Inhalte des e-Rezepts wider. Geplante Abgaben dienen somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation.
Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), die auch im e-Rezept mitgeführt wird.
Werden mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer'). Verwendet R5 Backport Extensions."
* . ^short = "Geplante Abgabe eines Arzneimittels aus dem Medikationsplan. Verwendet R5 Backport Extensions."

// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig

// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1 
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"

// IHE extension statt Backport Extension: Verwendung zu klären
* extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
* extension[offLabelUse] ^short = "Weist darauf hin, dass der verschreibende Arzt das Medikament wissentlich für eine Indikation, Altersgruppe, Dosierung oder Verabreichungsform verschrieben hat, die nicht von den Aufsichtsbehörden zugelassen ist und in der Verschreibungsinformation für das Produkt nicht erwähnt wird."

// MedicationRequest 
* identifier 1..* MS  // 1..1 MS ?
* identifier ^short = "MedicationRequest identifier = {eMed-ID}_{locally assigned ID}.
Setzt sich zusammen aus: groupIdentifier (Rezept-Klammer) und individueller Identifikation der geplanten Abgabe."

// evt. noch einschränken: unknown, draft entfernen  
* status ^short = "Status der geplanten Abgabe (im Standardfall active oder complete): active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown -> entfernen: draft, unknown"

* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt eine Anforderung und Ermächtigung 
zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann, da beide "order" 
* category 1..1 MS
* category = MedicationRequestCategoryCS#2
* category ^short = "Kategorie damit Instanz einer geplanten Abgabe von Medikationsplaneintrag
 unterschieden werden kann (beide haben intent order)"

* priority 0..0
* priority ^short = "Priorität der geplanten Abgabe: routine | urgent | asap | stat. Keine Verwendung in der geplanten Abgabe."

* doNotPerform 0..0
* doNotPerform ^short = "Gibt an, ob die geplante Abgabe untersagt ist. Keine Verwendung in der geplanten Abgabe."

* reported[x] 0..0
* reported[x] ^short = "Keine Verwendung in der geplanten Abgabe."

// --- Medication Choice: Code (PZN) ODER Medication-Resource ---
* medication[x] 1..1 MS  //Obligation auf obersten Ebenen, Rendering prüfen
* medication[x] only CodeableConcept or Reference(AtEmedMedication)  
// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS  
* medicationCodeableConcept from $cs-asp-liste (required)  // gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26) (geplant als Ablöse zur PZN), (in Vorbereitung) PCID der EMA (OID 1.2.40.0.34.4.27)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1.. // zusätzlich ausländische Codes o.ä. zulassen
// * medicationCodeableConcept.coding.system 1..
// * medicationCodeableConcept.coding.code 1..
// * medicationCodeableConcept.coding.display 1..   // Übersetzungen ermöglichen

// Reference-Variante für magistrale Zubereitung/Infusionen
* medicationReference 0..1 MS
* medicationReference only Reference(AtEmedMedication)
* medicationReference ^short = "Bei magistralen Anwendungen oder Infusionen ohne PZN."

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Österreichischer Patient für den die geplante Abgabe ausgestellt wird."

* encounter 0..0
* encounter ^short = "Keine Verwendung in der geplanten Abgabe."

* supportingInformation 0..0
* supportingInformation ^short = "Keine Verwendung in der geplanten Abgabe."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung der geplanten Abgabe."

// -- Requester ---
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + HL7ATCoreOrganization nötig 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Der Arzt oder die Ärztin, die die geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist."

* performer 0..0 
* performer ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

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

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll, eine Richtlinie, 
eine Guideline oder eine andere Definition verweist, die von diesem 
Medikationsplaneintrag ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll, eine Richtlinie, eine Richtlinie, 
eine Guideline oder eine andere Definition verweist, die von diesem 
Medikationsplaneintrag ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1 MS
* basedOn only Reference(AtEmedMRPlaneintrag)
* basedOn ^short = "Referenz auf den zugrundeliegenden Medikationsplaneintrag, auf dem diese geplante Abgabe basiert."

* groupIdentifier 1..1 MS 
* groupIdentifier ^short = "Als groupIdentifier dient die Geplante-Abgabe-ID (früher eMED-ID), 
die auch im e-Rezept mitgeführt wird. Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, 
wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."

* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Keine Verwendung in der geplanten Abgabe."

* insurance 0..0
* insurance ^short = "Keine Verwendung in der geplanten Abgabe."

* note 0..* MS
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe. TODO: zu prüfen im Kontext Korrekturvermerk"

* dosageInstruction 0..* MS
* dosageInstruction ^short = "TODO: alle Elemente + R5 Extensions prüfen"
// * dosageInstruction.patientInstruction ^short = "Anweisungen für den Patienten"
// * dosageInstruction.timing.repeat.frequency ^short = "Wiederholungen innerhalb der Dauer"
// * dosageInstruction.timing.repeat.period ^short = "Zeitraum, über den Wiederholungen erfolgen sollen"
// * dosageInstruction.timing.repeat.periodUnit ^short = "Zeiteinheit: s | min | h | d | wk | mo | a  (UCUM)"
// * dosageInstruction.timing.repeat.when from $cs-event-timing
// * dosageInstruction.timing.repeat.when ^short = "Code für den Zeitraum des Auftretens (z.B. nach dem Frühstück) https://hl7.org/fhir/R4/valueset-event-timing.html"
// * dosageInstruction.asNeeded[x] ^short = "Bedarfsmedikation"
// * dosageInstruction.doseAndRate.rate[x] 0..0
// * dosageInstruction.doseAndRate.rate[x] ^short = "Verabreichte Medikamentendosis. Keine Verwendung in der geplanten Abgabe. Zu prüfen"
// * effectiveDosePeriod ^short = "Period over which the medication is to be taken | Zeitraum, über den das Medikament eingenommen werden soll"

* dispenseRequest 0..1 MS
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels."
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der möglichen Einlösungen."

* substitution 0..1 MS
* substitution ^short = "Gibt an, ob eine Substitution Teil der Abgabe sein kann / sollte / nicht sein darf. 
Dieser Block erläutert die Absicht des verschreibenden Arztes. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. 
TODO: Eher keine Verwendung in der geplanten Abgabe, Dokumentation über Substitution erfolg in der Dispenses-Resource."

* priorPrescription 0..1 MS
* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte geplante Abgabe verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Referenenz auf DetectedIssue Ressource. Keine Verwendung in der geplanten Abgabe."

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, die verschiedene relevante Versionen 
dieser Ressource dokumentieren. Keine Verwendung in der geplanten Abgabe."

// // --- XOR-Invariant: genau eines von beiden ---
// // https://hl7.org/fhirpath/N1/
// Invariant: med-1
// Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
// Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
// Severity: #error

