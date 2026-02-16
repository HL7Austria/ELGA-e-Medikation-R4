Profile: AtEmedMedication
Parent: Medication
Id: at-emed-medication
Title: "ELGA e-Med Medikation"
Description: "**Beschreibung:** Bildet ein Arzneimittel in der \"Medication\"-Ressource ab. Wird grundsätzlich verwendet in Planeintrag, geplante Abgabe und durchgeführte Abgabe. Aktuell nur geprüft im Kontext Planeintrag.
Unterschieden werden folgende Fälle:
1. Arzneimittel besitzt eine PZN und wird über diese identifiziert, die weiteren Informationen werden durch die Fachanwendung angereichert.
    a. Identifikation nur über PZN: eine Befüllung jener Felder, die über die ASP-Liste angereichert werden können, durch den GDA wird technisch verhindert (Invariante oder eigene Medication Ressource).
    b. Identifikation über PZN und Handelsname: damit eine Prüfung auf Übereinstimmung durchgeführt werden kann. TODO: Juristisch zu prüfen. 
3. Arzneimittel besitzt keine PZN, alle benötigten Informationen sind verpflichtend vom GDA zu befüllen:
    a. Bei Verschreibung von Wirkstoffen
    b. Bei magistraler Anwendung, Infusionen 
"

* text 0..1 MS  //ergänzt AKL
* text ^short = "TODO: Freitext für magistrale Anwendungen oder Abbildung in Substance.description?"

* identifier 0..0 
* identifier ^short = "Eindeutiger Identifikator für das Arzneimittel. Wird nicht benötigt, da PZN, sofern vorhanden, im Code angegeben wird."

* code 0..1 MS
* code from $cs-asp-liste (required) 
* code ^short = "Code des Arzneimittels. Hier muss die Pharmazentralnummer (PZN) aus der ASP-Liste angegeben werden, sofern vorhanden.
TODO: Slicing für meherere Codings
Gem. CDA V3: 
Das Codesystem Pharmazentralnummer {1.2.40.0.34.4.16} wird am Terminologieserver in der ASP-Liste (Liste der humanen Arzneispezialitäten gelistet nach PZN) publiziert, 
die ASP-Liste enthält neben der Pharmazentralnummer {1.2.40.0.34.4.17} auch die korrespondierende Zulassungsnummer und Package Reference Number der AGES {1.2.40.0.34.4.26}. 
Für die Kompatibilität zum EU Kontext wird zukünftig auch die PCID der EMA {1.2.40.0.34.4.27} ermöglicht."  
* code.coding.code 0..1
* code.coding.display 0..1
* code.coding.display ^short = "Juristisch zu prüfen, ob mindestens ein Displayname (Handelsname) zur PZN angegeben werden muss (Zwecks Prüfung auf Übereinstimmung und 
historischer Verfügbarkeit, im Falle von sich ändernden PZNs; evtl. könnte die Fachanwendung."

* status 0..0 
* status ^short = "Verfügbarkeitsstatus des Arzneimittels:(req) active | inactive | entered-in-error. https://hl7.org/fhir/R4/valueset-medication-status.html.
 Keine Verwendung im Kontext Planeintrag."

* manufacturer 0..0 
//* manufacturer only Reference(HL7ATCoreOrganization)
* manufacturer ^short = "Der Hersteller des Arzneimittels. Keine Verwendung im Kontext Planeintrag. 
TODO: Prüfen, ob im Kontext durchgeführte Abgabe und magistraler Zubereitung erforderlich; HL7ATCoreOrganization schränkt auf Organisationen gemäß GDA-Index ein."

* form 0..1 MS 
* form from $cs-emed-doseform (required)
* form ^short = "Die Darreichungsform des Arzneimittels. Wenn PZN vorhanden 0..0, da Anreicherung aus ASP-Liste durch Fachanwendung.
Gem. CDA V3: 
Für die e-Medikation ist das CodeSystem ​Medikation_Darreichungsform 1.2.40.0.10.1.4.3.4.3.5 zu verwenden.
Für den eHDSI Kontext ist das CodeSystem 0.4.0.127.0.16.1.1.2.1 zu verwenden."

* amount 0..1 MS  
* form from $vs-emed-mengenart (required)
* amount ^short = "Die Gesamtmenge des Arzneimittels in der Verpackung. 
Wenn PZN vorhanden 0..0, da Anreicherung aus ASP-Liste durch Fachanwendung."

* ingredient 0..* MS
* ingredient ^short = "Wirkstoffe. Wenn PZN vorhanden 0..0, da Anreicherung aus ASP-Liste durch Fachanwendung.
Gemäß AG: Einschränkung auf CodeableConcept, TODO: prüfen, wie Freitext bei magistraler Zubereitung abgebildet wird:
Evtl. in einer Substance-Ressource in der description (string)."
* ingredient.item[x] only CodeableConcept or Reference(AtEmedSubstance) // or AtEmedMedication, TODO Substance profilieren
* ingredient.itemCodeableConcept 0..1 MS 
* ingredient.itemCodeableConcept ^short = "Inhaltsstoff codiert. TODO: prüfen, Einschränkung auf SPOR (EMA). Gemüß CDA v3:
Wirkstoff-Codes stammen aus der ATC-Klassifikation (Anatomical Therapeutic Chemical Classification), die von der WHO herausgegeben wird. 
Weitere Codes, wie auch die deutsche Bezeichnung der Codes, entsprechen dem GKV-Arzneimittelindex im Wissenschaftlichen Institut der AOK (WidO), 
AOK Bundesverband GbR, Deutschland, welcher auf den WHO ATC basiert.
Zusätzlich kommen ergänzende Codes aus dem Arzneimittelverzeichnis der AGES zum Einsatz."
* ingredient.itemReference 0..1 MS
* ingredient.itemReference.reference obeys contained-sub  // contained Substance
* ingredient.itemReference ^short = "Referenz auf Ressourcen Substance im Fall von magistraler Anwendung"

* ingredient.isActive 0..1 MS
* ingredient.isActive ^short = "Aktive Wirkstoff TRUE/FALSE"

* ingredient.strength 0..1 MS
* ingredient.strength ^short = "Menge der vorhandenen Zutat"

* batch 0..0 // MS
* batch ^short = "Informationen zur Charge des Arzneimittels. Keine Verwenund im Kontext Planeintrag."



Invariant: contained-sub
Description: "Substance must be contained"
Severity: #error
Expression: "reference.startsWith('#')"