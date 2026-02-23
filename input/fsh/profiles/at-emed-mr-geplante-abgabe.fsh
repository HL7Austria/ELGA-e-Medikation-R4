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
// Contained Ressourcen: Medication und Substance; TODO prüfen ob Substance erforderlich.

//* contained 1..*

* contained ^slicing.discriminator.type = #type
* contained ^slicing.discriminator.path = "$this"
* contained ^slicing.rules = #open

* contained contains
    medication 1..1 and
    substance 0..*

* contained[medication] only AtEmedMedication
* contained[substance] only AtEmedSubstance



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

* status MS
* status from GeplanteAbgabeStatusVS (required)
* status ^short = "Status der geplanten Abgabe (im Standardfall active oder complete): 
 (req) active | on-hold | cancelled | completed | entered-in-error | stopped  (entfernt: draft | unknown); TODO: Fachlich zu prüfen."


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

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
//* medication[x] only Reference(AtEmedMedication)  
//* medicationCodeableConcept 0..0

* medicationReference 1..1 MS 
* medicationReference only Reference(AtEmedMedication) 
* medicationReference.reference obeys contained-ref
* medicationReference ^short = "Das Arzneimittel wird immer in einer contained Medication Ressource dokumentiert, damit 
Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Patient, für den der Medikationsplaneintrag ausgestellt werden soll, der über den 
Zentralen Patientenindex identifizierbar und Teilnehmer von ELGA e-Medikation ist."

* encounter 0..0
* encounter ^short = "Aufenthalt/Begegnung, während dessen die geplante Abgabe erstellt wurde. Keine Verwendung in der geplanten Abgabe."

* supportingInformation 0..0
* supportingInformation ^short = "Referenz auf zusätzliche Informationen (Ressource Any)
(z. B. Größe und Gewicht des Patienten), die die Verschreibung des Medikaments unterstützen. 
Keine Verwendung in der geplanten Abgabe."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Ausstellung der geplanten Abgabe."

// -- Requester ---
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + HL7ATCoreOrganization nötig 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Der Arzt oder die Ärztin, die die geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist.
Eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen."

* performer 0..0 
* performer ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

// Grund für die Medikation 
* reasonCode 0..0 
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. 
Entweder Code oder Referenz (TODO: Evtl. Invariante). Erst wenn codierte Angabe möglich."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll (Richtlinie, Guideline) verweist, die von diesem 
Medikationsplaneintrag ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll (Richtlinie, Guideline) verweist, die von diesem 
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
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe. TODO: prüfen"

* dosageInstruction 1..* MS 
* dosageInstruction only AtEmedDosage
* dosageInstruction ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"
//* dosageInstruction.timing.code.coding from $vs-einnahmezeitpunkte (required)

* dispenseRequest 0..1 MS
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels."
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der möglichen Einlösungen."

* substitution 0..1 MS
* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf oder nicht.
Erläutert die Absicht des verschreibenden Arztes. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. 
Die Dokumentation über eine tatsächlich erfolgte Substitution erfolgt in der Dispense-Resource. 
TODO: Eher keine Verwendung in der geplanten Abgabe."

* priorPrescription 0..1 MS
* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte geplante Abgabe verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Klinisches Problem mit Maßnahme. Nur mittesl Referenz auf Ressouce DetectedIssue. Keine Verwendung in der geplanten Abgabe."

* eventHistory 0..0
* eventHistory ^short = "Referenz auf Provenance-Ressourcen, die verschiedene relevante Versionen dieser Ressource dokumentieren. 
Keine Verwendung in der geplanten Abgabe."

// // --- XOR-Invariant: genau eines von beiden ---
// // https://hl7.org/fhirpath/N1/
// Invariant: med-1
// Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden – aber genau eins."
// Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
// Severity: #error

