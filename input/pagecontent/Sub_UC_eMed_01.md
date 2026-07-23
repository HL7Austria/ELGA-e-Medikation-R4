{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann den Medikationsplan von ELGA-Teilnehmer:innen lesen.

Ein:e ELGA-Teilnehmer:in kann seinen:ihren Medikationsplan über das Zugangsportal einsehen.

Die fachlichen Anforderungen werden im [UC_eMed_01 Medikationsplan lesen](Sub_UC_eMed_01.hml) beschrieben.

Für den lesenden Zugriff werden zwei Zugriffsarten unterschieden:

* [Plan-Read](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read) zum Abruf des aktuellen Medikationsplans, der für eine mögliche Bearbeitung aufbereitet ist. 

* [Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search) zum Abruf historischer Versionen des Medikationsplans. 


#### Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)

Plan-Read dient dem **Abruf des Medikationsplans** in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Hierfür erzeugt die Fachanwendung aus der aktuellen Version der *List*-Ressource sowie den von ihr referenzierten Ressourcen ein temporäres **Collection-Bundle** zur Auslieferung. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

##### Custom Operation

POST [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html)

##### Ablauf

1. Der Client führt einen **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft den Zustand des Medikationsplans und erzeugt daraus ein Collection-Bundle zur Auslieferung (siehe [Prüfung des Planzustands und Erzeugung des Collection-Bundles](Sub_UC_eMed_01.html#prüfung-des-planzustands-und-erzeugung-des-collection-bundles)).
3. Die Fachanwendung liefert das Collection-Bundle zurück. Dieses enthält:
   * die *List*-Ressource,
   * sämtliche von der *List* referenzierten Ressourcen sowie
   * im HTTP-Header den *ETag* der aktuellen Version der *List*-Ressource für das [Optimistic Locking](https://hl7.org/fhir/http.html#concurrency).

Nachfolgend kann der Medikationsplan vom GDA bearbeitet und mittels [Plan-Write](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write) gespeichert werden.


##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_01.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_01.svg)
<br> 


##### Prüfung des Planzustands und Erzeugung des Collection Bundles

Nach Eingang eines **$plan-read** prüft die Fachanwendung den Zustand des Medikationsplans.

Dabei werden folgende Fälle unterschieden:

1. **Es existiert kein Medikationsplan.**
   * Es wird gemäß [Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan](Sub_UC_eMed_01.html#Sub_UC_eMed_01_03---initial-erstellter-medikationsplan) ein initialer Medikationsplan erstellt (*List.emptyReason = notstarted*).

2. **Es existiert ein Medikationsplan mit Planeinträgen.**
   * Neue oder geänderte Planeinträge (*List.entry.flag = new* oder *changed*) werden auf *unchanged* gesetzt.
   * Planeinträge mit *List.entry.flag = removed* werden aus dem Medikationsplan entfernt.
   * Planeinträge mit abgelaufenem Behandlungszeitraum werden mit *List.entry.flag = removed* gekennzeichnet, bleiben jedoch im Medikationsplan enthalten.
   * Sind nach der Transformation keine Planeinträge mehr vorhanden, wird *List.emptyReason = nilknown* gesetzt.

3. **Es existiert ein leerer Medikationsplan** (*List.emptyReason = notstarted* oder *nilknown*).
   * Es erfolgt keine Transformation.

Abschließend erzeugt die Fachanwendung aus der aktuellen Version der *List*-Ressource und den referenzierten Ressourcenversionen ein Collection-Bundle zur Auslieferung.

Die persistierten Ressourcen werden dabei nicht verändert.


##### Aktivitätsdiagramm

<br>
[![overview](plantuml/UC_eMed_01_01_plancheck.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_01_plancheck.svg)
<br> 



#### Sub_UC_eMed_01_02 - Historische Medikationsplanversion lesen (Plan-History-Search)

Beim Plan-History-Search rekonstruiert die Fachanwendung historische Versionen des Medikationsplans aus versionierten List-Ressourcen sowie den von diesen referenzierten Ressourcenversionen und liefert diese unverändert aus. Dadurch entspricht jedes ausgelieferte Collection Bundle exakt dem historischen Stand des Medikationsplans zum jeweiligen Zeitpunkt.

Der Abruf erfolgt mittels **GET** unter Angabe geeigneter Suchparameter.

Die erzeugten Collection Bundles dienen ausschließlich der Auslieferung und werden nicht persistiert.

##### Ablauf

1. Der Client führt ein GET auf */Patient/{id}/List/_history* mit den gewünschten Suchparametern aus.
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden historischen Versionen der List-Ressource.
3. Für jede gefundene List-Version rekonstruiert die Fachanwendung den historischen Medikationsplan, indem sie die zugehörigen historischen Versionen der referenzierten Ressourcen ermittelt, und erzeugt daraus ein Collection Bundle.
4. Die Fachanwendung liefert ein Bundle vom Typ *searchset* zurück, das alle erzeugten Collection Bundles enthält.
5. Werden keine passenden historischen Medikationsplanversionen gefunden, enthält das zurückgelieferte *searchset* keine Einträge.
6. Im Fehlerfall wird ein entsprechendes *OperationOutcome* zurückgegeben.

Beim Plan-History-Search erfolgt **keine Änderung** der Medikationspläne durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert.

Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage persistierter Medikationsplanversionen.


##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_02.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_02.svg)
<br> 


###### Beispiele für Zugriffe
In Arbeit.
<!-- * **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH} -->
<!-- * **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH} -->
<!-- * Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum persistiert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind: GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed  -->
<!-- list.code= 736378000 in Abfragen ergänzen -->


<!-- * Aktuelle Medikationsplanversion lesen:
GET [base]/Patient/{id}/List -->

<!-- * Historische Versionen eines Medikationsplans lesen:
GET [base]/Patient/{id}/List/_history -->

<!-- * Historische Medikationsplanversionen lesen, die ab einem bestimmten Datum erstellt wurden:
GET [base]/Patient/{id}/List/_history?date=ge2025-01-01 -->

<!-- * Historische Medikationsplanversionen lesen, die einen bestimmten Planeintrag enthalten:
GET [base]/Patient/{id}/List/_history?_include=*&item=MedicationRequest/{id} -->

<!-- * Historische Medikationsplanversionen lesen, die nach einem bestimmten Datum erstellt wurden und einen bestimmten Planeintrag enthalten:
GET [base]/Patient/{id}/List/_history?_include=*&item=MedicationRequest/{id}&date=ge2025-01-01 -->


#### Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan

Die initiale Erstellung eines Medikationsplans erfolgt ausschließlich durch die e-Medikation-Fachanwendung. Sie wird ausgelöst, wenn im Rahmen eines erstmaligen Aufrufs von [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) noch kein Medikationsplan für den ELGA-Teilnehmer existiert.

Der dabei erzeugte initiale Medikationsplan besitzt den Wert *List.emptyReason = notstarted*. Dieser kennzeichnet ausschließlich den **Initialzustand** des Medikationsplans und bedeutet, dass bisher noch keine Medikationsplaneinträge erfasst wurden. Er trifft jedoch keine Aussage darüber, ob der Patient Medikamente einnimmt.

Die Initialisierung kann sowohl durch ein GDA-System als auch durch den ELGA-Teilnehmer über das Portal ausgelöst werden, indem erstmals ein **Plan-Read** durchgeführt wird.


##### Ablauf 

1. Ein Client führt für einen ELGA-Teilnehmer erstmalig ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan für den Patienten existiert.
3. Existiert noch kein Medikationsplan, erstellt die Fachanwendung initial eine List-Ressource mit *emptyReason = notstarted*.
4. Die List-Ressource wird als erste Version persistiert.
5. Für das Plan-Read erzeugt die Fachanwendung daraus ein temporäres Collection-Bundle zur Auslieferung.
6. Dieses wird mit *List.emptyReason = notstarted* sowie dem zugehörigen ETag an den Client zurückgeliefert.

##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_03.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_03.svg)
<br> 

##### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    identifier: von der Fachanwendung übermittelt (Integritätsprüfung) 
    status: current
    mode: working
    date: Datum der Erstellung durch die Fachanwendung
    source: Intitiale Erstellung durch die Fachanwendung
    emptyReason: notstarted    // noch keine Medikationsplaneinträge erfasst
```




<!-- #### Sub_UC_eMed_01_04 - Medikationsplaneinträge abrufen (Plan-Read) -->

<!-- TODO: eigene Site weil ander Endpunkt? -->

<!-- GET	/Patient/{id}/MedicationRequest	planentry-search	Medikationsplaneinträge suchen (?category=Planeintrag)	GDA, PAT

Filtermöglichkeit nach:
o	Nur „aktive“ und “pausierte” Medikationsplaneinträge (Status: active bzw. on-hold) -->
