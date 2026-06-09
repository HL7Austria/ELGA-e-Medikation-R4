{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_08) -->

### Sub_UC_eMed_08_01 - Geplante Abgabe erfassen

Ein GDA kann basierend auf einem **bestehenden** [Medikationsplaneintrag](design_choices.html#medikationsplaneintrag-bzw-planeintrag-atelgaemedmedicationrequestplaneintrag-medicationrequest) eine oder mehrere [Geplanten Abgaben](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) erstellen. Je verordnetes Medikament **muss** eine *Geplante Abgabe* erstellt werden.

Sollte für eine *Geplante Abgabe* noch kein Medikationsplaneintrag existieren, muss dieser zuerst erstellt werden (siehe [Sub_UC_eMed_06_03 - Medikationsplaneintrag in Medikationsplan hinzufügen](Sub_UC_eMed_06.html#sub_uc_emed_06_03---medikationsplaneintrag-in-medikationsplan-hinzufügen)). 
Bei Bedarf kann ein bestehender Medikationsplaneintrag angepasst werden (siehe [Sub_UC_eMed_06_06 - Medikationsplaneintrag im Medikationsplan ändern](Sub_UC_eMed_06.html#sub_uc_emed_06_06---medikationsplaneintrag-im-medikationsplan-ändern)).

Ist keine Anpassung des Medikationsplaneintrags erforderlich, führt der GDA ein [$plan-read](interactions.html#plan-read) aus und erhält von der Fachanwendung das [Auslieferungs-Collection-Bundle](design_choices.html#auslieferungs-medikationsplan-collection-bundle), das den Medikationsplan mit allen relevanten Ressourcen enthält.

Basierend auf darin vorhandenen Planeinträgen erstellt der GDA neue *Geplante Abgabe*n wie folgt:
- Der Status der neuen geplanten Abgabe muss *offen* sein (**active**) 
- Die **Rezeptart** muss verpflichtend ausgewählt werden (*Kassenrezept, Privatrezept* oder *Substitutionsrezept*)
- Die **Medikation** soll fachlich jener des Planeintrags entsprechen. Enthält der Planeintrag ausschließlich Wirkstoffe, ist verpflichtend ein entsprechendes Medikament aus der ASP-Liste (inkl. PZN) bzw. eine magistrale Zubereitung zu dokumentieren. 
- Werden mehrere Medikamente gleichzeitig verordnet und sollen demselben e-Rezept zugeordnet werden, muss jede erstellte *Geplante Abgabe* mit demselben **groupIdentifier** versehen werden. Mithilfe dieser eindeutigen Kennung ('Rezept-Klammer') können berechtigte Akteure später gezielt nach zusammengehörenden *Geplanten Abgaben* suchen. Der hierfür verwendete *e-Med groupIdentifier* kann über unterschiedliche Varianten bezogen werden (siehe [Ablauf - Bezug e-Med groupIdentifier](Sub_UC_eMed_08.html#ablauf---bezug-e-med-groupidentifier)).
In einem Bundle sollen nur *Geplanten Abgaben* mit dem gleichen *e-Med groupIdentifier* enthalten sein. 
- **Dosierangaben** können optional angepasst werden.
- Abhängig von der ausgewählten **Rezeptart** (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart)) können:
    - der **Gültigkeitszeitraum** (*dispenseRequest.validityPeriod*), innerhalb dessen die *Geplante Abgabe* eingelöst werden kann, sowie
    - die Anzahl möglicher weiterer **Einlösungen** (*dispenseRequest.numberOfRepeatsAllowed*) festgelegt werden
- Die **Menge** (Anzahl Packungen), die bei jeder Abgabe bereitgestellt werden soll, ist verpflichtend zu dokumentieren (*dispenseRequest.quantity*).

Die erstellten Geplanten Abgaben werden mittels Bundle vom Typ Transaction, mittels [Prescription-Write](interactions.html#request-write) an die Fachanwendung übermittelt wird. 


<!-- TODO Suchparameter emed-id: alle geplanten abgaben zu einer e-med-id finden -->


#### Ablauf und Bezug e-Med groupIdentifier

Der Ablauf zur Erstellung von geplanten Abgaben und der Bezug des e-Med GroupIdentifiers kann unterschiedlich erfolgen. Exemplarisch werden 3 Varianten angeführt.

##### Variante A: Vorab-Ermittlung des e-Med GroupIdentifiers

Der *e-Med groupIdentifier* ("Rezeptklammer") wird via POST [$groupidentifier-create] vorab bezogen, in den *Geplanten Abgaben* im [Geplante Abgabe Transaction-Bundle](design_choices.html#geplante-abgabe-transaction-bundle-atemedbundlegeplanteabgabetx-transaction-bundle) ergänzt und bei der Erstellung des e-Rezepts an die e-Rezept-Anwendung mitgegeben.
Der Trigger zu Erstellung des e-Rezepts und [Prescription-Write](interactions.html#request-write) können parallel erfolgen. 

Liefert e-Rezept einen Fehler zurück, können mittels POST $prescription-discard bereits erstellte *Geplante Abgaben* verworfen werden.
Liefert die e-Medikation Fachanwendung einen Fehler zurück, kann nach Fehlerkorrektur erneut ein *Prescription-Write* erfolgen oder ein bereits durch den *e-Med groupIdentifer* verknüpftes e-Rezept wieder "entkoppelt" werden.
<!-- TODO Transaction Bundle erstellen -->

<br>
<div style="height: 80%;">{% include_relative plantuml/UC_eMed_08_01_a.svg %} </div>
<br>


##### Variante B: Sequentielles Erstellen von Geplanter Abgabe und e-Rezept 

Alternativ kann der *e-Med groupIdentifier* durch die Fachanwendung automatisch ergänzt werden, wenn er beim Prescription-Write Transaction Bundle nicht enthalten ist. Dadurch bleibt das Verhalten konsistent zur bestehenden e-Medikations-Implementierung.

<!-- Fachanwendung ergänzt groupIdentifier, e-Rezept mit groupIdentifier erstellen -->


<br>
<div style="height: 80%;">{% include_relative plantuml/UC_eMed_08_01_b.svg %} </div>
<br>

##### Variante C: Nachträgliche Verknüpfung des e-Rezepts mit dem e-Med GroupIdentifier


<br>
<div style="height: 80%;">{% include_relative plantuml/UC_eMed_08_01_c.svg %} </div>
<br>




#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: active 
    category: recipetype                     // Verpflichtende Angabe der Rezeptart
    medicationReference.reference: Medikation gemäß zugehörigem Planeintrag // Contained Medication
    authoredOn: Datum der Erstellung der Geplanten Abgabe
    requester: veranwortlicher GDA für die Geplante Abgabe  // wird auf Übereinstimmung mit List.source geprüft
    basedOn: id des zugehörigen Medikationsplaneintrags
    groupIdentifier: e-Med groupIdentifier  // optionale Rezeptklammer 
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft) 
    dispenseRequest.validityPeriod:         // Gültigkeitszeitraum (abhängig von Rezeptart bzw. verkürzt durch GDA)
    dispenseRequest.numberOfRepeatsAllowed: // Anzahl weiterer Einlösungen (abhängig von Rezeptart)
    dispenseRequest.quantity:               // Abzugebende Menge (Packungen) je Abgabe
```


### Sub_UC_eMed_08_04 - Geplante Abgabe verwerfen

Ein GDA kann jede bestehende [Geplante Abgabe](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) aufgrund es Fehlers verwerfen (auch wenn er die *Geplante Abgabe* nicht selbst erstellt hat), solange noch **keine Abgaben durchgeführt** wurden. Die verworfene *Geplante Abgabe* wird damit abgeschlossen, kann aber über die Historie der geplanten Abgaben eingesehen werden.
<!-- TODO: Suchparameter nach stornierten *Geplante Abgabe*n? -->
<!-- TODO: kann ein GDA die *Geplante Abgabe* eines anderen GDAs verwerfen oder nur die eigenen? -->
<!-- Wenn nicht seine eigene, woher soll er wissen, dass es ein Irrtum war? Begründung f Statuswechsel dzt nicht möglich. -->

Um eine *Geplante Abgabe* zu verwerfen, ruft der GDA diese mittels GET MedicationRequest ab und bearbeitet diesen wie folgt:
- Der Status wird auf *entered-in-error* gesetzt,
- der verantwortliche GDA (*requester*) und das Datum in *authoredOn* werden entsprechend aktualisiert.

Der GDA übermittelt (via POST [base]/GeplAbgabe/Bundle/) den aktualisierten Medikationsplan der Fachanwendung.

<!-- TODO: Wenn stornierte *Geplante Abgabe* Teil eines e-Rezepts mit weiteren geplanten Abgaben ist: Auswirkungen? keine -->

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: entered-in-error 
    authoredOn: Datum des Verwerfens der Geplanten Abgabe
    requester: veranwortlicher GDA für das Verwerfen der Geplanten Abgabe  // wird auf Übereinstimmung mit List.source geprüft
```

### Sub_UC_eMed_08_02 - Geplante Abgabe beenden (durch Fachanwendung)

<!-- |  **completed**  | *Geplante Abgabe* beendet | -->

Wurden alle geplanten Abgaben planmäßig durchgeführt (gemäß dem ausgewählten Rezepttyp oder den Einschränkungen des GDAs), setzt die Fachanwendung die *Geplante Abgabe* automatisch auf den Status *completed*.

Sonderfall: Wenn die letzte durchgeführte Abgabe danach verworfen wird (Status *entered-in-error*), wird der Status der geplanten Abgabe durch die Fachanwendung wieder auf *active* gesetzt.

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: completed
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```

### Sub_UC_eMed_08_03 - Geplante Abgabe abgelaufen (durch Fachanwendung)

Ist der Einlösezeitraum der geplanten Abgaben gemäß dem ausgewählten Rezepttyp oder den Einschränkungen des GDAs überschritten, setzt die Fachanwendung die *Geplante Abgabe* automatisch auf den Status *stopped*.

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: stopped
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```


<!-- ### Sub_UC_eMed_08_03 - Geplante Abgabe gecancelt (durch Fachanwendung)  TODO

Ist der Einlösezeitraum der geplanten Abgaben gemäß dem ausgewählten Rezepttyp oder den Einschränkungen des GDAs überschritten, setzt die Fachanwendung die *Geplante Abgabe* automatisch auf den Status *stopped*.

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: stopped
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert -->




### Sub_UC_eMed_08_05 - Geplante Abgabe löschen (durch ELGA-Teilnehmer)

Der ELGA-Teilnehmer kann eine *Geplante Abgabe* endgültig löschen. Bereits dokumentierte durchgeführte Abgaben sowie bestehende Planeinträge bleiben davon unberührt.

Die Löschung der geplanten Abgabe umfasst:

- die fachliche Entfernung der betreffenden MedicationRequest-Ressource sowie
- die Entfernung aller zugehörigen historischen Ressourcenversionen (_history).

Zum Löschen einer geplanten Abgabe ruft der ELGA-Teilnehmer die betreffende *Geplante Abgabe* im ELGA-Portal auf. Dieses führt zunächst eine Leseoperation auf die betreffende MedicationRequest-Ressource aus (GET MedicationRequest/[id]) und löscht anschließend die betreffende *Geplante Abgabe* mittels DELETE (DELETE [base]/MedicationRequest/[id]).

Die Ressource einschließlich aller historischen Versionen darf nach erfolgreicher Löschung weder über reguläre FHIR-Interaktionen noch über administrative Schnittstellen abrufbar sein.

<!-- #### Beispiel -->

<!-- #### Technische Hinweise -->

<!-- #### Relevante Profile -->

<!-- #### Relevante Invarianten -->

<!-- #### Mögliche Notifications -->



<!-- ##### e-Rezept von e-Med groupIdentifier entkoppeln -->