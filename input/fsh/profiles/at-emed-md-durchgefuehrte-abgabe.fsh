Profile: AtEmedMDDurchgefuehrteAbgabe
Parent: MedicationDispense
Id: at-emed-md-durchgefuehrte-abgabe
Title: "ELGA e-Med Durchgeführte Abgabe"
Description: "Dokumentiert eine durchgeführte Abgabe eines Arzneimittels (\"MedicationDispense\"-Ressource). 
Sofern eine zugehörige geplante Abgabe vorliegt, können Abweichungen hinsichtlich der Dosierung oder einer möglichen
Substitution des Medikaments in der durchgeführten Abgabe dokumentiert werden."
* . ^short = "Durchgeführte Abgabe eines Arzneimittels mit oder ohne Bezug zum Medikationsplan. Verwendet R5 Backport Extensions."


// Extensions TODO

// MedicationDispense TODO + Check CDA

* identifier 0..* MS  // 1..1 MS ?
* identifier ^short = "Externer Identifier."

* partOf 0..0
* partOf ^short = "Auslösendes Ereignis. Verwendung in der durchgeführten Abgabe prüfen."

* status 1..1 MS
* status ^short = "Status des durchgeführten Abgabe: preparation | in-progress | cancelled | on-hold | completed | entered-in-error | stopped | declined | unknown; http://hl7.org/fhir/ValueSet/medicationdispense-status|4.0.1
-> VS einschränken"

* statusReason[x] ^short = "Warum keine Abgabe erfolgte (zB. Allergie, Produkt nicht verfügbar). Code oder Referenz (DetectedIssue)"
* statusReasonCodeableConcept 0..1 MS
* statusReasonCodeableConcept ^short = "Bsp: https://hl7.org/fhir/R4/valueset-medicationdispense-status-reason.html"

* statusReasonReference 0..0
* statusReasonReference ^short = "Verwendung in der durchgeführten Abgabe prüfen."

* category 0..0 MS 
* category ^short = "Angabe, wo das abgegebene Medikament voraussichtlich eingenommen oder verabreicht wird (z.B. stationär oder ambulant), https://hl7.org/fhir/R4/valueset-medicationdispense-category.html. Verwendung zu prüfen."

* medication[x] 1..1 MS
* medication[x] only CodeableConcept or Reference(AtEmedMedication)  
* medication[x] ^short = "Abgegebenes Medikament. Code oder Referenz"

// CodeableConcept-Variante (ASP-Liste, PZN)
* medicationCodeableConcept 0..1 MS  
* medicationCodeableConcept from $cs-asp-liste (required)  // gem. CDA code: Pharmazentralnummer (OID 1.2.40.0.34.4.16), Zulassungsnummer (OID 1.2.40.0.34.4.17), Package Reference Number der AGES (OID 1.2.40.0.34.4.26) (geplant als Ablöse zur PZN), (in Vorbereitung) PCID der EMA (OID 1.2.40.0.34.4.27)
* medicationCodeableConcept ^short = "Angabe mittels Pharmazentralnummer (PZN) aus der ASP-Liste."
* medicationCodeableConcept.coding 1.. // zusätzlich ausländische Codes o.ä. zulassen

// --- Subject ---
* subject only Reference(HL7ATCorePatient) 
* subject 1..1 MS
* subject ^short = "Österreichischer Patient für den die durchgeführte Abgabe ausgestellt wird."

* context 0..0
* context ^short = "Referenz auf Encounter oder EpisodeOfCare. Verwendung in der durchgeführten Abgabe prüfen."

* supportingInformation 0..* 
* supportingInformation ^short = "Referenz auf zusätzliche Informationen, die die Abgabe des Medikaments unterstützen. 
Verwendung in der durchgeführten Abgabe prüfen."

* performer 1..1 MS
* performer ^short = "Durchführende Person" 
* performer.function 0..1 MS
* performer.function ^short = "Rolle: https://hl7.org/fhir/R4/valueset-medicationdispense-performer-function.html; Verwendung in der durchgeführten Abgabe prüfen."
* performer.actor 1..1 MS
* performer.actor only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole or HL7ATCoreOrganization)
* performer.actor ^short = "RefrenzReference auf Practitioner, PractitionerRole, Organization; entfernen: Patient, Device, RelatedPerson"

* location 0..0 
* location ^short = "Ort der Abgabe (Referenz auf Location Ressource). Verwendung prüfen."

* authorizingPrescription 0..1 MS
* authorizingPrescription ^short = "Referenz auf zugehörige geplante Abgabe."

* type 0..1 MS
* type ^short = "Mögliche Werte z.B. FFC (First-Fill Complete für vollständig erfüllte Bestellungen), FFP (First-Fill Part Fill für teilweise erfüllte Bestellungen), 
Bsp: http://terminology.hl7.org/ValueSet/v3-ActPharmacySupplyType"

* quantity 0..1 MS
* quantity ^short = "Abgegebene Menge und Einheit"

* daysSupply 0..1 MS
* daysSupply ^short = "Medikamentenmenge, ausgedrückt als zeitliche Menge"

* whenPrepared 0..1 MS
* whenPrepared ^short = "Verpackungs- und Prüfdatum."

* whenHandedOver 0..1 MS
* whenHandedOver ^short = "Der Zeitpunkt, zu dem das abgegebene Produkt dem Patienten oder seinem Vertreter zur Verfügung gestellt wurde."

* destination 0..0
* destination ^short = "Ort an den das Medikament geschickt wurde (Referenz auf Location Ressource). Verwendung prüfen."

* receiver 0..0
* receiver ^short = "Person, die das Medikament abgeholt hat. Verwendung prüfen."
* receiver only Reference(HL7ATCorePatient or HL7ATCorePractitioner)

* note 0..* MS
* note ^short = "Zusätzliche Informationen zur Abgabe, die nicht anders dokumentiert werden kann."

* dosageInstruction 0..* MS 
* dosageInstruction ^short = "Gibt an, wie das Medikament vom Patienten einzunehmen ist. 
Wenn sich die Dosis oder Dosierungsrate über den gesamten Verabreichungszeitraum ändern soll 
(z.B. bei verschreibungspflichtigen Medikamenten mit schrittweiser Dosierungsreduktion), 
müssen mehrere Dosierungsanweisungen bereitgestellt werden, um die verschiedenen Dosen/Dosierungsraten zu vermitteln. 
Der Apotheker überprüft die Medikamentenbestellung vor der Abgabe und aktualisiert die Dosierungsanweisung auf der Grundlage 
des tatsächlich abgegebenen Produkts."

* substitution 0..1 MS
* substitution ^short = "Gibt an, ob im Rahmen der Abgabe eine Substitution vorgenommen wurde oder nicht. Wenn nichts angegeben ist, wurde keine Substitution vorgenommen."
* substitution.wasSubstituted 1..1
* substitution.wasSubstituted ^short = "TRUE, wenn der Apotheker ein anderes Medikament oder Produkt als das verschriebene abgegeben hat."

* substitution.type 0..1 MS
* substitution.type ^short = "Typ der Substitution: z.B. E equivalent, http://terminology.hl7.org/ValueSet/v3-ActSubstanceAdminSubstitutionCode" 

* substitution.reason 0..* MS
* substitution.reason ^short = "Grund für die Substitution: z.B. OS out of stock, https://hl7.org/fhir/R4/v3/SubstanceAdminSubstitutionReason/vs.html"

* substitution.responsibleParty 0..1 MS 
* substitution.responsibleParty ^short = "Für die Subistution Verantwortlicher."
* substitution.responsibleParty only Reference(HL7ATCorePractitioner or HL7ATCorePractitionerRole)

* detectedIssue 0..0
* detectedIssue ^short = "Referenenz auf DetectedIssue Ressource. Verwendung prüfen."

* eventHistory 0..0
* eventHistory ^short = "Bezeichnet eine Liste von Provenance-Ressourcen, die verschiedene relevante Versionen 
dieser Ressource dokumentieren. Verwendung prüfen."