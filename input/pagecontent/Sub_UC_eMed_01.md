{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann den Medikationsplan von ELGA-Teilnehmer:innen lesen.

Ein:e ELGA-Teilnehmer:in kann seinen:ihren Medikationsplan über das Zugangsportal einsehen.

Sowohl berechtigte GDA als auch ELGA-Teilnehmer können auf einzelne Planeinträge lesend zugreifen und diese durchsuchen ([Planentry-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_04---medikationsplaneinträge-lesen-planentry-search)).

Die fachlichen Anforderungen werden im [UC_eMed_01 Medikationsplan lesen](Sub_UC_eMed_01.hml) beschrieben.

Für den lesenden Zugriff auf Medikationspläne werden zwei Zugriffsarten unterschieden:

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

Der Abruf erfolgt mittels **GET** unter Angabe geeigneter Suchparameter:
* **Erstellungszeitraum** von Medikationsplanversionen
* **Medikation** im Medikationsplan (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum** einer Medikation im Medikationsplan
<!-- TODO: ergänzen: * id + Version eines enthaltenen Planeintrags ! Damit man von Planeintrag auf die referenzierenden Planversionen kommt -->
<!-- TODO: weitere-parameter -->

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


###### Beispiele für Suchanfragen
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


#### Sub_UC_eMed_01_04 - Medikationsplaneinträge lesen (Planentry-Search)

Der **Planentry-Search** dient der gezielten Suche nach Medikationsplaneinträgen eines ELGA-Teilnehmers. Als Medikationsplaneintrag gilt eine im Medikationsplan referenzierte Version einer *MedicationRequest*-Ressource mit *category = "Planeintrag"*.

Die Suche ermöglicht berechtigten GDA sowie ELGA-Teilnehmer:innen den Zugriff auf aktuelle und historische Medikationsplaneinträge unabhängig von einer bestimmten Medikationsplanversion.

Der Abruf erfolgt mittels **GET** unter Angabe geeigneter Suchparameter:

* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum**
* **Erstellungszeitpunkt**
* **Status** des Medikationsplaneintrags (z.B. *active* oder *on-hold*)
<!-- TODO: search-parameter -->

Die Suchergebnisse ermöglichen die Nachverfolgung von Änderungen an Medikationsplaneinträgen, beispielsweise hinsichtlich Präparat, Dosierung oder Einnahmeanweisung.

Die gefundenen Medikationsplaneinträge können anschließend als Ausgangspunkt für weitere Abfragen verwendet werden, um jene Ressourcen zu ermittelnt, die genau auf diese Planeintragversion referenzieren:

* der zugehörigen Medikationsplanversionen mittels [Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search)
* *Geplante Abgaben* (*Prescription-Search*) <!-- TODO Link -->
* *Durchgeführte Abgaben* (*Dispense-Search*) <!-- TODO Link -->


##### Ablauf

1. Der Client führt ein **GET** auf den Planentry-Search-Endpunkt mit den gewünschten Suchparametern aus (*MedicationRequest* mit *category = "Planeintrag"*).
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden Medikationsplaneinträge.
4. Die Fachanwendung liefert die Suchergebnisse als Bundle vom Typ *searchset* zurück.
6. Werden keine passenden Medikationsplaneinträge gefunden, enthält das zurückgelieferte *searchset* keine Einträge.
7. Im Fehlerfall wird ein entsprechendes *OperationOutcome* zurückgegeben.

##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_04.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_04.svg)
<br> 

##### Beispiele für Suchanfragen

In Arbeit. 
<!-- * Alle aktiven Medikationsplaneinträge eines Patienten:
  `GET /Patient/{id}/MedicationRequest?status=active` -->

<!-- * Medikationsplaneinträge zu einem bestimmten Arzneimittel:
  `GET /Patient/{id}/MedicationRequest?medication=<PZN>` -->

<!-- * Medikationsplaneinträge innerhalb eines Erstellungszeitraums:
  `GET /Patient/{id}/MedicationRequest?authoredon=ge2026-01-01&authoredon=le2026-12-31` -->
<!-- 
* Historische und aktuelle Medikationsplaneinträge eines bestimmten Wirkstoffs:
  `GET /Patient/{id}/MedicationRequest?ingredient=<Wirkstoff>` -->

