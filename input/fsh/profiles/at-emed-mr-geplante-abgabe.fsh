Profile: AtEmedMRGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-mr-geplante-abgabe
Title: "ELGA e-Med Geplante Abgabe"
Description: "Bildet eine geplante Abgabe eines Arzneimittels aus dem zugrundeliegenden Medikationsplaneintrag des ELGA-Teilnehmers ab (\"MedicationRequest\"-Ressource).
Sie enthält das verordnete Arzneimittel und dessen Dosierung und spielgelt die Inhalte des e-Rezepts wider. Geplante Abgaben dienen somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation.
Werden mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer'). Verwendet R5 Backport Extensions."
* . ^short = "Geplante Abgabe eines Arzneimittels aus dem Medikationsplan. Verwendet R5 Backport Extensions."

// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig
// Contained Ressourcen: Medication und Substance; TODO prüfen ob Substance erforderlich.

//* contained 1..*

// TODO: zu prüfen: Umsetzung von contained Ressorcen
* contained ^slicing.discriminator.type = #type
* contained ^slicing.discriminator.path = "$this"
* contained ^slicing.rules = #open

* contained contains
    medication 1..1 and
    substance 0..*

* contained[medication] only AtEmedMedication
* contained[substance] only AtEmedSubstance

// Extensions   ***************** TODO: erst mit Dosierungen besprechen
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"


// IHE extension statt Backport Extension: TODO: Verwendung zu klären
* extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
* extension[offLabelUse] ^short = "Weist darauf hin, dass der verschreibende Arzt das 
Medikament wissentlich für eine Indikation, Altersgruppe, Dosierung oder Verabreichungsform 
verschrieben hat, die nicht von den Aufsichtsbehörden zugelassen ist und in der 
Verschreibungsinformation für das Produkt nicht erwähnt wird." //ws: kein Usecase derzeit; implizit durch diagnose verknüfung in zukunft
// ENDE Extensions  ******************

* identifier 1..* MS  // 1..1 MS ?
* identifier ^short = "Gepante-Abgabe-ID ? Verwendung prüfen." //ws: nicht nötig, wenn bei based on logischer identifier verwendet wird


* status 1..1 MS
* status from GeplanteAbgabeStatusVS (required)
* status ^short = "Status der geplanten Abgabe (im Standardfall active oder complete): 
 (req) active | on-hold | cancelled | completed | entered-in-error | stopped  (entfernt: draft | unknown); TODO: Fachlich zu prüfen."
//ws: status bei der erstellung active ; implizit wenn alle abgaben durchgeführt, mittels operation möglich; bleibt offen, bis komplett eingelöst
// on-hold, stopped, cancelled nicht für geplante abgabe; wie e-rezept storno: nur wenn noch keine durchgeführte abgabe, storno möglich


* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt eine Anforderung und Ermächtigung 
zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann, da beide "order" 
* category 1..1 MS
* category = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category ^short = "Kategorie zur Unterscheidung eines Medikationsplaneintrags von einer geplanten Abgabe (beide haben intent order)"
//ws 2. slice für privat/kassenrezept


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
* medicationReference only Reference(AtEmedMedication)   //ws planeintrag kann auch nur wirkstoffe enthalten; evtl. wirkstoff oder pzn; magistral, pzn, sonstige; todo bepr. mit medication ressource
* medicationReference.reference obeys contained-ref
* medicationReference ^short = "Das Arzneimittel wird immer in einer contained Medication Ressource dokumentiert, damit 
Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Patient, für den die geplante Abgabe ausgestellt werden soll (über Zentralen Patientenindex identifiziert und Teilnehmer von ELGA e-Medikation)."

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
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization) //HL7ATCorePractitioner nicht ausreichend
* requester ^short = "Der Arzt oder die Ärztin, die die geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist 
(eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen)"

* performer 0..0 
* performer ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Keine Verwendung in der geplanten Abgabe."  //ws mit ediagnose abstimmen, wie verwendung

// Grund für die Medikation 
* reasonCode 0..0 
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. 
Entweder Code oder Referenz (TODO: Evtl. Invariante). Verwendung in geplanter Abgabe prüfen."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll (Richtlinie, Guideline) verweist, das von dieser 
geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll (Richtlinie, Guideline) verweist, das von dieser 
geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1 MS
* basedOn only Reference(AtEmedMRPlaneintrag)  // zeigt auf aktuelle Ressource
* basedOn ^short = "Referenz auf den zugrundeliegenden Medikationsplaneintrag, auf dem diese geplante Abgabe basiert."
// TODO: hier könnte zusätzlich eine logische Referenz ergänzt werden: reference.identifier
// {Medikationsplaneintrag-ID}_{Medikationsplaneintrag-ID_Version}.

* groupIdentifier 1..1 MS 
* groupIdentifier ^short = "Als groupIdentifier dient die eMED-ID, die auch im e-Rezept mitgeführt wird. 
Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, 
wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer')."
//ws wording emed-id evtl aufgrund von parallelbetrieb noch anzupassen

* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Keine Verwendung in der geplanten Abgabe."

* insurance 0..0
* insurance ^short = "Keine Verwendung in der geplanten Abgabe."

* note 0..* MS
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe. TODO: prüfen" //ws: analog zu cda? keine anmerkungen betreffend dosierung
// kommunikation zw. arzt und apotheker; hl7 consult. ob feld nötig

// DOSAGE
* dosageInstruction 0..1 //1..* MS 
* dosageInstruction only AtEmedDosage
* dosageInstruction ^short = "Angabe der Dosierinformationen. TODO: Dosiervarianten."


// DISPENSE REQUEST
* dispenseRequest 1..1 MS
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels. TODO: alle Elemente fachlich zu prüfen."

* dispenseRequest.initialFill 0..0 
* dispenseRequest.initialFill.quantity ^short = "Anzahl der Einheiten für die erste Abgabe, z.B. 30 Kapseln oder 100 mg."   

* dispenseRequest.dispenseInterval 0..0 
* dispenseRequest.dispenseInterval ^short = "Mindestzeitraum zwischen den Abgaben."

* dispenseRequest.validityPeriod 1..1 MS  //ws: teilabgaben verlängern einlösedauer 
* dispenseRequest.validityPeriod ^short = "Zeitraum in dem die geplante Abgabe eingelöst werden kann."
//ws: startdatum = authoredOn (weglassen, wenn gleich); enddatum = 30 Tage später
// client oder serverseitig
// todo: fachlich zu klären, ob gültigkeitsdauer eingeschränkt werden kann; unterscheidung kasse/privat


* dispenseRequest.numberOfRepeatsAllowed 0..1 MS   //ws: wenn privatrezept verpflichtende angabe; 
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der weiteren möglichen Einlösungen."  

* dispenseRequest.quantity 1..1 MS
* dispenseRequest.quantity ^short = "Menge des Medikaments, die bei jeder Abgabe bereitgestellt werden soll, z.B. 2 Packungen (OP2)."
// ws: für pzn und magistral möglich

* dispenseRequest.expectedSupplyDuration 0..0 
* dispenseRequest.expectedSupplyDuration.value ^short = "Dauer, für die die bereitgestellte Menge des Medikaments voraussichtlich ausreicht, z.B. 30 Tage."

* dispenseRequest.performer 0..0 
* dispenseRequest.performer ^short = "Apotheke oder andere Einrichtung, die die geplante Abgabe einlösen soll. Keine Verwendung in der geplanten Abgabe."


* substitution 0..0  // ws wird nicht verwendet 
* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf oder nicht.
Erläutert die Absicht des verschreibenden Arztes. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. 
Die Dokumentation über eine tatsächlich erfolgte Substitution erfolgt in der Dispense-Resource. 
TODO: Verwendung in der geplanten Abgabe prüfen." // usecase pflege als begründung ergänzen

* priorPrescription 0..0 // 
* priorPrescription ^short = "Im Falle einer Änderung wird auf die 
ersetzte geplante Abgabe verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Klinisches Problem mit Maßnahme. Nur mittesl 
Referenz auf Ressouce DetectedIssue. Keine Verwendung in der geplanten 
Abgabe."

* eventHistory 0..0
* eventHistory ^short = "Referenz auf Provenance-Ressourcen, die 
verschiedene relevante Versionen dieser Ressource dokumentieren. 
Keine Verwendung in der geplanten Abgabe."


// // --- XOR-Invariant: genau eines von beiden ---
// // https://hl7.org/fhirpath/N1/
// Invariant: med-1
// Description: "Für die geplante Abgabe muss entweder CodeableConcept (PZN) oder Reference(Medication) angegeben werden."
// Expression: "medicationCodeableConcept.exists() xor medicationReference.exists()"
// Severity: #error

// ws: invarianten: welche prüfungen innerhalb der ressource,operations, server