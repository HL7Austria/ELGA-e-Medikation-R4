Profile: AtEmedMRGeplanteAbgabe
Parent: MedicationRequest
Id: at-emed-mr-geplante-abgabe
Title: "ELGA e-Med Geplante Abgabe"
Description: "Bildet eine geplante Abgabe eines Arzneimittels aus dem zugrundeliegenden Medikationsplaneintrag des ELGA-Teilnehmers ab (\"MedicationRequest\"-Ressource).
Sie enthält das verordnete Arzneimittel und dessen Dosierung und spielgelt die Inhalte des e-Rezepts wider. Geplante Abgaben dienen somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation.
Werden mehrere Arzneimittel gleichzeitig verordnet, wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer'). Verwendet R5 Backport Extensions."
* . ^short = "Geplante Abgabe eines Arzneimittels aus dem Medikationsplan. Verwendet R5 Backport Extensions."

// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig


// Extensions   ***************** TODO: erst mit Dosierungen besprechen
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 0..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem die Medikation eingenommen werden soll."
* extension[effectiveDosePeriod] ^definition = "Zeitraum, über den die Medikation eingenommen werden soll. Wenn mehrere dosageInstruction-Zeilen vorhanden sind (z. B. bei einer ausschleichenden Dosierung), entspricht dieser Zeitraum dem frühesten Startdatum und dem spätesten Enddatum der dosageInstructions."

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"


// IHE extension statt Backport Extension
// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
// * extension[offLabelUse] ^short = "Hinweis, dass der verschreibende Arzt das 
// Medikament wissentlich für eine nicht zugelassene Indikation, Altersgruppe, Dosierung oder Verabreichungsform 
// verschrieben hat. Derzeit keine Verwendung in der geplanten Abgabe, implizit ist dieser Bezug in Zukunft durch Referenzierung der Diagnose herstellbar."
// ENDE Extensions  ******************

* identifier 0..0 //1..* MS  Gepante-Abgabe-ID 
* identifier ^short = "Gepante-Abgabe-ID. TODO: Verwendung noch zu prüfen, evtl. basedon mit logischem Identifier ausreichend."


* status 1..1 MS
* status from GeplanteAbgabeStatusVS (required)
* status ^short = "Status der geplanten Abgabe. 
\"active\": bei Erstellung <br>
\"completed\": implizit mittels Custom Operation gesetzt, nachdem alle Abgaben durchgeführt wurden (Rezept komplett eingelöst) (TODO: prüfen) <br>
\"entered-in-error\": nach fehlerhafter Eingabe; Storno nur möglich, wenn noch keine Abgabe durchgeführt wurde <br>
\"stopped\": TODO: Verwendung zu prüfen (Status soll analog zu e-Rezept abgebildet werden) <br>
(nicht verwendet: on-hold, stopped, cancelled, draft, unknown)"

* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status: https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. Keine Verwendung in der geplanten Abgabe."

* intent 1..1 MS
* intent = #order 
* intent ^short = "Die Geplante Abgabe stellt eine Anforderung und Ermächtigung 
zum Handeln durch den Antragsteller dar, daher ist intent immer \"order\"."

// // Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann, da beide "order" 
// * category 1..1 MS
// * category = MedicationRequestCategoryCS#2 "Geplante Abgabe"
// * category ^short = "Kategorie zur Unterscheidung eines Medikationsplaneintrags von einer geplanten Abgabe (beide haben intent order)"
// //ws 2. slice für privat/kassenrezept


// Slicing Kategorie:  TESTEN
// - Kategorie zur Unterscheidung der MedicationRequests: Planeintrag und geplante Abgabe
// - Kategorie zur Unterscheidung von Kassenrezept und Privatrezept
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.code"
* category ^slicing.rules = #open
* category ^slicing.ordered = false

* category contains   
    mrcategory 1..1 MS and
    recipetype 1..1 MS




// Kategorie damit geplante Abgabe von Medikationsplaneintrag unterschieden werden kann, da beide "order" 

* category[mrcategory] = MedicationRequestCategoryCS#2 "Geplante Abgabe"
* category[mrcategory] ^short = "Kategorie zur Unterscheidung eines Medikationsplaneintrags von einer geplanten Abgabe (beide haben intent order)"
//ws 2. slice für privat/kassenrezept

// Kassenrezept oder Privatrezept
* category[recipetype] from MedicationRequestCategoryRecipeTypeVS (required)
* category[recipetype]  ^short = "Kategorie zur Unterscheidung, ob ein Kassen- oder Privatrezept erstellt wurde"
//ws 2. slice für privat/kassenrezept




* priority 0..0
* priority ^short = "Priorität der geplanten Abgabe. Keine Verwendung in der geplanten Abgabe."

* doNotPerform 0..0
* doNotPerform ^short = "Gibt an, ob die geplante Abgabe untersagt ist. Keine Verwendung in der geplanten Abgabe."

* reported[x] 0..0
* reported[x] ^short = "Keine Verwendung in der geplanten Abgabe."

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtEmedMedication)  
* medication[x] ^type.aggregation = #contained

   //ws planeintrag kann auch nur wirkstoffe enthalten; evtl. wirkstoff oder pzn; magistral, pzn, sonstige; todo bepr. mit medication ressource
* medication[x] ^short = "Das Arzneimittel wird immer in einer contained Medication Ressource dokumentiert, damit 
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
* requester 1..1 MS 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization) 
* requester ^short = "Der Arzt oder die Ärztin, die die geplante Abgabe erstellt hat und für den Inhalt verantwortlich ist 
(eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen).
TODO: Prüfen, der Rollen (HL7ATCorePractitioner nicht ausreichend)."

* performer 0..0 
* performer ^short = "Keine Verwendung in der geplanten Abgabe."

* performerType 0..0
* performerType ^short = "Keine Verwendung in der geplanten Abgabe."

* recorder 0..0
* recorder ^short = "Keine Verwendung in der geplanten Abgabe. TODO: Abstimmung der Verwendung mit e-Diagnose." 

// Grund für die Medikation 
* reasonCode 0..0 
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels als Code oder Referenz. Derzeit keine Verwendung in geplanter Abgabe."

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll (Richtlinie, Guideline) verweist, das von dieser 
geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll (Richtlinie, Guideline) verweist, das von dieser 
geplanten Abgabe ganz oder teilweise eingehalten wird. Keine Verwendung in der geplanten Abgabe."

* basedOn 1..1 MS
* basedOn only Reference(AtEmedMRPlaneintrag) 
* basedOn ^short = "Referenz auf die (aktuelle) Version des zugrundeliegenden Medikationsplaneintrags, auf dem diese geplante Abgabe basiert.
TODO: zu prüfen: zusätzliche logische Referenz: reference.identifier 
{Medikationsplaneintrag-ID}_{Medikationsplaneintrag-ID_Version}."

* groupIdentifier 1..1 MS 
* groupIdentifier ^short = "Als groupIdentifier dient die eMED-ID, die auch im e-Rezept mitgeführt wird. 
Werden von einem:r Arzt:Ärtztin mehrere Arzneimittel gleichzeitig verordnet, 
wird für jedes Arzneimittel eine geplante Abgabe mit demselben groupIdentifier erstellt (bildet 'Rezept-Klammer').
TODO: eMED-ID Wording ist evtl. aufgrund des Parallelbetriebs noch anzupassen"

* courseOfTherapyType 0..0 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Keine Verwendung in der geplanten Abgabe."

* insurance 0..0
* insurance ^short = "Keine Verwendung in der geplanten Abgabe."

* note 0..* MS  
* note ^short = "Zusätzliche Informationen zur geplanten Abgabe (Kommunikations zw. Arzt und Apotheke); die nicht die Dosierung betreffen. 
TODO: prüfen was CDA derzeit zulässt; HL7 Consultation, ob Feld benötigt" 

// DOSAGE
* dosageInstruction 0..1 //1..* MS 
* dosageInstruction only AtEmedDosage
* dosageInstruction ^short = "Angabe der Dosierinformationen. TODO: Dosiervarianten."


// DISPENSE REQUEST
* dispenseRequest 1..1 MS
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels."

* dispenseRequest.initialFill 0..0 
* dispenseRequest.initialFill.quantity ^short = "Anzahl der Einheiten für die erste Abgabe, z.B. 30 Kapseln oder 100 mg. Keine Verwendung in der geplanten Abgabe."   

* dispenseRequest.dispenseInterval 0..0 
* dispenseRequest.dispenseInterval ^short = "Mindestzeitraum zwischen den Abgaben. Keine Verwendung in der geplanten Abgabe."

* dispenseRequest.validityPeriod 1..1 MS 
* dispenseRequest.validityPeriod ^short = "Zeitraum in dem die geplante Abgabe eingelöst werden kann. Teilabgaben verlängern die Einlösedauer.
Falls das start-Datum dem authoredOn-Datum entspricht, kann die Angabe entfallen. 
Der Gültigkeitszeitraum ist abhängig von der Rezeptart. 
TODO: Evtl. automatische Berechnung des Gültigkeitszeitraums.
TODO: Fachlich zu klären, ob die Gültigkeitsdauer eingeschränkt werden darf."

* dispenseRequest.numberOfRepeatsAllowed 0..1 MS  
* dispenseRequest.numberOfRepeatsAllowed ^short = "Anzahl der weiteren möglichen Einlösungen. TODO: Invariante: Verpflichtende Eingabe, wenn Privatrezept."  

* dispenseRequest.quantity 1..1 MS
* dispenseRequest.quantity ^short = "Menge des Medikaments, die bei jeder Abgabe bereitgestellt werden soll. 
Im Fall einer Medikation mit PZN: z.B. 2 Packungen (OP2), im Fall einer Magistralen Anwendung: 1."

* dispenseRequest.expectedSupplyDuration 0..0 
* dispenseRequest.expectedSupplyDuration.value ^short = "Dauer, für die die bereitgestellte Menge des Medikaments voraussichtlich ausreicht, z.B. 30 Tage. Keine Verwendung in der geplanten Abgabe."

* dispenseRequest.performer 0..0 
* dispenseRequest.performer ^short = "Apotheke oder andere Einrichtung, die die geplante Abgabe einlösen soll. Keine Verwendung in der geplanten Abgabe."


* substitution 0..0  // ws wird nicht verwendet 
* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf oder nicht.
Erläutert die Absicht des verschreibenden Arztes. Keine Verwendung in der geplanten Abgabe." 

* priorPrescription 0..0 // 
* priorPrescription ^short = "Im Falle einer Änderung wird auf die ersetzte geplante Abgabe verwiesen. Keine Verwendung in der geplanten Abgabe."

* detectedIssue 0..0
* detectedIssue ^short = "Klinisches Problem mit Maßnahme, mittels Referenz auf Ressouce DetectedIssue. Keine Verwendung in der geplanten 
Abgabe."

* eventHistory 0..0
* eventHistory ^short = "Referenz auf Provenance-Ressourcen, die 
verschiedene relevante Versionen dieser Ressource dokumentieren. 
Keine Verwendung in der geplanten Abgabe."



// ws: invarianten: welche prüfungen innerhalb der ressource,operations, server