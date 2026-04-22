Profile: AtEmedMDDurchgefuehrteAbgabe
Parent: MedicationDispense
Id: at-emed-md-durchgefuehrte-abgabe
Title: "ELGA e-Med Durchgeführte Abgabe"
Description: "Dokumentiert eine durchgeführte Abgabe eines Arzneimittels (\"MedicationDispense\"-Ressource). 
In der durchgeführten Abgabe können Abweichungen hinsichtlich der Dosierung des Medikaments dokumentiert werden.
Sofern eine zugehörige geplante Abgabe vorliegt, muss diese referenziert werden. Einer mögliche Substitution des Medikaments ist implizit, durch die Referenz auf die zugehörige geplante Abgabe, ersichtlich."
* . ^short = "Durchgeführte Abgabe eines Arzneimittels mit oder ohne Bezug zur geplanten Abgabe. Verwendet R5 Backport Extensions."

// TODO Check CDA

// Extensions   ***************** TODO
* extension contains $medicationrequest-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
* extension[renderedDosageInstruction] ^short = "Vollständige Darstellung der Dosierungsanweisungen"
// ENDE Extensions  ******************

* identifier 0..0 
* identifier ^short = "Durchgeführte-Abgabe-ID." // TODO: Verwendung zu prüfen, ws: vermutlich keine notwendigkeit

* partOf 0..0 
* partOf ^short = "Auslösendes Ereignis (Referenz auf Procedure-Ressource). Keine Verwendung in der durchgeführten Abgabe."

* status 1..1 MS
* status ^short = "Status der durchgeführten Abgabe. Mögliche Ausprägungen: [completed | entered-in-error | stopped] Bedeutung: completed: Die durchgeführte Abgabe ist abgeschlossen. | entered-in-error: Die durchgeführte Abgabe wird aufgrund falscher Eingabe storniert. | stopped: Die Abgabe wird nicht durchgeführt (Medikament wird abgesetzt)."
// TODO: zu prüfen: 
// * ob es einen Status in-progress / preparation geben soll, z.B. wenn Bestellvorgang gestartet wurde und der typ First Fill - Part Fill ist.
// * Technische Prüfungen bezüglich Abhängigkeiten von status, typ, Rezeptart? (z.B. in-progress bei Bestellung o.ä.), evtl Operation 

* statusReason[x] ^short = "Grund für den aktuellen Status, z.B. warum keine Abgabe erfolgte (zB. Produkt nicht verfügbar). Code oder Referenz (DetectedIssue)"
* statusReasonCodeableConcept 0..1 MS   //TODO: Verwendung zu prüfen
* statusReasonCodeableConcept ^short = "Grund für den aktuellen Status als Code. (ex) https://hl7.org/fhir/R4/valueset-medicationdispense-status-reason.html"
* statusReasonReference 0..0
* statusReasonReference ^short = "Referenz auf DetectedIssue-Ressource. Keine Verwendung in der durchgeführten Abgabe."

* category 0..0 
* category ^short = "Angabe, wo das abgegebene Medikament voraussichtlich eingenommen oder verabreicht wird (z.B. stationär oder ambulant). Keine Verwendung in der durchgeführten Abgabe."


// --- Medication immer als Medication-Resource (mit oder ohne PZN, damit Handelsname angegeben werden kann und historisch verfügbar bleibt)
* medication[x] 1..1 MS  
* medication[x] only Reference(AtEmedMedication)  
* medication[x] ^type.aggregation = #contained

* medication[x] ^short = "Abgegebenes Medikament. Das Medikament wird immer in einer contained Medication Ressource dokumentiert, damit 
Arzneimittel mit und ohne PZN einheitlich dokumentiert werden können."

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Patient, für den die durchgeführte Abgabe ausgestellt wird (über Zentralen Patientenindex identifiziert und Teilnehmer von ELGA e-Medikation)."

* context 0..0
* context ^short = "Referenz auf Encounter oder EpisodeOfCare. Keine Verwendung in der durchgeführten Abgabe."

* supportingInformation 0..0 
* supportingInformation ^short = "Referenz (Any) auf zusätzliche Informationen, die die Abgabe des Medikaments unterstützen. Keine Verwendung in der durchgeführten Abgabe."

* performer 1..1 MS
* performer ^short = "Durchführende Person" 
* performer.function 0..0 
* performer.function ^short = "Rolle der Person, die die Abgabe durchgeführt hat. Keine Verwendung in der durchgeführten Abgabe."
* performer.actor 1..1 MS
* performer.actor only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* performer.actor ^short = "Refrenz auf Practitioner, PractitionerRole, Organization, 
der/die die durchgeführte Abgabe erstellt hat und für den Inhalt verantwortlich ist (identifiziert über den GDA-Index und berechtigt 
auf die ELGA e-Medikation des Patienten zuzugreifen)."

* location 0..0 
* location ^short = "Ort der Abgabe (Referenz auf Location Ressource). Keine Verwendung in durchgeführter Abgabe."

* authorizingPrescription 0..1 MS    // TODO: Technisch prüfen?
* authorizingPrescription ^short = "Verpflichtende Referenz auf zugehörige geplante Abgabe (MedicationRequest), sofern diese existiert."
// zu prüfen (gemäß CDA): 'Ohne Verordnungsbezug kann nur die Abgabe jener OTC-Präparate in der e-Medikation 
// gespeichert werden, die auch wechselwirkungsrelevant sind.'"

* type 1..1 MS  //TODO: Valueset
* type ^short = "Art der Abgabe (z.B. für Teilabgaben). Mögliche Ausprägungen: [FFC | FFP | RFP | RFC | EM]. Bedeutung: FFC: First Fill - Complete | FFP: First Fill - Part Fill | RFP: Refill - Part Fill | RFC: Refill - Complete | EM: Emergency Supply."
//z.B. FFC (First-Fill Complete für vollständig erfüllte Bestellungen), FFP (First-Fill Part Fill für teilweise erfüllte Bestellungen), 
 //ffc, ffp, Refill - Part Fill, refill complete: evtl. selbst definieren
// für Leerabgabe: complete-Ausprägung; Emergency supply offen (OTC), complete

// EM	Emergency Supply: kein geplante Abgabe (Rezept) für ein verschreibungspflichtes Rezept vorhanden
// SO	Script Owing: kein geplante Abgabe (Rezept) für ein verschreibungspflichtes Rezept vorhanden, geplante Verordnung wird im nachhinen vom GDA erstellt (Rezept nachbringen)
// FFPS First fill, part fill, partial strength: Eine Erstabgabe, bei der die gelieferte Menge weniger als eine vollständige Wiederholung der bestellten Menge beträgt. (Beispiel: Bei einer Bestellung von 90 Tabletten und 3 Nachfüllungen könnte eine Teilabgabe nur 30 Tabletten umfassen.) Dies gilt auch, wenn die gelieferte Stärke geringer ist als die bestellte Stärke (z. B. 10 mg bei einer Bestellung von 50 mg, wobei bei einer späteren Abgabe 40-mg-Tabletten ausgegeben werden).
// FFCS first fill complete, partial strength: A first fill where the quantity supplied is equal to one full repetition of the ordered amount. (e.g. If the order was 90 tablets, 3 refills, a complete fill would be for the full 90 tablets) and also where the strength supplied is less than the ordered strength (e.g. 10mg for an order of 50mg where a subsequent fill will dispense 40mg tablets).

// Gemäß CDA: Der Prozess des „Besorgers“ (wenn ein Arzneimittel nicht lagernd ist und bestellt werden muss) wird in der e-Medikation abgebildet. 
// Dabei wird das Rezept von der Apotheke eingelöst, und die Abgabe wird als Teilabgabe gekennzeichnet 
// (siehe Markierung FFP „First Fill, Part Fill“ oder RFP „Refill - Part Fill“). 
// Die Verordnung wird nicht in den Status EINGELÖST versetzt und es können solange weitere Abgaben dispensiert werden, 
// bis eine Abgabe mit der Markierung RFC „Refill - Complete“ gespeichert wird. Die Kennzeichnung zeigt, 
// dass das Arzneimittel dem Patienten noch nicht ausgehändigt wurde. Die Kennzeichnung zeigt auch, ob alle Packungen einer Verordnung bzw. 
// teilweise Packungen einer Verordnung bestellt werden. Solange eine Abgabe mit der Kennzeichnung „Besorger“ vorhanden ist, muss die Abgabe mit der eMED-ID abrufbar sein.

* quantity 1..1 MS 
* quantity ^short = "Abgegebene Packungsanzahl."

* daysSupply 0..0 //1 MS
* daysSupply ^short = "Tage, für die die abgegebene Menge ausreicht"

* whenPrepared 0..0 //1 MS
* whenPrepared ^short = "Zeitpunkt, zu dem das Produkt verpackt und geprüft wurde."

* whenHandedOver 1..1 MS  
* whenHandedOver ^short = "Der Zeitpunkt, zu dem das abgegebene Produkt dem Patienten oder seinem Vertreter zur Verfügung gestellt wurde."

* destination 0..0
* destination ^short = "Ort an den das Medikament geschickt wurde (Referenz auf Location Ressource). Keine Verwendung in durchgeführter Abgabe."

* receiver 0..0
* receiver ^short = "Person, die das Medikament abgeholt hat. Referenz auf Patient oder Practitioner. Keine Verwendung in durchgeführter Abgabe."

* note 0..* MS // analog zur geplanten abgabe
* note ^short = "Zusätzliche Informationen zur Abgabe, die nicht anders dokumentiert werden kann."

* dosageInstruction 0..* MS
* dosageInstruction ^short = "Gibt an, wie das Medikament vom Patienten einzunehmen ist. 
Der Apotheker überprüft die Medikamentenverordnung vor der Abgabe und passt die Dosierungsanweisung gegebenenfalls auf Grundlage des tatsächlich abgegebenen Produkts an."
//TODO: Dosiervarianten.

* substitution 0..0 // MS  ws: nur implizit
* substitution ^short = "Gibt an, ob im Rahmen der Abgabe eine Substitution vorgenommen wurde oder nicht."
// * substitution.wasSubstituted 1..1
// * substitution.wasSubstituted ^short = "TRUE, wenn der Apotheker ein anderes Medikament oder Produkt als das verschriebene abgegeben hat."

// * substitution.type 0..1 MS
// * substitution.type ^short = "Typ der Substitution: z.B. E equivalent, http://terminology.hl7.org/ValueSet/v3-ActSubstanceAdminSubstitutionCode" 

// * substitution.reason 0..* MS
// * substitution.reason ^short = "Grund für die Substitution: z.B. OS out of stock, https://hl7.org/fhir/R4/v3/SubstanceAdminSubstitutionReason/vs.html"

// * substitution.responsibleParty 0..1 MS 
// * substitution.responsibleParty ^short = "Für die Subistution Verantwortlicher."
// * substitution.responsibleParty only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole)

* detectedIssue 0..0
* detectedIssue ^short = "Referenenz auf DetectedIssue Ressource. Keine Verwendung in durchgeführter Abgabe."

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, die verschiedene relevante Versionen 
dieser Ressource dokumentieren." // TODO: Verwendung prüfen.