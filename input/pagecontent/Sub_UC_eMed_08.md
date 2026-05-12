{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_08) -->

### Sub_UC_eMed_08_01 - Geplante Abgabe basierend auf Planeintrag erfassen


Ein GDA kann basierend auf einem bestehenden Medikationsplaneintrag ein oder mehrere geplanten Abgaben erstellen und das Erzeugen eines e-Rezepts auslösen.

Sollte für die geplante Abgabe noch kein zugehöriger Medikationsplaneintrag existieren, muss dieser zuerst erstellt werden (siehe [Sub_UC_eMed_06_03 - Medikationsplaneintrag in Medikationsplan hinzufügen](Sub_UC_eMed_06.html#sub_uc_emed_06_03---medikationsplaneintrag-in-medikationsplan-hinzufügen)).

Ist keine Anpassung des Medikationsplaneintrags erforderlich, führt der GDA ein [$readtowrite](interactions.html#read-to-write-zugriff) aus und erhält von der Fachanwendung das aktuelle Collection Bundle (AtEmedBundleMedikationsplan), das den Medikationsplan mit allen relevanten Ressourcen enthält.
Basierend auf vorhandenen Planeinträgen (AtElgaEmedMedicationRequestPlaneintrag) erstellt der GDA neue geplante Abgaben (AtElgaEmedMedicationRequestGeplanteAbgabe) wie folgt:
- Der Status der neuen geplanten Abgabe ist offen (*active*) 
- Die Rezeptart muss verpflichtend ausgewählt werden (*Kassenrezept, Privatrezept* oder *Substitutionsrezept*)
- Die Medikation ist gemäß Planeintrag zu übernehmen. Enthält der Planeintrag ausschließlich Wirkstoffe, ist ein entsprechendes Medikament aus der ASP-Liste (inkl. PZN) bzw. eine magistrale Zubereitung zu dokumentieren. 
<!-- TODO: prüfen, ob die Medikation ist gemäß Planeintrag zu übernehmen ist -->
- Werden mehrere geplante Abgaben zeitgleich erstellt, können diese mittels gleichem *e-Med groupIdentifier* versehen werden ("Rezeptklammer", die auch im e-Rezept mitgeführt wird). Diese eindeutige Kennung kann von der Fachanwendung über eine Schnittstelle angefordert werden und ermöglicht berechtigten Akteuren eine gezielte Suche nach geplanten Abgaben. 
- Dosierangaben können angepasst werden
- Der Gültigkeitszeitraum (*dispenseRequest.validityPeriod*), innerhalb dessen geplante Abgaben eingelöst werden können, 
- sowie die Anzahl möglicher weiterer Einlösungen (*dispenseRequest.numberOfRepeatsAllowed*) ist abhängig von der ausgewählten **Rezeptart** (siehe Status der geplanten Abgabe)
- Die Menge des Medikaments, die bei jeder Abgabe bereitgestellt werden soll, ist zu dokumentieren
(*dispenseRequest.quantity*).
<!-- TODO Suchparameter emed-id: alle geplanten abgaben zu einer e-med-id finden -->


#### Ablauf

<div>{% include_relative plantuml/UC_eMed_08_01.svg %}</div>


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: active 
    category:recipetype                     // Verpflichtende Angabe der Rezeptart
    medicationReference.reference: Medikation mit PZN oder Magistrale Anwendung // Contained Medication, diese muss der Medikation aus dem Medikationsplaneintrag entsprechen
    authoredOn: Datum der Erstellung des Medikationsplaneintrags    
    requester: veranwortlicher GDA         // wird auf Übereinstimmung mit List.source geprüft
    basedOn: Referenz auf den zugehörigen Medikationsplaneintrag 
    groupIdentifier: e-Med-ID              // Rezeptklammer 
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft) 
    dispenseRequest.validityPeriod         // abhängig von Rezeptart, bzw. verkürzt durch gda
    dispenseRequest.numberOfRepeatsAllowed // abhängig von Rezeptart
    dispenseRequest.quantity
```

<!-- ### Sub_UC_eMed_08_02 - Geplante Abgabe basierend auf neuem Planeintrag erfassen -->

<!-- #### Ablauf -->
<!-- 
<div>{ include_relative plantuml/UC_eMed_08_02.svg }</div> -->
<!-- Rezept/ Verordnung (PRESCRIPTION) -->



### Sub_UC_eMed_08_02 - Geplante Abgabe beenden

<!-- |  **completed**  | geplante Abgabe beendet | -->


### Sub_UC_eMed_08_03 - Geplante Abgabe abgelaufen

<!-- Nach der letztmöglichen durchgeführten Abgabe zur geplanten Abgabe, setzt die Fachanwendung den Status der geplanten Abgabe auf beendet. -->

### Sub_UC_eMed_08_04 - Geplante Abgabe verwerfen
<!-- |  **entered-in-error**  | geplante Abgabe storniert| -->

#### Sub_UC_eMed_08_05 - Geplante Abgabe durch ELGA-Teilnehmer löschen

<!-- $delete oder DELETE -->



#### Beispiel

#### Technische Hinweise

#### Relevante Profile

#### Relevante Invarianten

#### Mögliche Notifications