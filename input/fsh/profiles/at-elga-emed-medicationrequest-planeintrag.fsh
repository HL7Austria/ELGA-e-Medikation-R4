Profile: AtElgaEmedMedicationRequestPlaneintrag
Parent: AtElgaEmedMedicationRequestBase
Id: at-elga-emed-medicationrequest-planeintrag
Title: "At ELGA e-Medikation MedicationRequest Planeintrag"
Description: "Ein Planeintrag im Medikationsplan wird durch eine \"MedicationRequest\"-Ressource abgebildet.
Sie enthält genau ein Arzneimittel mit dessen Dosierung, wobei das Arzneimittel verpflichtend mit einer contained Medication-Ressource dokumentiert wird.
Der Planeintrag kann in weiterer Folge als Grundlage für die Erstellung einer \"Geplanten Abgabe\" dienen. Es werden R5-Backport-Extensions verwendet."
// TODO: Statt MS Obligations für alle Elemente, daher später kein 0..0 nötig

* . ^short = "Planeintrag"

// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 1..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem das Arzneimittel eingenommen werden soll." 
* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"

// IHE extension statt Backport Extension: Verwendung zu klären
// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 
// * extension[offLabelUse] ^short = "Weist darauf hin, dass der verschreibende Arzt das Medikament wissentlich für eine Indikation, Altersgruppe, Dosierung oder Verabreichungsform verschrieben hat, die nicht von den Aufsichtsbehörden zugelassen ist und in der Verschreibungsinformation für das Produkt nicht erwähnt wird."

* identifier 0..1 //1..1  MS  TODO: entfernt von AKL 7.9.2026
* identifier ^short = "Planeintrag-ID." // TODO: Verwendung einer logischen Planeintrag-ID prüfen. Details zur Herstellung von Bezügen von geänderten Planeinträgen, siehe Definition."
// * identifier ^definition = """
// Planeintrag-ID zur Herstellung eines Bezugs von geänderten Planeinträgen.
// Vorteil: 
// - Auch wenn sich die PZN ändert, aber logisch der gleiche Eintrag betroffen ist (z.B. Austausch eines Arzneimittels durch ein anderes mit weniger Wechselwirkung), kann ein Bezug hergestellt werden.
// - Wenn zur Vorversion des Eintrags bereits eine Geplante Abgabe erstellt wurde, kann ein Bezug zum ursprünglichen Eintrag hergestellt werden.
// Nachteil: 
// - Falls Planeinträge mit komplett neuer Arznei überschrieben werden, entsteht dadurch ein verwirrender Bezug. 
// - Die Verantwortung, dass nur Einträge geändert werden, die keine komplett neue Medikation beinhalten, liegt beim Ersteller des Eintrags.
// """

* status 1..1 MS
* status from PlaneintragStatusVS (required)
* status ^short = "Status des Planeintrags. Mögliche Ausprägungen: [active | on-hold | completed | stopped | entered-in-error]. Bedeutung: active: Planeintrag einer aktiven Medikation, die eingenommen werden soll | on-hold: Planeintrag ist pausiert, die Therapie ist unterbrochen (Wiederaufnahme vorgesehen) | completed: Therapie gemäß Planeintrag wie geplant durchgeführt und abgeschlossen | stopped: Therapie gemäß Planeintrag vorzeitig gestoppt und abgeschlossen | entered-in-error: Fehlerhafter Planeintrag storniert und abgeschlossen."

* statusReason MS
* statusReason.coding 0..0    //(ex) https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html."
* statusReason.coding ^short = "Keine codierte Begründung für den Status des Planeintrags." 
* statusReason.text 0..1  MS
* statusReason.text ^short = "Begründung für den Status des Planeintrags (Freitext), z.B. warum ein Medikament abgesetzt wurde." 
// TODO: müssen bei bestimmten Status (z.B. stopped) zwingend Begründungen angegeben werden? Evtl. Invariante erstellen.

* intent 1..1 MS
* intent = https://hl7.org/fhir/R4/valueset-medicationrequest-intent#order
* intent ^short = "Ein Planeintrag ist eine autorisierte ärztliche Anordnung und stellt eine verbindliche Einnahmeanweisung für den Patienten dar, auf dessen Basis eine Geplante Abgabe erstellt werden kann. Fixer Wert: \"order\". (req) proposal | plan | order | original-order | reflex-order | filler-order | instance-order | option. https://hl7.org/fhir/R4/valueset-medicationrequest-intent.html"

* category 1..1 MS
* category = MedicationRequestCategoryCS#1 "Planeintrag"  // Display nicht fixieren -> Übersetzungen
* category ^short = "Kategorie zur Unterscheidung eines Planeintrags von einer geplanten Abgabe (beide haben intent order)"

* priority 0..0
* priority ^short = " Medikationsplaneinträge können nicht mit einer Priorität versehen werden: (req) routine | urgent | asap | stat."

* doNotPerform 0..0 
* doNotPerform ^short = "Arzneimittel, die (z.B. aufgrund einer Allergie) nicht eingenommen bzw. verordnet werden dürfen, werden nicht dokumentiert." // TODO: Fachlich zu prüfen. Auch im Kontext mit status und statusReason zu betrachten. Evtl. erst in späterer Version"

* reportedReference 0..0  
* reportedReference ^short = "Keine Verwendung im Medikationsplan."

* reportedBoolean 1..1 MS
* reportedBoolean ^short = "Quelle der Information. Bedeutung: false: Verordnung durch den Planeintrag erstellenden GDA | true: Fremdmedikation oder Eigenmedikation des Patienten."

// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationMedikation)  
* medication[x] ^type.aggregation = #contained

* medication[x] ^short = "Das Arzneimittel wird immer in einer contained Medication Ressource dokumentiert, damit Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."

// --- Subject ---
* subject only Reference(AtElgaCorePatient) // ag auch eu-patient, evtl nur verschl. bpkh, daten zpi verfügbar, auch mit svnr möglich, speicherfristen
* subject 1..1 MS
* subject ^short = "Patient, für den der Planeintrag ausgestellt werden soll, der über den Zentralen Patientenindex identifizierbar und Teilnehmer von ELGA e-Medikation ist."

* encounter 0..0
* encounter ^short = "Es wird kein Behandlungskontext dokumentiert."

* supportingInformation 0..0
* supportingInformation ^short = "Keine Referenzen auf zusätzliche Patienteninformationen (Ressource Any) im Planeintrag."

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Erstellung des Planeintrags."

// -- Requester --- //ag: sptäter organz. weg , practitioner role: name+orga
* requester 1..1 MS  // zu hinterfragen, ob AtElgaCorePractitionerRole + HL7ATCoreOrganization nötig 
* requester only Reference(AtElgaCorePractitioner or AtElgaCorePractitionerRole or HL7ATCoreOrganization)
* requester ^short = "Arzt oder Ärztin, die den Planeintrag erstellt hat und für den Inhalt verantwortlich ist. Eindeutig identifiziert über den GDA-Index und berechtigt auf die ELGA e-Medikation des Patienten zuzugreifen."

* performer 0..0 
* performer ^short = "Der gewünschte Ausführende der medikamentösen Behandlung (z.B. der Ausführende der Medikamentengabe). Keine Verwendung im Planeintrag." //TODO: evtl im Kontext Medikationsblatt zu prüfen.

* performerType 0..0
* performerType ^short = "Rollen: https://hl7.org/fhir/R4/valueset-performer-role.html. Keine Verwendung im Planeintrag." // TODO: evtl im Kontext Medikationsblatt zu prüfen.

* recorder 0..0
* recorder ^short = "Die Person, die den Planeintrag im Auftrag eines GDA eingegeben hat." // TODO: Prüfen, ob eine juristische Verpflichtung zur Dokumentation der Schreibkraft besteht."

// Grund für die Medikation 
* reasonCode 0..0 
//* reasonCode from $cs-sct (required)
* reasonCode ^short = "Grund für die Verordnung des Arzneimittels. Entweder Code oder Referenz. Verwendung erst, wenn codierte Angabe möglich." //TODO: Evtl. Invariante
* reasonReference 0..0 

* instantiatesCanonical 0..0 
* instantiatesCanonical ^short = "URL, die auf eine Richtlinie/Guideline verweist, die von diesem Planeintrag ganz oder teilweise eingehalten wird. Derzeit keine Verwendung im Planeintrag."

* instantiatesUri 0..0 
* instantiatesUri ^short = "URL, die auf eine extern gepflegte Richtlinie/Guideline verweist, die von diesem Planeintrag ganz oder teilweise eingehalten wird. Derzeit keine Verwendung im Planeintrag."

* basedOn 0..0 
//* basedOn only Reference(AtElgaEmedMedicationRequestPlaneintrag)
* basedOn ^short = "Keine Verwendung im Planeintrag." // TODO: Verwendung vermutlich nicht möglich, da keine versionsspezifischen Referenzen verwendet werden."

* groupIdentifier 0..0
* groupIdentifier ^short = "Erst bei der geplanten Abgabe (Rezepterstellung) relevant." // TODO: Evtl ein Verweis auf erstellte Rezepte? Würde Extension erfordern, da Kardinalität nur 0..1 zulässig"

* courseOfTherapyType 1..1 MS 
* courseOfTherapyType ^short = "Gesamtmuster der Medikamentengabe. Mögliche Ausprägungen: [continuous | acute ]" //TODO: seasonal evtl. durch Dosierungsinformationen abgedeckt
// Invariante, die prüft: wenn continuous, dann kein Enddatum für Behandlungszeitraum.
// TODO: seasonal entfernen
* obeys e-med-continuous-medication-effectiveDosePeriod
* obeys e-med-acute-medication-effectiveDosePeriod

* insurance 0..0
* insurance ^short = "Keine Verwendung im Planeintrag."

* note 0..* MS 
* note ^short = "Zusätzliche Informationen zum Planeintrag." // TODO: fachlich prüfen, an welchen Stellen überall Freitext erforderlich sein soll/muss. Auch im Kontext zu entered-in-error Informationen."

// TODO: Invariante für repeating sequences * dosageInstruction.extension contains AtElgaEmedExtensionDosageRepeat??? named repeatCycle 0..1
//TODO Invariante sodass die Extension nur erlaubt ist, wenn es mehrere Dosages gibt
* dosageInstruction ^slicing.discriminator.type = #value
* dosageInstruction ^slicing.discriminator.path = "extension.value"
* dosageInstruction ^slicing.rules = #closed
* dosageInstruction ^slicing.ordered = false
* dosageInstruction 1..* MS
* dosageInstruction contains   
    otherDosage 0.. MS and
    timedDosage 0.. MS and
    frequencyDosage 0.. MS and
    freitextDosage 0.. MS and
    standardDosage 0.. MS
// DOSAGE
* dosageInstruction[otherDosage] only AtElgaEmedDosageOtherAdministration
* dosageInstruction[timedDosage] only AtElgaEmedDosageTimedAdministration
* dosageInstruction[frequencyDosage] only AtElgaEmedDosageFrequencyAdministration
* dosageInstruction[freitextDosage] only AtElgaEmedDosageFreeTextAdministration
* dosageInstruction[standardDosage] only AtElgaEmedDosageStandardAdministration

//TODO Dosage und AtElgaEmedDosageDosierung entfernen sobald Dosierungen fertig sind
* dosageInstruction ^short  = "Angabe der Dosierinformationen strukturiert oder als Freitext." //TODO: Inhalte AtElgaEmedDosageDosierung fachlich prüfen.

* dispenseRequest 0..0 
* dispenseRequest ^short = "Details zur geplanten Abgabe des Arzneimittels im Medikationsplan. Keine Verwendung im Planeintrag."

* substitution 0..0 // 
* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf (Absicht des Arztes, der den Planeintrag erstellt). Derzeit keine Verwendung im Planeintrag." 
// Es kann für den Patienten selbst oder das Pflegeheim eine wichtige Information sein, mit welchem Medikament das verordnete Medikament im Bedarfsfall ersetzen werden kann. Derzeit keine Verwendung, Backlog bezügl. Pflege.

* priorPrescription 0..1 MS
* priorPrescription ^short = "Im Falle einer Änderung wird auf den ersetzten Planeintrag verwiesen."

* detectedIssue 0..0
* detectedIssue ^short = "Klinisches Problem mit Maßnahme (Referenz auf Ressouce DetectedIssue). Keine Verwendung im Planeintrag."

* eventHistory 0..0
* eventHistory ^short = "Referenz auf Provenance-Ressourcen, die verschiedene relevante Versionen dieser Ressource dokumentieren. Keine Verwendung im Planeintrag."


// Invariant: epa-datetime
// Description: "dateTime muss mindestens aus Tag, Monat und Jahr bestehen"
// * severity = #error
// * expression = "toString().matches('^([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\\\.[0-9]+)?(Z|(\\\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?$')"


Invariant: e-med-continuous-medication-effectiveDosePeriod
Description: "Eine Dauermedikation (courseOfTherapyType = #continuous) darf kein Enddatum besitzen."
* severity = #error
* expression = "courseOfTherapyType.where(coding.code='continuous' and coding.system = 'http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy').exists() implies extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod').value.ofType(Period).end.exists().not()"


Invariant: e-med-acute-medication-effectiveDosePeriod
Description: "Eine Akutmedikation (courseOfTherapyType = #acute) muss ein Enddatum besitzen."
* severity = #error
* expression = "courseOfTherapyType.where(coding.code='acute' and coding.system = 'http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy').exists() implies extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod').value.ofType(Period).end.exists()"