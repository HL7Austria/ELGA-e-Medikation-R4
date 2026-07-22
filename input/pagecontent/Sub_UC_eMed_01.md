{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann den Medikationsplan von ELGA-Teilnehmer:innen lesen.

Ein:e ELGA-Teilnehmer:in kann seinen:ihren Medikationsplan über das Zugangsportal einsehen.

Die fachlichen Anforderungen werden im [UC_eMed_01 Medikationsplan lesen](Sub_UC_eMed_01.hml) beschrieben.

Für den lesenden Zugriff werden zwei Zugriffsarten unterschieden:

* **Plan-Read** zum Abruf des aktuellen Medikationsplans. Die Fachanwendung erzeugt hierfür aus den aktuell gültigen Ressourcen (insbesondere der aktuellen Version der List-Ressource sowie den referenzierten Ressourcen) ein temporäres Medikationsplan-Collection-Bundle. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

* **Plan-History-Read** zum Abruf einer historischen Version des Medikationsplans. Hierbei wird ein Collection Bundle aus einer historischen Version der List-Ressource sowie den jeweils referenzierten Ressourcenversionen rekonstruiert.


#### Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)

Plan-Read dient dem **Abruf des Medikationsplans** in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Hierfür erzeugt die Fachanwendung aus der aktuellen Version der *List*-Ressource sowie den von ihr referenzierten Ressourcen ein **Medikationsplan-Collection-Bundle** zur Auslieferung. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

##### Ablauf

1. Der Client führt einen **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft den Zustand des Medikationsplans und erzeugt daraus ein Collection-Bundle zur Auslieferung (siehe **Prüfung des Planzustands und Erzeugung des Collection-Bundles**).
3. Die Fachanwendung liefert das Collection-Bundle zurück. Dieses enthält:
   * die *List*-Ressource,
   * sämtliche von der *List* referenzierten Ressourcen sowie
   * im HTTP-Header den *ETag* der aktuellen Version der *List*-Ressource für das [Optimistic Locking](https://hl7.org/fhir/http.html#concurrency).

Nachfolgend kann der Medikationsplan vom GDA bearbeitet und mittels Plan-Write gespeichert werden.


##### Sequenzdiagramm (Plan-Read)

<div>{% include_relative plantuml/UC_eMed_01_01.svg %}</div>
<br>


##### Ablauf innerhalb der Fachanwendung

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



##### Prüfung des Planzustands und Erzeugung des Collection-Bundles

<div>{% include_relative plantuml/UC_eMed_01_01_plancheck.svg %}</div>



##### Custom Operation

POST [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html)



#### Sub_UC_eMed_01_02 - Historische Medikationsplanversion lesen (Plan-History-Read)

Beim Plan-History-Read rekonstruiert die Fachanwendung eine historische Version des Medikationsplans aus einer versionierten List-Ressource sowie den von dieser referenzierten historischen Ressourcenversionen. Dadurch entspricht das ausgelieferte Bundle exakt dem historischen Stand des Medikationsplans zum jeweiligen Zeitpunkt.

Das erzeugte Collection Bundle dient ausschließlich der Auslieferung und wird nicht persistiert.


##### Ablauf

1. Der Client führt einen **POST** $plan-history-read aus.
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden historischen Versionen der List-Ressource.
<!-- TODO: * Suchparameter definieren -->
3. Für jede gefundene List-Version erzeugt die Fachanwendung ein Collection Bundle. Dieses enthält:
* die historische Version der List-Ressource
* sämtliche von dieser List-Version referenzierten historischen Ressourcenversionen
4. Existiert keine passende List-Version, wird ein leeres Bundle (type=searchset) zurückgegeben.
5. Im Fehlerfall erfolgt eine entsprechende Meldung an den Client.

Beim Plan-History-Read erfolgt **keine Änderung** der Medikationspläne durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert.
<br>
Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage persistierter Medikationsplanversionen.

##### Operation

«GET» plan-history-search

##### Sequenzdiagramm

<div>{% include_relative plantuml/UC_eMed_01_02.svg %}</div>
<br>


###### Beispiele für Zugriffe
In Arbeit
 <!--TODO: wenn plan-history-read eine Operation bleibt stimmt dieser Teil nicht mehr -> dann würden Operation IN Parameter zum Einsatz kommen
* **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH}
* **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH}
* Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum persistiert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind: GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed 
-->
<!-- list.code= 736378000 in Abfragen ergänzen -->


#### Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan

Die initiale Erstellung eines Medikationsplans erfolgt ausschließlich durch die e-Medikation-Fachanwendung. Sie wird ausgelöst, wenn im Rahmen eines erstmaligen Aufrufs von [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) noch kein Medikationsplan für den ELGA-Teilnehmer existiert.

Der dabei erzeugte initiale Medikationsplan besitzt den Wert *List.emptyReason = notstarted*. Dieser kennzeichnet ausschließlich den **Initialzustand** des Medikationsplans. Er bedeutet, dass bisher noch keine Medikationsplaneinträge erfasst wurden, trifft jedoch keine Aussage darüber, ob der Patient Medikamente einnimmt.

Die Initialisierung kann sowohl durch ein GDA-System als auch durch den ELGA-Teilnehmer über das Portal ausgelöst werden, indem erstmals ein *$plan-read* aufgerufen wird.


##### Ablauf

1. Ein Client führt für einen ELGA-Teilnehmer erstmalig ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan für den Patienten existiert.
3. Existiert noch kein Medikationsplan, erstellt die Fachanwendung initial eine List-Ressource mit `emptyReason = notstarted`.
4. Die erzeugten Ressourcen werden persistiert.
5. Für das Plan-Read erzeugt die Fachanwendung daraus ein temporäres Auslieferungs-Medikationsplan-Collection-Bundle.
6. Dieses wird mit demselben *List.emptyReason = notstarted* sowie dem zugehörigen ETag an den Client zurückgeliefert.


##### Sequenzdiagramm

<div>{% include_relative plantuml/UC_eMed_01_03.svg %}</div>


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
