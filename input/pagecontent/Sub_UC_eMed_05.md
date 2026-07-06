{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan schreiben (UC_eMed_06) -->

#### Sub_UC_eMed_06_01 - Medikationsplan lesen

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann den Medikationsplan eines ELGA-Teilnehmers lesen.

Ein ELGA-Teilnehmer kann seinen Medikationsplan über das Zugangsportal einsehen.

Für den lesenden Zugriff werden zwei Zugriffsarten unterschieden:

* **Plan-History-Read** zum Abruf der aktuellen oder historischer Versionen eines persistierten Medikationsplans.
* **Plan-Read** zum Abruf eines für die nachfolgende Bearbeitung aufbereiteten Medikationsplans. Hierfür wird die Custom Operation [$plan-read](OperationDefinition-AtEmed.List.Planread.html) verwendet.

#### Plan-History-Read 

Beim Plan-History-Read stellt die Fachanwendung das **aktuelle oder historische** [persistierte Medikationsplan-Collection-Bundle](design_choices.html#persistiertes-medikationsplan-collection-bundle) einschließlich aller referenzierten Ressourcen **unverändert** bereit.

##### Ablauf

1. Der GDA führt ein **GET** auf das [persistierte Medikationsplan-Collection-Bundle](design_choices.html#persistiertes-medikationsplan-collection-bundle) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan existiert.
3. Existiert **kein Medikationsplan**, wird ein **leeres Ergebnis** zurückgegeben.
4. Existiert ein Medikationsplan, wird das zuletzt persistierte Medikationsplan-Collection-Bundle zurückgeliefert.<br>
Das **Collection Bundle** enthält:<br>
* die List-Ressource des Medikationsplans <br>
* alle referenzierten Ressourcen vollständig (inline).

Beim Plan-History-Read erfolgt **keine Änderung** am Medikationsplan durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert.
<br>
Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage von aktuellen bzw. historischen Planversionen.

##### Sequenzdiagramm Plan-History-Read
<br>
<div>{% include_relative plantuml/interaction_planhistoryread.svg %}</div>
<br>

<!-- **Beispiele für Zugriffe mittels Suchparameter:**
* **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH}
* **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH}
* Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum gespeichert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind: GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed -->

<!-- list.code= 736378000 in Abfragen ergänzen -->


#### Plan-Read

Plan-Read dient dem **Abruf eines Medikationsplans** in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Die Operation wird über die Custom Operation [$plan-read](OperationDefinition-AtEmed.List.Planread.html) ausgeführt.

##### Ablauf

1. Der Client führt einen **POST** [$plan-read](OperationDefinition-AtEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan für den Patienten existiert.
3. Existiert **kein Medikationsplan**, wird dieser gemäß [Sub_UC_06_01 - Initial erstellter Medikationsplan](Sub_UC_eMed_06.html#sub_uc_06_01---initial-erstellter-medikationsplan) initial erstellt und 
4. es wird ein leerer Medikationsplan mit *List.emptyReason = notstarted* zurückgeliefert.
5. Existiert bereits ein [persistiertes Medikationsplan-Collection-Bundle](design_choices.html#persistiertes-medikationsplan-collection-bundle), erzeugt die Fachanwendung daraus ein [Auslieferungs-Medikationsplan-Collection-Bundle](design_choices.html#auslieferungs-medikationsplan-collection-bundle). Dabei werden folgende Transformationen durchgeführt:<br>
* *List.entry.flag = new* und *changed* werden auf *unchanged* gesetzt.
* Einträge mit *List.entry.flag = removed* werden aus der *List.entry* entfernt.
* Wurden sämtliche Einträge entfernt, wird *List.emptyReason = nilknown* gesetzt.
* Einträge mit beendetem Behandlungszeitraum bleiben erhalten.
<!-- * fachlich zu prüfen (TODO): Einträge mit abgelaufenem Behandlungszeitraum und courseOfTherapyType **acute** automatisch entfernen -->
6. Die Fachanwendung liefert das [Auslieferungs-Medikationsplan-Collection-Bundle](design_choices.html#auslieferungs-medikationsplan-collection-bundle) zurück. Dieses enthält:<br>
* den HTTP *ETag* für [Optimistic Locking](https://hl7.org/fhir/http.html#concurrency)
* die *List*-Ressource 
* sämtliche referenzierten Ressourcen vollständig (inline).<br>
7. Der GDA bearbeitet den zurückgegebenen Medikationsplan.

##### Custom Operations

[$plan-read](OperationDefinition-AtEmed.List.Planread.html)


##### Sequenzdiagramm Plan-Read
<br>
<div>{% include_relative plantuml/interaction_planread.svg %}</div>
<br>