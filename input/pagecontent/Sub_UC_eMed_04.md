{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_04) -->

### Sub_UC_eMed_04_01 - Geplante Abgabe erstellen (Prescription-Write)

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann basierend auf einem **bestehenden** *Medikationsplaneintrag* eine oder mehrere [Geplanten Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) erstellen. Für jedes verordnete Medikament muss eine eigene *Geplante Abgabe* erstellt werden.

Falls für eine *Geplante Abgabe* noch kein entsprechender Medikationsplaneintrag existiert, muss dieser zuerst erstellt werden (siehe [Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen](Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen)). 
Bei Bedarf kann ein bestehender Medikationsplaneintrag angepasst werden (siehe [Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern)).

Ist keine Anpassung des Medikationsplaneintrags erforderlich, führt der GDA ein [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und erhält von der Fachanwendung das **Medikationsplan-Searchset-Bundle**, das den Medikationsplan mit allen für die Erstellung der *Geplanten Abgaben* relevanten Ressourcen enthält.

Basierend auf darin enthaltenen Planeinträgen erstellt der GDA neue *Geplante Abgaben* mit folgenden Angaben:
- Der Status der neuen *Geplanten Abgabe* muss *offen* sein (**active**, siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)) 
- Die **Rezeptart** muss verpflichtend ausgewählt werden (*Kassenrezept, Privatrezept* oder *Substitutionsrezept*)
- Die **Medikation** soll fachlich jener des Planeintrags entsprechen. Enthält der Planeintrag ausschließlich Wirkstoffe, ist verpflichtend ein entsprechendes Medikament aus der ASP-Liste (inkl. PZN) bzw. eine magistrale Zubereitung zu dokumentieren. 
- Werden mehrere Medikamente gleichzeitig verordnet und demselben e-Rezept zugeordnet, muss jede zugehörige *Geplante Abgabe* mit demselben **e-Med GroupIdentifier** versehen werden. Diese  eindeutige Kennung ('Rezept-Klammer') ermöglicht es berechtigten Akteure, die zusammengehörigen *Geplanten Abgaben* und *Durchgeführten Abgaben* abzurufen. Der hierfür verwendete *e-Med GroupIdentifier* kann über unterschiedliche Varianten bezogen werden (siehe [Ablauf und Bezug e-Med GroupIdentifier](Sub_UC_eMed_04.html#ablauf-und-bezug-e-med-groupidentifier)) und bleibt solange gültig, bis die letztmögliche Einlösung der *Geplanten Abgaben* erfolgt ist. 
<!-- TODO: oder die *Geplante Abgabe* den Status *active* hat? -->
In einem übermittelten Bundle dürfen nur *Geplante Abgaben* mit demselben *e-Med GroupIdentifier* enthalten sein. Fehlt dieser, ergänzt ihn die Fachanwendung. Werden mehrere e-Rezepte gleichzeitig erstellt, muss für jedes e-Rezept ein eigenes Bundle mit den jeweils zugehörigen *Geplanten Abgaben* erstellt werden.
- **Dosierangaben** können optional angepasst werden.
- Abhängig von der ausgewählten **Rezeptart** (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart)) können:
    - der **Gültigkeitszeitraum** (*dispenseRequest.validityPeriod*), innerhalb dessen die *Geplante Abgabe* eingelöst werden kann, sowie
    - die Anzahl möglicher weiterer **Einlösungen** (*dispenseRequest.numberOfRepeatsAllowed*) festgelegt werden
    <!-- TODO erklären was genau mit "weiterer" gemeint ist-->
- Die **Menge** (Anzahl Packungen), die bei jeder Abgabe bereitgestellt werden soll, ist verpflichtend zu dokumentieren (*dispenseRequest.quantity*).

Die erstellten *Geplanten Abgaben* werden in einem **Bundle** vom Typ **Transaction** mittels [Prescription-Write](interactions.html#prescription-write) an die Fachanwendung übermittelt wird. 

<p class="note-to-balloters">
Offene Punkte: <br>
- Wirkstoffe in Planeintrag? <br>
- Dürfen Geplante Abgaben hinsichtich Medikation und Dosierung vom Planeintrag abweichen?
</p>

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: active 
    category[mrcategory]: 2 "Geplante Abgabe"               //Kategorie zur Unterscheidung der MedicationRequests
    category[recipetype]: KASSEN | PRIVAT | SUBST          // Verpflichtende Angabe der Rezeptart
    intent: order                                           // Fester Wert
    medicationReference.reference: Medikation gemäß zugehörigem Planeintrag // Contained Medication
    authoredOn: Datum der Erstellung der Geplanten Abgabe
    requester: veranwortlicher GDA für die Geplante Abgabe  // wird auf Übereinstimmung mit List.source geprüft
    basedOn: id des zugehörigen Medikationsplaneintrags     // referenziert aktuelle Version 
    groupIdentifier: e-Med GroupIdentifier                  // optionale Rezeptklammer 
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft) 
    dispenseRequest.validityPeriod: Gültigkeitszeitraum     // abhängig von Rezeptart bzw. verkürzt durch GDA
    dispenseRequest.numberOfRepeatsAllowed: Anzahl weiterer Einlösungen // abhängig von Rezeptart bzw. verkürzt durch GDA
    dispenseRequest.quantity: Abzugebende Menge (Packungen) je Abgabe
```

##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$prescription-write: in Arbeit.
</p>
</div>

#### Ablauf und Bezug e-Med GroupIdentifier

Der Ablauf zur Erstellung von *Geplanten Abgaben* und der Bezug des *e-Med GroupIdentifiers* kann unterschiedlich erfolgen. Exemplarisch werden drei Varianten angeführt.

##### Variante A: Vorab-Ermittlung des e-Med GroupIdentifiers

Der *e-Med GroupIdentifier* ("Rezeptklammer") wird via POST *$groupidentifier-create* vorab von der Fachanwendung bezogen, in den *Geplanten Abgaben* ergänzt und zur Erstellung des e-Rezepts an die e-Rezept-Anwendung mitgegeben, um dieses mit den *Geplanten Abgaben* zu verknüpfen.
Der Trigger zu Erstellung des e-Rezepts und [Prescription-Write](interactions.html#prescription-write) können parallel erfolgen (siehe Normalfall). 

Liefert e-Rezept einen Fehler zurück, können mittels POST *$prescription-discard* bereits in der e-Medikation erstellte *Geplante Abgaben* verworfen werden (siehe [Sub_UC_eMed_08_04 - Geplante Abgabe stornieren ($prescription-discard)](Sub_UC_eMed_04.html#sub_uc_emed_08_04---geplante-abgabe-stornieren-prescription-discard)).
Liefert die e-Medikation Fachanwendung einen Fehler zurück, kann nach Fehlerkorrektur erneut ein *Prescription-Write* erfolgen oder ein bereits durch den *e-Med groupIdentifer* verknüpftes e-Rezept wieder von den *Geplanten Abgaben* "entkoppelt" werden (siehe [Variante A: Fehlerfall](Sub_UC_eMed_04.html#variante-a-fehlerfall)).
<!-- TODO Transaction Bundle erstellen -->

###### Variante A: Normalfall

[![overview](plantuml/UC_eMed_04_01_a_normal.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_a_normal.svg)

<br>


###### Variante A: Fehlerfall

[![overview](plantuml/UC_eMed_04_01_a_fehler.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_a_fehler.svg)

<br>

##### Variante B: Sequentielles Erstellen von Geplanter Abgabe und e-Rezept 

Alternativ kann der *e-Med GroupIdentifier* durch die Fachanwendung automatisch ergänzt werden, wenn dieser beim *Prescription-Write* nicht in den *Geplanten Abgaben* im Transaction Bundle enthalten ist. Dadurch bleibt das Verhalten konsistent zur bestehenden e-Medikations-Implementierung.
Hierfür müssen die Geplanten Abgaben gemeinsam in einem Transaction Bundle an die e-Medikation Fachanwendung übermittelt werden.
Der Server ergänzt den *e-Med GroupIdentifier* während der Transaktionsverarbeitung. Die persistierten Ressourcen einschließlich des erzeugten *e-Med GroupIdentifiers* werden im Response an den Client zurückgegeben.
Im Anschluss kann der Trigger zur Erstellung des e-Rezepts inkl. *e-Med GroupIdentifier* erfolgen.

<br>

[![overview](plantuml/UC_eMed_04_01_b.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_b.svg)

<br>

##### Variante C: Nachträgliche Verknüpfung des e-Rezepts mit dem e-Med GroupIdentifier

Der Trigger zu Erstellung des e-Rezepts und [Prescription-Write](interactions.html#prescription-write) können parallel erfolgen (Variante A), allerdings noch ohne *e-Med GroupIdentifier*.
Die e-Medikation Fachanwendung ergänzt diesen und liefert ihn an den Client zurück (wie in Variante B), der Client führt im Anschluss eine nachträgliche Verknüfung des bereits erstellten e-Rezepts mit den geplanten Abgaben mittels *e-Med GroupIdentifier* durch.

<br>

[![overview](plantuml/UC_eMed_04_01_c.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_c.svg)

<br>

##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$groupidentifier-create: in Arbeit.
</p>
</div>


### Sub_UC_eMed_08_04 - Geplante Abgabe stornieren ($prescription-discard)

<!-- TODO Klären STORNO vs VERWERFEN: https://www.chipkarte.at/cdscontent/load?contentid=10008.781687&version=1698069647:  -->

Ein GDA kann eine selbsterfasste *Geplante Abgabe* aufgrund eines Fehlers stornieren, solange noch keine Abgaben durchgeführt (dh. noch keine zugehörige *Durchgeführten Abgaben* erstellt) wurden. 
* Ausnahme: Alle zugehörigen *Durchgeführten Abgaben* werden zuvor storniert
<!-- Die verworfene *Geplante Abgabe* kann über die Historie der *Geplanten Abgaben* eingesehen werden.: entfernt: stornierte Geplante Abgaben sind wie alle anderen Geplanten Abgaben via GET auf MedicationRequest mit der Kategorie Geplante Abgabe status entered-in-error abrufbar.  -->

Um eine *Geplante Abgabe* zu stornieren, führt der GDA die Operation [$prescription-discard​](interactions.html#prescription-discard) aus:
- Der Status der *Geplante Abgaben* wird auf ***entered-in-error*** gesetzt (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)),
- das Datum in *authoredOn* wird aktualisiert.

<!-- TODO: Wenn stornierte *Geplante Abgabe* Teil eines e-Rezepts mit weiteren geplanten Abgaben ist: Auswirkungen? keine -->

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: entered-in-error 
    authoredOn: Datum des Verwerfens der Geplanten Abgabe
    requester: veranwortlicher GDA für das Verwerfen der Geplanten Abgabe 
```
##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$prescription-discard: in Arbeit.
</p>
</div>


### Sub_UC_eMed_08_02 - Geplante Abgabe beenden (durch Fachanwendung)

Wurden alle möglichen Einlösungen einer *Geplanten Abgabe* planmäßig durchgeführt (siehe [Sub_UC_eMed_05_01 - Durchgeführte Abgabe erfassen](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-erfassen)), setzt die Fachanwendung die *Geplante Abgabe* **automatisch** auf den Status ***completed*** (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)). Die *Geplante Abgabe* ist damit abgeschlossen.

Sonderfall: Wenn die letzte *Durchgeführte Abgabe* danach verworfen wird (Status *entered-in-error*), wird der Status der *Geplanten Abgabe* durch die Fachanwendung wieder auf *active* gesetzt.

Die Fachanwendung erkennt anhand von *MedicationRequest.numberOfRepeatsAllowed*, ob weitere Einlösungen erlaubt sind (z.B. bei einem Privatrezept). Ist nur eine einmalige Einlösung möglich (z.B. Kassenrezept), setzt die Fachanwendung die *Geplanten Abgabe* sofort auf den Status *completed*.

Ermöglicht die *Geplante Abgabe* mehrere Einlösungen (*MedicationRequest.numberOfRepeatsAllowed > 0*), muss je Einlösung mindestens eine *Durchgeführte Abgabe* erstellt werden (bei Teilabgaben können es mehrere sein). 
Eine Einlösung gilt als vollständig, wenn für MedicationDispense.type den Wert FFC (First Fill – Complete) oder PFC (Part Fill - Complete) enthält.

Der Status der *Geplanten Abgabe* bleibt solange *active*, bis die letztmögliche Einlösung erfolgt ist (sieheSub_UC_eMed_08_02 - Geplante Abgabe beenden (durch Fachanwendung)).


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: completed
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>Erfolgt in der Geplanten Abgabe eine Datumsanpassung bei automatischen Aktionen durch die Fachanwendung? (in R6 gibt es dafür das Element: statusChanged); betrifft alle automatischen Statuswechsel der Geplanten Abgabe.	
</p>
</div>

### Sub_UC_eMed_08_03 - Geplante Abgabe abgelaufen (durch Fachanwendung)

Ist der Gültigkeitszeitraum in *dispenseRequest.validityPeriod* der *Geplanten Abgabe* gemäß der ausgewählten Rezeptart (category:recipetype) (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart)) oder den Einschränkungen des GDAs überschritten, setzt die Fachanwendung die *Geplante Abgabe* **automatisch** auf den Status ***stopped*** (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)). Die *Geplante Abgabe* ist damit abgeschlossen.


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: stopped
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```

### Sub_UC_eMed_08_03 - Geplante Abgabe gecancelt (durch Fachanwendung) 

<!-- Geplante Abgabe wird nicht weiter bedient -->
Eine *Geplante Abgabe* erhält **automatisch** den Status *cancelled* (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)), wenn **alle** *Durchgeführten Abgaben* (jede Einlösung) den Status ***cancelled*** erhalten haben ("Leerabgabe", d.h. keine Abgabe durchgeführt). Die *Geplanten Abgabe* ist damit abgeschlossen.

Sonderfall: Wenn die letzte *Durchgeführte Abgabe* danach verworfen wird (Status *entered-in-error*), wird der Status der *Geplanten Abgabe* durch die Fachanwendung wieder auf *active* gesetzt.


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: cancelled
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```


### Sub_UC_eMed_08_05 - Geplante Abgabe löschen (durch ELGA-Teilnehmer) (prescription-delete)

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Umsetzung Teilnehmerrechte
</p>
</div>

<br>
Der ELGA-Teilnehmer kann eine *Geplante Abgabe* endgültig löschen. Bereits dokumentierte zugehörige *Durchgeführte Abgaben* sowie bestehende Planeinträge bleiben davon unberührt.

Die Löschung der *Geplanten Abgabe* umfasst:

- die fachliche Entfernung der betreffenden MedicationRequest-Ressource sowie
- die Entfernung aller zugehörigen historischen Ressourcen-Versionen (_history).

Zum Löschen einer *Geplanten Abgabe* ruft der ELGA-Teilnehmer diese im Zugangsportal auf. Dieses führt zunächst eine Leseoperation auf die betreffende MedicationRequest-Ressource aus (GET MedicationRequest/[id]) und löscht anschließend die betreffende *Geplante Abgabe* mittels DELETE (DELETE [base]/MedicationRequest/[id]).

Die Ressource einschließlich aller historischen Versionen darf nach erfolgreicher Löschung weder über reguläre FHIR-Interaktionen noch über administrative Schnittstellen abrufbar sein.
<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Referenzen auf gelöschte Ressourcen (z.B. von bestehenden Durchgefürhte Abgaben auf gelöschte Geplante Abgaben) können nicht mehr aufgelöst werden.
</p>
</div>


<!-- #### Beispiel -->

<!-- #### Technische Hinweise -->

<!-- #### Relevante Profile -->

<!-- #### Relevante Invarianten -->

<!-- #### Mögliche Notifications -->




