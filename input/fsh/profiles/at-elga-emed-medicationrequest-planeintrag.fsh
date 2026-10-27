Profile: AtElgaEmedMedicationRequestPlaneintrag
Parent: AtElgaEmedMedicationRequestBase
Id: at-elga-emed-medicationrequest-planeintrag
Title: "At ELGA e-Medikation MedicationRequest Planeintrag"
Description: "Profil für einen Planeintrag." 

* extension MS
// Extensions
* extension contains $medicationRequest-effectiveDosePeriod-r5 named effectiveDosePeriod 1..1
* extension[effectiveDosePeriod] ^short = "Zeitraum, in dem das Arzneimittel eingenommen werden soll. Bei Dauermedikation kann optional ein Enddatum dokumentiert werden. Bei Aktumedikation ist verpflichtend ein Enddatum zu dokumentieren. Der Einnahmezeitraum muss mit den zeitlichen Einschränkungen der Dosage übereinstimmen." //TODO wording prüfen ob wirklich Einnahmezeitraum vgl. Dosierung
* extension[effectiveDosePeriod] MS
* extension[effectiveDosePeriod].valuePeriod MS
* extension[effectiveDosePeriod].valuePeriod.start MS
* extension[effectiveDosePeriod].valuePeriod.end MS
* extension[effectiveDosePeriod].url MS

* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige textuelle Zusammenfassung der Dosierungsanweisungen - wird von der Fachanwendung anhand der definierten Regeln befüllt.." // Todo Link zum Kapitel, sobald vorhanden. akl 21.10.2026
* extension[renderedDosageInstruction] MS
* extension[renderedDosageInstruction].valueMarkdown MS
* extension[renderedDosageInstruction].url MS
// IHE extension: Verwendung zu klären
// * extension contains $ihe-ext-medicationrequest-offlabeluse named offLabelUse 0..1 

* status 1..1 MS
* status from PlaneintragStatusVS (required)
* status ^short = "Status des Planeintrags. Mögliche Ausprägungen: [active | on-hold | stopped | entered-in-error]. Bedeutung: active: aktuell einzunehmende Medikation | on-hold: pausierte Medikation (aktuell nicht einzunehmen) | stopped: wird nicht weiter verordnet (unabhängig ob vorzeitig abgesetzt, abgeschlossen oder Behandlungszeitraum abgelaufen)   
| entered-in-error: fehlerhafter Planeintrag storniert"

//ASW 22.09.2026 TODO short einfügen
* statusReason 0..1 MS   //(ex) https://hl7.org/fhir/R4/valueset-medicationrequest-status-reason.html."
* statusReason ^short = "Begründung für den Status des Planeintrags."
* statusReason from AtElgaEmedValueSetPlaneintragStatusReasonVS
* statusReason.coding ^short = "Codierte Begründung für den Status. Wenn status stopped oder on-hold, verpflichtend anzugeben. Existiert kein passender Code, muss \"other\" ausgewählt werden und ein Freitext in dokumentiert werden."
* statusReason.coding MS
* statusReason.coding 1..1
* statusReason.coding.system 1..1 MS
* statusReason.coding.code 1..1 MS
* statusReason.coding.display MS
* statusReason.coding.version MS
* statusReason.text 0..1  MS
* statusReason.text ^short = "Begründung falls der Code 'other' angegeben wurde (Freitext)." 
//ASW 22.09.2026 TODO Invariante - text darf nur verwendet werden wenn der code other ist
//ASW 15.10.2026 TODO .text ersetzen durch note extension weil .text ja eigentlich nur die Textrepräsentation des codings ist und nicht eine Freitexterklärung
* obeys at-emed-planeintrag-status-reason-beim-absetzen-oder-pausieren

* intent 1..1 MS
* intent = #order 
* intent ^short = "Fixer Wert: \"order\"."

* category 1..1 MS
* category.coding 1..1 MS
* category.coding.system = Canonical(MedicationRequestCategoryCS)
* category.coding.system 1..1 MS
* category.coding.code 1..1 MS
* category.coding.code = #Planeintrag  // Display nicht fixieren
* category.coding.display MS
* category.coding.version MS
* category.text 0..0
//* category.text ^short = "Fachliche Begründung: TODO"
* category from MedicationRequestCategoryVS (required)
* category ^short = "Kategorie zur Unterscheidung eines Planeintrags von einer Geplanten Abgabe (beide haben intent order)."

* doNotPerform 0..0 
* doNotPerform ^short = "Fachliche Begründung: Arzneimittel, die (z.B. aufgrund einer Allergie) nicht eingenommen bzw. verordnet werden dürfen, werden nicht im Plan dokumentiert. Der Plan zeigt das Medizinische Soll an." 

* reported[x] MS
* reportedBoolean 1..1 MS
* reportedBoolean ^short = "Kennzeichnet, ob die Medikationsinformation berichtet wurde. Bedeutung: false: Verordnung durch den Planeintrag erstellenden GDA | true: Fremdmedikation oder Eigenmedikation des Patienten."

// --- Medication 
* medication[x] 1..1 MS  
* medication[x] only Reference(AtElgaEmedMedicationStandardMedikation or AtElgaEmedMedicationMagistraleZubereitung or AtElgaEmedMedicationWirkstoff)  
* medication[x] ^type.aggregation = #contained
* medication[x] ^short = "Das Arzneimittel wird in einer contained Medication Ressource oder als Conditional Reference dokumentiert."
* medicationReference MS
* medicationReference.reference 1..1 MS
// ASW TODO 14.10. medication hat keinen identifier - conditional reference im tx bundle - wie einschränken für unterschied zw. schreiben und lesen?
//* medicationReference.identifier MS
//* medicationReference.identifier.system MS
//* medicationReference.identifier.value MS

// --- Subject ---
* subject only Reference(AtElgaEmedPatient) 
* subject 1..1 MS
* subject ^short = "ELGA-Teilnehmer, für den der Medikationsplan dokumentiert wird."
* subject.reference MS
* subject.identifier MS
* subject.identifier.system MS
* subject.identifier.value MS
* subject.identifier.use 0..0
//* subject.identifier.use ^short = "Fachliche Begründung: TODO"

// -- AuthoredOn ---
* authoredOn 1..1 MS
* authoredOn ^short = "Datum der Erstellung/Änderung des Planeintrags."

// -- Requester --- 
* requester 1..1 MS  
* requester only Reference(AtElgaEmedPractitioner or AtElgaEmedPractitionerRole) //Organization hier nicht möglich da in der Liste keine Organization erlaubt ist
* requester ^short = "GDA, welcher den Planeintrag zuletzt bearbeitet hat und für den Inhalt verantwortlich ist."
* requester.reference MS
* requester.identifier MS
* requester.identifier.system MS
* requester.identifier.value MS
* requester.identifier.use 0..0
//* requester.identifier.use ^short = "Fachliche Begründung: TODO"
//* recorder 0..0
//* recorder ^short = "Die Person, die den Planeintrag im Auftrag eines GDA erfasst hat." // TODO: Prüfen, ob eine juristische Verpflichtung zur Dokumentation der Schreibkraft besteht."


* groupIdentifier 0..0
* groupIdentifier ^short = "Fachliche Begründung: Eine Rezept-Klammer wird erst bei der Erstellung Geplanter Abgaben benötigt und nicht im Planeintrag dokumentiert."

* courseOfTherapyType 1..1 MS 
* courseOfTherapyType ^short = "Art der Medikation. Mögliche Ausprägungen: [continuous | acute]" 
* courseOfTherapyType from AtElgaEmedValueSetCourseOfTherapyType
* courseOfTherapyType.coding 1..1 MS
* courseOfTherapyType.coding.system 1..1 MS
* courseOfTherapyType.coding.code 1..1 MS
* courseOfTherapyType.coding.version MS
* courseOfTherapyType.coding.display MS
* courseOfTherapyType.text 0..0
//* courseOfTherapyType.text ^short = "Fachliche Begründung: TODO"
//* obeys e-med-continuous-medication-effectiveDosePeriod
* obeys e-med-acute-medication-effectiveDosePeriod

* note 0..1 MS 
* note ^short = "Zusätzliche Informationen zum Planeintrag, die nicht die Dosierung betreffen." 
* note.text MS

* dispenseRequest 0..0 
* dispenseRequest ^short = "Fachliche Begründung: Abgabedetails werden in der Geplanten Abgabe und nicht im Planeintrag dokumentiert."

//* substitution 0..0
//* substitution ^short = "Gibt an, ob das Arzneimittel substituiert werden darf (Absicht des Arztes, der den Planeintrag erstellt). Derzeit keine Verwendung im Planeintrag." 
// Es kann für den Patienten selbst oder das Pflegeheim eine wichtige Information sein, mit welchem Medikament das verordnete Medikament im Bedarfsfall ersetzen werden kann. Derzeit keine Verwendung, Backlog bezügl. Pflege.


// Invariant: epa-datetime
// Description: "dateTime muss mindestens aus Tag, Monat und Jahr bestehen"
// * severity = #error
// * expression = "toString().matches('^([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\\\.[0-9]+)?(Z|(\\\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?$')"



// Invariant: e-med-continuous-medication-effectiveDosePeriod
// Description: "Eine Dauermedikation (courseOfTherapyType = #continuous) darf kein Enddatum besitzen."
// * severity = #error
// * expression = "courseOfTherapyType.where(coding.code='continuous' and coding.system = 'http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy').exists() implies extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod').value.ofType(Period).end.exists().not()"

Invariant: e-med-acute-medication-effectiveDosePeriod
Description: "Eine Akutmedikation (courseOfTherapyType = #acute) muss ein Enddatum besitzen."
* severity = #error
* expression = "courseOfTherapyType.where(coding.code='acute' and coding.system = 'http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy').exists() implies extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod').value.ofType(Period).end.exists()"

// Todo: ändern: stopped und on-hold brauchen statusReason, entered-in-error nicht, akl 21.10.2026
Invariant: at-emed-planeintrag-status-reason-beim-absetzen-oder-pausieren
Description: "Bei Status 'stopped' oder 'on-hold' muss ein statusReason angegeben werden."
* severity = #error
* expression = "(status = 'stopped' or status = 'on-hold') implies statusReason.coding.code.exists()"

//ASW 22.09.2026 TODO path bei invarianten mit angeben