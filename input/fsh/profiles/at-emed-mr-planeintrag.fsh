Profile: AtEmedMRPlaneintrag
Parent: MedicationRequest
Id: at-emed-mr-planeintrag
Title: "ELGA e-Med Planeintrag"
Description: "**Beschreibung:** Bildet einen Medikationsplaneintrag im Medikationsplan eines ELGA-Teilnehmers ab (\"MedicationRequest\"-Ressource).
Er enthält genau ein Arzneimittel und dessen Dosierung.
Kann in weiterer Folge dazu dienen, eine geplante Abgabe zu erstellen. Verwendet R5 Backport Extensions."

// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig
// Contained Ressourcen: Medication und Substance; TODO prüfen ob Substance erforderlich.

//* contained 1..*

* contained ^slicing.discriminator.type = #type
* contained ^slicing.discriminator.path = "$this"
//* contained ^slicing.discriminator.path = "resource"    //Unterschied?
//* contained ^slicing.discriminator.path = "resourceType"

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
// ENDE Extensions

* identifier 1..1  // sonst 0..* 
* identifier ^short = "Medikationsplaneintrag-ID. TODO: Verwendung einer logischen Medikationsplaneintrag-ID prüfen.
Evt. mit Zeitstempel (Planeintrag-ID_{Zeitstempel}) zur Herstellung eines Bezugs von geänderten Planeinträgen.
Vorteil: 
- Auch wenn sich die PZN ändert, aber logisch der gleiche Eintrag betroffen ist (z.B. Austausch eines Arzneimittels durch ein anderes mit weniger Wechselwirkung), kann ein Bezug hergestellt werden.
- Wenn zur Vorversion des Eintrags bereits eine geplante Abgabe erstellt wurde, kann ein Bezug zum ursprünglichen Eintrag hergestellt werden.
Nachteil: 
- Falls Planeinträge mit komplett neuer Arznei überschrieben werden, entsteht dadurch ein verwirrender Bezug. 
- Die Verantwortung, dass nur Einträge geändert werden, die keine komplett neue Medikation beinhalten, liegt beim Client."

* status 1..1 MS
* status from MedikationsplaneintragStatusVS (required)
* status ^short = "Status des Medikationsplaneintrags. VS Einschränkung auf active, complete, on-hold, stopped (?); TODO: Fachlich zu püfen, ob im Medikationsplan dokumentiert werden soll, dass und warum ein Medikament abgesetzt wurde (Status: stopped, z.B. bei Allergie). Auch im Kontext mit statusReason, wo dieser Grund codiert angegeben werden kann (entfernt: cancelled, entered-in-error, draft, unknown)" 

* statusReason 0..0 
* statusReason ^short = "Grund für den aktuellen Status des Medikationsplaneintrags: (ex) https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html. TODO: Verwendung fachlich zu prüfen im Zusammenhang mit Status."

* intent 1..1 MS
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent ^short = "Ein Medikationsplaneintrag ist eine autorisierte ärztliche Anordnung und stellt eine verbindliche Einnahmeanweisung für den Patienten dar, auf dessen Basis eine geplante Abgabe erstellt werden kann. Fixer Wert: \"order\". (req) proposal | plan | order | original-order | reflex-order | filler-order | instance-order | option. https://hl7.org/fhir/R4/valueset-medicationrequest-intent.html"
* category 1..1 MS
* category = MedicationRequestCategoryCS#1  //"Medikationsplaneintrag" Display nicht fixieren -> Übersetzungen
* category ^short = "Kategorie zur Unterscheidung eines Medikationsplaneintrags von einer geplanten Abgabe (beide haben intent order)"

* priority 0..0
* priority ^short = "Priorität des Medikationsplaneintrag: (req) routine | urgent | asap | stat. Keine Verwendung in Medikationsplaneintrag."

* doNotPerform 0..0 // ..1 MS 
* doNotPerform ^short = "Gibt an, ob der Medikationsplaneintrag die Verordnung einer Medikation (und somit die Erstellung einer geplanten Abgabe) untersagt (z.B. bei Allergie). TODO: Fachlich zu prüfen, ob dieser Usecase existiert. Auch im Kontext mit status und statusReason zu betrachten. Evtl. erst in späterer Version"

* reported[x] 1..1 MS
* reportedReference only Reference(Patient or Practitioner or PractitionerRole)


* reportedBoolean ^short = "TRUE im Falle der Dokumentation von Fremdmedikation (ein anderer Arzt hat das Medikament ursprünglich verordnet), sonst FALSE. TODO: Klären ob hier der GDA eindeutig identifiziert sein muss (im GDA-I vorhanden) oder analog zu e-Impfpass Freitext sein kann. Juristisch Verantwortlichkeit für Korrektheit des Eintrags zu klären."
* reportedReference ^short = "Im Falle einer Fremdmedikation Angabe einer Referenz auf: (Patient | Practitioner | PractitionerRole | RelatedPerson | Organization)"

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
//* medication[x] only Reference(AtEmedMedication)  
//* medicationCodeableConcept 0..0

* medicationReference 1..1 MS 
* medicationReference only Reference(AtEmedMedication) 
* medicationReference.reference obeys contained-ref
* medicationReference ^short = "Das Arzneimittel wird immer in einer contained Medication Ressource dokumentiert, damit Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."

// --- Subject ---
* subject only Reference(HL7ATCorePatient) // ag auch eu-patient, evtl nur verschl. bpkh, daten zpi verfügbar, auch mit svnr möglich, speicherfristen
* subject 1..1 MS
* subject ^short = "Patient, für den der Medikationsplaneintrag ausgestellt werden soll, der über den Zentralen Patientenindex identifizierbar und Teilnehmer von ELGA e-Medikation ist."
* encounter 0..0
* encounter ^short = "Aufenthalt/Begegnung, während dessen der Medikationsplaneintrag erstellt wurde. Keine Verwendung im Medikationsplaneintrag."

* supportingInformation 0..0
* supportingInformation ^short = "Referenz auf zusätzliche Informationen (Ressource Any) (z. B. Größe und Gewicht des Patienten), die die Verschreibung des Medikaments unterstützen. Keine Verwendung im Medikationsplaneintrag."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Erstellung des Medikationsplaneintrags."

// -- Requester --- //ag: sptäter organz. weg , practitioner role: name+orga
* requester 1..1 MS  // zu hinterfragen, ob HL7ATCorePractitionerRole + HL7ATCoreOrganization nötig 
* requester only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Arzt oder Ärztin, die den Medikationsplaneintrag erstellt hat und für den Inhalt verantwortlich ist. Eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen."

* performer 0..0 
* performer ^short = "Der gewünschte Ausführende der medikamentösen Behandlung (z.B. der Ausführende der Medikamentengabe). Keine Verwendung im Planeintrag. TODO: evtl im Kontext Medikationsblatt zu prüfen."

* performerType 0..0
* performerType ^short = "Rollen: https://hl7.org/fhir/R4/valueset-performer-role.html. Keine Verwendung im Planeintrag. TODO: evtl im Kontext Medikationsblatt zu prüfen."

* recorder 0..0
* recorder ^short = "Die Person, die den Medikationsplaneintrag im Auftrag eines GDA eingegeben hat. TODO: Prüfen, ob eine juristische Verpflichtung zur Dokumentation der Schreibkraft besteht."

// Grund für die Medikation 
* reasonCode 0..0 
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz (TODO: Evtl. Invariante). Erst wenn codierte Angabe möglich."
* reasonReference 0..0 

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf ein Protokoll (Richtlinie, Guideline) verweist, das von diesem Medikationsplaneintrag ganz oder teilweise eingehalten wird. Derzeit keine Verwendung im Medikationsplaneintrag."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf ein extern gepflegtes Protokoll (Richtlinie, Guideline) verweist, das von diesem Medikationsplaneintrag ganz oder teilweise eingehalten wird. Derzeit keine Verwendung im Medikationsplaneintrag."

* basedOn 0..0 
//* basedOn only Reference(AtEmedMRPlaneintrag)
* basedOn ^short = "TODO: Verwendung im Medikationsplaneintrag zu prüfen. Vermutlich nicht möglich, da keine versionsspezifischen Referenzen verwendet werden."

* groupIdentifier 0..0
* groupIdentifier ^short = "TODO: Verwendung im Medikationsplaneintrag zu prüfen. Erst bei der geplanten Abgabe (Rezepterstellung) relevant. Evtl ein Verweis auf erstellte Rezepte? Würde Extension erfordern, da Kardinalität nur 0..1 zulässig"

* courseOfTherapyType 0..1 MS 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe (z.B. saisonal). Verwendung im Medikationsplaneintrag prüfen (dosageInstruction), evtl. durch Dosierungsinformationen abgedeck."

* insurance 0..0
* insurance ^short = "Keine Verwendung im Medikationsplaneintrag."

* note 0..* MS 
* note ^short = "Zusätzliche Informationen zum Medikationsplaneintrag. TODO: fachlich prüfen, an welchen Stellen überall Freitext erforderlich sein soll/muss. Auch im Kontext zu entered-in-error Informationen."

* dosageInstruction 1..* MS // bsp von linkedcare usw. analysieren
* dosageInstruction only AtEmedDosage
* dosageInstruction ^short  = "Angabe der Dosierinformationen strukturiert oder als Freitext"

* dispenseRequest 0..0 
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels im Medikationsplan. Keine Verwendung im Medikationsplaneintrag."

* substitution 0..1 MS //ag: evtl f. patient u pflegeheim als info
* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf oder nicht. Erläutert die Absicht des Arztes, der den Medikationsplaneintrag erstellt. Wenn nichts angegeben ist, kann eine Substitution vorgenommen werden. Die Dokumentation über eine tatsächlich erfolgte Substitution erfolgt in der Dispense-Resource. TODO: Usecase fachlich zu prüfen. Es kann für den Patienten selbst oder das Pflegeheim eine wichtige Information sein, mit welchem Medikament das verordnete Medikament im Bedarfsfall ersetzen werden kann."

* priorPrescription 0..1 MS
* priorPrescription ^short = "Im Falle einer Änderung wird auf den ersetzten Medikationsplaneintrag verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Klinisches Problem mit Maßnahme. Nur mittesl Referenz auf Ressouce DetectedIssue, Keine Verwendung im Medikationsplaneintrag."

* eventHistory 0..0
* eventHistory ^short = "Referenz auf Provenance-Ressourcen, die verschiedene relevante Versionen dieser Ressource dokumentieren. Keine Verwendung im Medikationsplaneintrag."


// Invariant: epa-datetime
// Description: "dateTime muss mindestens aus Tag, Monat und Jahr bestehen"
// * severity = #error
// * expression = "toString().matches('^([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\\\.[0-9]+)?(Z|(\\\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?$')"


Invariant: contained-ref
Description: "Medication must be contained (#...)"
Severity: #error
//Expression: "reference.startsWith('#')"
Expression: "$this.startsWith('#')"