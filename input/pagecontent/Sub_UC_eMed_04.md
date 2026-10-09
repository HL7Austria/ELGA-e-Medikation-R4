{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_04) -->

Dieser technische Use Case beschreibt den schreibenden Zugriff [berechtigter Akteure](actors.html#rollen-und-berechtigungen) auf [Geplanten Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) eines ELGA-Teilnehmers.

Für ELGA-Teilnehmer (bzw. deren Vertretungen) erfolgt der schreibende Zugriff im Rahmen der Ausübung von Teilnehmerrechten ausschließlich über das ELGA-Zugangsportal. Für GDA erfolgt der schreibende Zugriff über die e-Medikation-Schnittstelle des jeweiligen GDA-Systems.

Der schreibende Zugriff umfasst folgende Bearbeitungen:
* **GDA** können *Geplante Abgaben*:
    * [erstellen](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write) und 
        * [e-Med GroupIdentifier beziehen](Sub_UC_eMed_04.html#sub_uc_emed_04_02---e-med-groupidentifier-beziehen) 
    * [stornieren](Sub_UC_eMed_04.html#sub_uc_emed_04_03---geplante-abgabe-stornieren-prescription-discard)
* **ELGA-Teilnehmer** und deren Vertretungen können *Geplante Abgaben*:
    * [löschen](Sub_UC_eMed_04.html#sub_uc_emed_04_07---geplante-abgabe-löschen-durch-elga-teilnehmer-prescription-delete)
* **Automatisch** durch die **Fachanwendung** umgesetzt werden:
    * [Beenden](Sub_UC_eMed_04.html#sub_uc_emed_04_04---geplante-abgabe-beenden-durch-fachanwendung)
    * [Ablauf](Sub_UC_eMed_04.html#sub_uc_emed_04_05---geplante-abgabe-abgelaufen-durch-fachanwendung)
    * [Canceln](Sub_UC_eMed_04.html#sub_uc_emed_04_06---geplante-abgabe-storniert-durch-fachanwendung)

von *Geplanten Abgaben*.


<div class="hinweisbox">
ℹ️ Die fachlichen Anforderungen dieses Use Cases werden beschrieben in:
<ul>
    <li>
        <a href="Sub_UC_eMed_04.html">UC_eMed_04 Geplante Abgabe schreiben</a>
    </li>
</ul>
Es gelten die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert.  
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 25.09.2026 -->


### Sub_UC_eMed_04_01 - Geplante Abgabe erstellen (Prescription-Write)

Der GDA kann basierend auf der **aktuellen Version** eines bestehenden *Medikationsplaneintrags* eine oder mehrere [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) erstellen. Für jedes zu rezeptierende Arzneimittel wird eine eigene *Geplante Abgabe* erstellt, um die medizinische Inhalte des e-Rezepts zu dokumentieren. 

Falls für eine *Geplante Abgabe* noch kein Medikationsplaneintrag existiert, muss dieser zuerst erstellt werden (siehe [Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen](Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen)). 
Unter gewissen Voraussetzungen kann ein bestehender Medikationsplaneintrag angepasst werden (siehe [Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern)). Die medizinischen Inhalte von Planeintrag und *Geplanter Abgabe* (wie Arzneimittel und Dosierung) dürfen sich **nicht unterscheiden**.

Wird der zugehörige Planeintrag nach der Erstellung einer *Geplanten Abgabe* geändert, kann die *Geplante Abgabe* weiterhin gültig bleiben oder gegebenenfalls storniert werden (siehe [Sub_UC_eMed_04_03 - Geplante Abgabe stornieren ($prescription-discard)](Sub_UC_eMed_04.html#sub_uc_emed_04_03---geplante-abgabe-stornieren-prescription-discard)). 

Medikationsplaneinträge können mehrfach rezeptiert werden und daher auch zu mehreren *Geplanten Abgaben* führen. <!-- Können von einer Planeintragsversion gleichzeitig mehrere Geplante Abgaben aktiv sein? oder gilt nicht eher: Es können zu einem Planeintrag mehrere aktive *Geplante Abgaben* existieren, aber nur eine je Planeintragversion.

Die Anzahl der *Geplanten Abgaben*, die mit demselben *e-Med Groupidentifier* gespeichert werden können, ist durch das Limit für die Anzahl der Medikamente je e-Rezept begrenzt.

Der Status der *Geplanten Abgabe* bleibt solange *active*, bis die letztmögliche Einlösung erfolgt ist (siehe [Sub_UC_eMed_04_05 - Geplante Abgabe abgelaufen (durch Fachanwendung)](Sub_UC_eMed_04.html#sub_uc_emed_04_04---geplante-abgabe-beenden-durch-fachanwendung)).

<!-- TODO: man könnte festlegen, dass ein Planeintrag nur angepasst werden darf, wenn keine offenen Geplanten Abgaben dazu existieren. Sonst muss ein neuer angelegt werden. Dann wäre es schlüssig, dass Geplante Abgabe und Planeintrag gleich sein sollen.
wird laut UC aber nicht abgelehnt: "Die e-Medikation Fachanwendung lehnt eine geplante Abgabe nicht ab, wenn sich diese inhaltlich (PZN, Wirkstoff, …) vom zugeordneten Medikationsplaneintrag unterscheidet"  ??

und widerspricht dem Usecase:
"Medikationsplaneinträgen in Vorversionen des Medikationsplans können weiterhin offene geplante Abgaben bestehen"   akl 7.10. 
 -->

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und erhält von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) alle für die Erstellung der *Geplanten Abgaben* relevanten Ressourcen.

<!-- im Planeintrag steht:   TODO klären, wie das in der Geplanten Abgabe gemacht wird akl 8.10.
    - *medication*: zur Dokumentation des Arzneimittels wird die *Medication*-Ressource verwendet. Diese muss bei Medikamenten mit PZN beim Schreiben als **Logical Reference** mit **PZN und Name** angegeben werden (beim Lesen ist diese contained in der Ressource enthalten). Magistrale Zubereitungen sind immer als contained Ressource anzugeben (siehe Kapitel [Medikation](ELGA-e-Medikation-R4/output/medication.html)). -->

Basierend auf den enthaltenen Planeinträgen erstellt der GDA neue *Gelplante Abgaben* wie folgt:

* *MedicationRequest*-Ressource(n) erstellen: [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html)
    - **Geplanter Einnahmezeitraum**: (*extension:effectiveDosePeriod*): Beginn: aktuelles Datum oder Datum in der Zukunft, <!-- Gleich wie Planeintrag? TODO akl 08.10.2026 -->Ende: Datum in der Zukunft oder unbefristet. <!-- Gleich wie Planeintrag? TODO akl 08.10.2026 --> 
    - **Status** muss *active* sein (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe))
    - **Kategorie** (*category:mrcategory*): "Geplante Abgabe", zur Unterscheidung von Planeinträgen
    - [**Rezeptart**](https://termgit.elga.gv.at/ValueSet-elga-medikationrezeptart.html) (*category:recipetype*): muss verpflichtend ausgewählt werden
    - **Medikation**: muss **identisch** sein mit der des Planeintrags. Enthält der Planeintrag ausschließlich Wirkstoffe, sind diese auch in der *Geplanten Abgabe* in der gleichen Form zu dokumentieren, anderenfalls muss der Planeintrag zuvor angepasst werden (z.B. Austausch der Wirkstoffe mit einem entsprechenden Arzneimittel der ASP-Liste 
    (inkl. PZN)).
    <!-- - *subject*: [ELGA Core Patient](https://build.fhir.org/ig/HL7Austria/ELGA-Core-R4/StructureDefinition-at-elga-core-patient.html) darf **nicht geändert** werden.  -->
    <!-- TODO: prüfen wir das? akl 30.09.2026 -->
    - **Informationen zur Erstellung**: aktuelles Datum (*authoredOn*) und aktueller GDA als Ersteller (*requester*) 
    - **Referenz auf den zugrundeliegenden Planeintrag** (*basedOn*): wird **nicht versioniert**, verweist somit immer auf den aktuellen Planeintrag, auch wenn dieser zwischenzeitlich geändert wurde.
    - **Dosierung** (*dosageInstruction*): muss **identisch** sein mit der des Planeintrags.
    - **e-Med GroupIdentifier** (*groupIdentifier*): 
        - Alle zeitgleich erstellten *Geplante Abgaben*, die zum selben e-Rezept gehören, müssen den selben *e-Med Groupidentifier* tragen und **im selben [Geplante Abgaben-Transaction Bundle](StructureDefinition-at-elga-emed-bundle-geplanteabgaben-tx.html)** übermittelt werden. Der *e-Med GroupIdentifier* ermöglicht zusammengehörige *Geplante Abgaben* und *Durchgeführte Abgaben* gemeinsam abzurufen und kann über unterschiedliche Varianten bezogen werden (siehe [Sub_UC_eMed_04_02 - e-Med GroupIdentifier beziehen](Sub_UC_eMed_04.html#sub_uc_emed_04_02---e-med-groupidentifier-beziehen)). Er bleibt grundsätzlich solange gültig, solange die *Geplante Abgabe = active* ist. 
        -  Fehlt im übermittelten [Geplante Abgaben-Transaction Bundle](StructureDefinition-at-elga-emed-bundle-geplanteabgaben-tx.html) bei allen *Geplanten Abgaben* der *e-Med GroupIdentifier*, ergänzt ihn die Fachanwendung. 
    - **Gültigkeitszeitraum zur Einlösung** (*dispenseRequest.validityPeriod*) und 
    - **Anzahl möglicher weiterer Einlösungen** (*dispenseRequest.numberOfRepeatsAllowed*) sind abhängig von der ausgewählten Rezeptart (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart))
    - **Bereitzustellende Menge** (*dispenseRequest.quantity*): Verpflichtende Angabe der Menge (Anzahl Packungen), die bei jeder Abgabe bereitgestellt werden soll.

Alle zusammengehörenden, erstellten *Geplanten Abgaben* werden in einem eigenen [Geplante Abgaben-Transaction Bundle](StructureDefinition-at-elga-emed-bundle-geplanteabgaben-tx.html) mittels **POST** [$prescription-write](Sub_UC_eMed_04.html#custom-operations) an die Fachanwendung übermittelt. 
<!-- Todo: link auf $prescription-write sobald operation fertig  akl 8.10. -->


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    effectiveDosePeriod: Einnahmezeitraum
    status: active 
    category[mrcategory]: 2 "Geplante Abgabe"               //Kategorie zur Unterscheidung der MedicationRequests
    category[recipetype]: KASSEN | PRIVAT | SUBST          // Verpflichtende Angabe der Rezeptart
    medicationReference.reference: Medikation gemäß Planeintrag // Contained Medication
    authoredOn: Datum der Erstellung der Geplanten Abgabe
    requester: veranwortlicher GDA 
    basedOn: id des zugehörigen Medikationsplaneintrags     // referenziert aktuelle Version 
    groupIdentifier: e-Med GroupIdentifier                  // optionale Rezeptklammer 
    dosageInstruction: gemäß Planeintrag 
    dispenseRequest.validityPeriod: Gültigkeitszeitraum     // abhängig von Rezeptart 
    dispenseRequest.numberOfRepeatsAllowed: Anzahl weiterer Einlösungen // abhängig von Rezeptart
    dispenseRequest.quantity: Abzugebende Menge (Packungen) je Abgabe
```

##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$prescription-write: in Arbeit.
</p>
</div>


<!-- #### Ablauf und Bezug e-Med GroupIdentifier -->

### Sub_UC_eMed_04_02 - e-Med GroupIdentifier beziehen

Der Ablauf zur Erstellung von *Geplanten Abgaben* und der Bezug des *e-Med GroupIdentifiers* kann unterschiedlich erfolgen. Exemplarisch werden drei Varianten angeführt.

##### Variante A: Vorab-Ermittlung des e-Med GroupIdentifiers (GroupIdentifier-Create)

Der *e-Med GroupIdentifier* ("Rezeptklammer") wird via **POST** *$groupidentifier-create* <!-- Todo link akl 8.10 --> vorab von der Fachanwendung bezogen, in den *Geplanten Abgaben* ergänzt und zur Erstellung des e-Rezepts an die e-Rezept-Anwendung mitgegeben, um dieses mit den *Geplanten Abgaben* zu verknüpfen.
Der Trigger zu Erstellung des e-Rezepts und [Prescription-Write](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write) können parallel erfolgen (siehe Normalfall). 

Liefert e-Rezept einen Fehler zurück, können mittels POST *$prescription-discard* bereits in der e-Medikation erstellte *Geplante Abgaben* verworfen werden (siehe [Sub_UC_eMed_04_03 - Geplante Abgabe stornieren ($prescription-discard)](Sub_UC_eMed_04.html#sub_uc_emed_04_03---geplante-abgabe-stornieren-prescription-discard)).
Liefert die e-Medikation Fachanwendung einen Fehler zurück, kann nach Fehlerkorrektur erneut ein *Prescription-Write* erfolgen oder ein bereits durch den *e-Med groupIdentifer* verknüpftes e-Rezept wieder von den *Geplanten Abgaben* "entkoppelt" werden (siehe [Variante A: Fehlerfall](Sub_UC_eMed_04.html#variante-a-fehlerfall)).


###### Variante A: Normalfall

[![overview](plantuml/UC_eMed_04_01_a_normal.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_a_normal.svg)

<br>


###### Variante A: Fehlerfall

[![overview](plantuml/UC_eMed_04_01_a_fehler.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_a_fehler.svg)

<br>

##### Variante B: Sequentielles Erstellen von Geplanter Abgabe und e-Rezept 

Alternativ kann der *e-Med GroupIdentifier* durch die Fachanwendung automatisch ergänzt werden, wenn dieser beim *Prescription-Write* nicht in den *Geplanten Abgaben* im Transaction Bundle enthalten ist. Dadurch bleibt das Verhalten konsistent zur bestehenden e-Medikations-Implementierung.
Hierfür müssen die *Geplanten Abgaben*, die zu einem e-Rezept gehören, gemeinsam in einem [Geplante Abgaben-Transaction Bundle](StructureDefinition-at-elga-emed-bundle-geplanteabgaben-tx.html) mit mittels **POST** [$prescription-write](Sub_UC_eMed_04.html#custom-operations) an die e-Medikation Fachanwendung übermittelt werden. Der Server ergänzt den *e-Med GroupIdentifier* während der Transaktionsverarbeitung und gibt die persistierten Ressourcen einschließlich des erzeugten *e-Med GroupIdentifiers* in der Response an den Client zurückgegeben.
Im Anschluss kann der Trigger zur Erstellung des e-Rezepts inkl. *e-Med GroupIdentifier* erfolgen.

[![overview](plantuml/UC_eMed_04_01_b.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_b.svg)

<br>

##### Variante C: Nachträgliche Verknüpfung des e-Rezepts mit dem e-Med GroupIdentifier

Der Trigger zu Erstellung des e-Rezepts und [Prescription-Write](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write) können parallel erfolgen (Variante A), allerdings noch ohne *e-Med GroupIdentifier*.
Die e-Medikation Fachanwendung ergänzt diesen und liefert ihn an den Client zurück (wie in Variante B), der Client führt im Anschluss eine nachträgliche Verknüfung des bereits erstellten e-Rezepts mit den *Geplanten Abgaben* mittels *e-Med GroupIdentifier* durch.

<br>

[![overview](plantuml/UC_eMed_04_01_c.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_04_01_c.svg)

<br>

##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$groupidentifier-create: in Arbeit.
</p>
</div>


### Sub_UC_eMed_04_03 - Geplante Abgabe stornieren (Prescription-Discard)

Ein GDA kann eine **selbsterfasste** [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) aufgrund eines Fehlers innerhalt von 30 Tagen stornieren, solange noch **keine** Abgabe durchgeführt (dh. noch keine zugehörige *Durchgeführte Abgabe* erstellt) wurde. 
* Ausnahme: Alle zugehörigen *Durchgeführten Abgaben* werden zuvor storniert

Wird ein e-Rezept storniert, werden die zugehörigen geplanten Abgaben in der e-Medikation automatisch mitstorniert.
<!-- Die stornierte *Geplante Abgabe* kann über die Historie der *Geplanten Abgaben* eingesehen werden.: entfernt: stornierte Geplante Abgaben sind wie alle anderen Geplanten Abgaben via GET auf MedicationRequest mit der Kategorie Geplante Abgabe status entered-in-error abrufbar.  -->

#### Ablauf

Um eine *Geplante Abgabe* zu stornieren, führt der GDA POST [$prescription-discard​](Sub_UC_eMed_04.html#custom-operations-2) aus und bearbeitet die *MedicationRequest*-Ressource(n) wie folgt: [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) 
- **Status** wird auf ***entered-in-error*** gesetzt (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)),
- **Informationen zur Erstellung**: das Datum in *authoredOn* wird aktualisiert.

<!-- TODO: Wenn stornierte *Geplante Abgabe* Teil eines e-Rezepts mit weiteren geplanten Abgaben ist: Auswirkungen? keine -->

#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: entered-in-error 
    authoredOn: Datum des Verwerfens der Geplanten Abgabe
    requester: veranwortlicher GDA  // bleibt unverändert
```
##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$prescription-discard: in Arbeit.
</p>
</div>


### Sub_UC_eMed_04_04 - Geplante Abgabe beenden (durch Fachanwendung)

Wurden alle möglichen Einlösungen einer *Geplanten Abgabe* planmäßig durchgeführt und entsprechende *Durchgeführte Abgaben* erstellt (siehe [Sub_UC_eMed_05_01 - Durchgeführte Abgabe erfassen](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-erfassen)), setzt die Fachanwendung die *Geplante Abgabe* **automatisch** auf den Status ***completed*** (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)). Die *Geplante Abgabe* ist damit abgeschlossen.

**Sonderfall**: Wird die letzte *Durchgeführte Abgabe* im Anschluss verworfen (Status *entered-in-error*), wird der Status der *Geplanten Abgabe* durch die Fachanwendung wieder auf *active* gesetzt.

Die Fachanwendung erkennt anhand von *MedicationRequest.numberOfRepeatsAllowed > 0*, ob weitere Einlösungen erlaubt sind (z.B. bei einem Privatrezept). Je möglicher Einlösung muss mindestens eine *Durchgeführte Abgabe* erstellt werden (bei Teilabgaben können es mehrere sein). Eine Einlösung gilt als vollständig, wenn MedicationDispense.type den Wert *FFC (First Fill – Complete)* oder *PFC (Part Fill - Complete)* enthält.


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

### Sub_UC_eMed_04_05 - Geplante Abgabe abgelaufen (durch Fachanwendung)

Ist der Gültigkeitszeitraum in *dispenseRequest.validityPeriod* der *Geplanten Abgabe* gemäß der ausgewählten Rezeptart (category:recipetype) (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart)) oder den Einschränkungen des GDAs überschritten, setzt die Fachanwendung die *Geplante Abgabe* **automatisch** auf den Status ***stopped*** (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)). Die *Geplante Abgabe* ist damit abgeschlossen.


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: stopped
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```

### Sub_UC_eMed_04_06 - Geplante Abgabe storniert (durch Fachanwendung) 

Eine *Geplante Abgabe* wird **automatisch** storniert (erhält den Status *cancelled* (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe))), wenn **alle** *Durchgeführten Abgaben* (jede Einlösung) den Status ***cancelled*** erhalten haben. Die *Geplanten Abgabe* ist damit abgeschlossen.

Sonderfall: Wird die letzte *Durchgeführte Abgabe* im Anschluss verworfen (Status *entered-in-error*), wird der Status der *Geplanten Abgabe* durch die Fachanwendung wieder auf *active* gesetzt.


#### Relevante Elemente (MedicationRequest)

```JSON
AtElgaEmedMedicationRequestGeplanteAbgabe
    status: cancelled
    authoredOn: Datum der Erstellung der geplanten Abgabe  // bleibt unverändert
    requester: Ursprünglicher Ersteller                    // bleibt unverändert
```


### Sub_UC_eMed_04_07 - Geplante Abgabe löschen (durch ELGA-Teilnehmer) (Prescription-Delete)

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Umsetzung der Teilnehmerrechte: in Arbeit.
</p>
</div>

<br>
<!-- Der ELGA-Teilnehmer kann eine *Geplante Abgabe* endgültig löschen. Bereits dokumentierte zugehörige *Durchgeführte Abgaben* sowie bestehende Planeinträge bleiben davon unberührt.-->

<!-- Die Löschung der *Geplanten Abgabe* umfasst:

- die fachliche Entfernung der betreffenden MedicationRequest-Ressource sowie
- die Entfernung aller zugehörigen historischen Ressourcen-Versionen (_history).

Zum Löschen einer *Geplanten Abgabe* ruft der ELGA-Teilnehmer diese im Zugangsportal auf. Dieses führt zunächst eine Leseoperation auf die betreffende MedicationRequest-Ressource aus (GET MedicationRequest/[id]) und löscht anschließend die betreffende *Geplante Abgabe* mittels DELETE (DELETE [base]/MedicationRequest/[id]).

Die Ressource einschließlich aller historischen Versionen darf nach erfolgreicher Löschung weder über reguläre FHIR-Interaktionen noch über administrative Schnittstellen abrufbar sein.
<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Referenzen auf gelöschte Ressourcen (z.B. von bestehenden Durchgefürhte Abgaben auf gelöschte Geplante Abgaben) können nicht mehr aufgelöst werden.
</p>
</div> -->


<!-- #### Beispiel -->

<!-- #### Technische Hinweise -->

<!-- #### Relevante Profile -->

<!-- #### Relevante Invarianten -->

<!-- #### Mögliche Notifications -->




