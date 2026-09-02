{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann den Medikationsplan von ELGA-Teilnehmer:innen lesen.

Ein ELGA-Teilnehmer kann seinen Medikationsplan über das Zugangsportal einsehen.

Die fachlichen Anforderungen werden im [UC_eMed_01 Medikationsplan lesen](Sub_UC_eMed_01.hml) beschrieben.

Für den lesenden Zugriff auf Medikationspläne werden zwei Zugriffsarten unterschieden:

* [Plan-Read](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read) zum Abruf des aktuellen Medikationsplans, der für eine mögliche Bearbeitung aufbereitet ist. 

* [Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search) zum Abruf historischer Versionen des Medikationsplans. 


Sowohl berechtigte GDA als auch ELGA-Teilnehmer können auf einzelne Planeinträge lesend zugreifen und diese durchsuchen ([Planentry-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_04---medikationsplaneinträge-lesen-planentry-search)).


#### Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)

Plan-Read dient dem **Abruf des Medikationsplans** in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Hierfür erzeugt die Fachanwendung aus der aktuellen Version der [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource sowie den von ihr referenzierten Ressourcen ein temporäres [Medikationsplan-Searchset-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) zur Auslieferung. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

<!-- TODO: Wird ein Medikationsplan-Searchset-Bundle oder ein Searchset erzeugt? -->

##### Custom Operation

POST [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html)

##### Ablauf

1. Der Client führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft den Zustand des Medikationsplans und erzeugt daraus ein Medikationsplan-Searchset-Bundle zur Auslieferung (siehe [Prüfung des Planzustands und Erzeugung des Medikationsplan-Searchset-Bundles](Sub_UC_eMed_01.html#prüfung-des-planzustands-und-erzeugung-des-Medikationsplan-Searchset-Bundles)).
3. Die Fachanwendung liefert das Medikationsplan-Searchset-Bundle zurück. Dieses enthält:
   * die [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource,
   * sämtliche von der *List* referenzierten Ressourcen sowie
   * im HTTP-Header den *ETag* der aktuellen Version der *List*-Ressource für das [Optimistic Locking](https://hl7.org/fhir/http.html#concurrency).

Nachfolgend kann der Medikationsplan vom GDA bearbeitet und mittels [Plan-Write](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write) gespeichert werden.


##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_01.svg){: .mx-auto style="width:40%;"}](plantuml/UC_eMed_01_01.svg)
<br> 

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Fehlercodes sind noch zu definieren.
</p>
</div>

##### Prüfung des Planzustands und Erzeugung des Medikationsplan-Searchset-Bundles

Nach Eingang eines **$plan-read** prüft die Fachanwendung den Zustand des Medikationsplans.

Abschließend erzeugt die Fachanwendung aus der aktuellen Version der *List*-Ressource und den referenzierten Ressourcenversionen das Medikationsplan-Searchset-Bundle zur Auslieferung. Die persistierten Ressourcen am Server werden durch die Anpassungen im Auslieferungs-Bundle nicht verändert.

Dabei werden folgende Fälle unterschieden:

1. **Es existiert kein Medikationsplan.**
   * Es wird gemäß [Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan](Sub_UC_eMed_01.html#Sub_UC_eMed_01_03---initial-erstellter-medikationsplan) ein initialer Medikationsplan erstellt (*List.emptyReason = notstarted*).

2. **Es existiert ein Medikationsplan mit Planeinträgen.**
   * Neue oder geänderte Planeinträge (*List.entry.flag = new* oder *changed*) werden auf *unchanged* gesetzt (siehe [Status des List.entry.flags im Medikationsplan](workflowmanagement.html#status-des-listentryflags-im-medikationsplan)).
   * Planeinträge mit *List.entry.flag = removed* werden aus dem Medikationsplan entfernt.
   * Planeinträge mit abgelaufenem Behandlungszeitraum werden mit *List.entry.flag = removed* gekennzeichnet und werden mit ausgeliefert, um dem GDA die Möglichkeit zu geben, das Medikament weiterzuverodnen. Anderenfalls nimmt der GDA zur Kenntnis, dass der Planeintrag mit seinem nächsten Schreibvorgang entfernt wird.
   * Sind nach der Transformation keine Planeinträge mehr vorhanden, wird *List.emptyReason = nilknown* gesetzt.

3. **Es existiert ein leerer Medikationsplan** (*List.emptyReason = notstarted* oder *nilknown*).
   * Es erfolgt keine Transformation.


##### Aktivitätsdiagramm

<br>
[![overview](plantuml/UC_eMed_01_01_plancheck.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_01_plancheck.svg)
<br> 



#### Sub_UC_eMed_01_02 - Historische Medikationsplanversion lesen (Plan-History-Search)

Beim Plan-History-Search rekonstruiert die Fachanwendung historische Versionen des Medikationsplans aus Versionen der List-Ressource sowie den von diesen referenzierten Ressourcenversionen und liefert diese unverändert aus. 

Alle diese Ressourcen sind Teil des resultierenden Searchset-Bundles.

Der Abruf erfolgt mittels **GET** auf den *List*-Ressourcen-Endpunkt unter Angabe geeigneter Suchparameter:
* **Erstellungszeitraum** von Medikationsplanversionen
* **Medikation** im Medikationsplan (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum** einer Medikation im Medikationsplan
* **Planeintragsid ohne Version**: Abrufen aller Planversionen, die diesen Planeintrag enthalten
* **Planeintragsid mit Version**: Abrufen der Planversionen, die genau diese Planeintragsversion enthalten.
* **StatusReason eines im Plan einthaltenen Planeintrags**: Abrufen aller Planversionen, die einen Planeintrag mit statusReason = z.B. "Medikament nicht vertragen" enthalten.

<!-- TODO: weitere-parameter? -->

Die erzeugten Medikationsplan-Searchset-Bundles dienen ausschließlich der Auslieferung und werden nicht persistiert.

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Ist Plan-History-Search ein GET mit _include=* oder eine Custom Operation?<br>
- Können bei einem GET _history beliebige Suchparameter definiert werden?<br>
</p>
</div>

##### Ablauf

1. Der Client führt ein GET auf *[base]/Patient/[id]/List/_history* mit den gewünschten Suchparametern aus.
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden historischen Versionen der List-Ressource. Für jede gefundene List-Version rekonstruiert die Fachanwendung den historischen Medikationsplan, indem sie die zugehörigen historischen Versionen der referenzierten Ressourcen ermittelt, und ergänzt sie im Medikationsplan-Searchset-Bundle.
3. Die Fachanwendung liefert das Medikationsplan-Searchset-Bundle zurück.
4. Werden keine passenden historischen Medikationsplanversionen gefunden, enthält das zurückgelieferte *searchset* keine Einträge.
5. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.

Beim Plan-History-Search erfolgt **keine Änderung** der Medikationspläne durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert.

Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage persistierter Medikationsplanversionen.


##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_02.svg)
<br> 


###### Beispiele für Suchanfragen
In Arbeit.
<!-- * **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH} -->
<!-- * **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH} -->
<!-- * Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum persistiert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind: GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed  -->
<!-- list.code= 736378000 in Abfragen ergänzen -->

<!-- * Aktuelle Medikationsplanversion lesen:
GET [base]/Patient/[id]/List -->
<!-- * Historische Versionen eines Medikationsplans lesen:
GET [base]/Patient/[id]/List/_history -->
<!-- * Historische Medikationsplanversionen lesen, die ab einem bestimmten Datum erstellt wurden:
GET [base]/Patient/[id]/List/_history?date=ge2025-01-01 -->
<!-- * Historische Medikationsplanversionen lesen, die einen bestimmten Planeintrag enthalten:
GET [base]/Patient/[id]/List/_history?_include=*&item=MedicationRequest/[id] -->
<!-- * Historische Medikationsplanversionen lesen, die nach einem bestimmten Datum erstellt wurden und einen bestimmten Planeintrag enthalten:
GET [base]/Patient/[id]/List/_history?_include=*&item=MedicationRequest/[id]&date=ge2025-01-01 -->


#### Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan

Die initiale Erstellung eines Medikationsplans erfolgt ausschließlich durch die e-Medikation-Fachanwendung. Sie wird ausgelöst, wenn im Rahmen eines erstmaligen Aufrufs von [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) noch kein Medikationsplan für den ELGA-Teilnehmer existiert.

Der dabei erzeugte initiale Medikationsplan besitzt den Wert *List.emptyReason = notstarted*. Dieser kennzeichnet ausschließlich den **Initialzustand** des Medikationsplans und bedeutet, dass bisher noch keine Medikationsplaneinträge erfasst wurden. Er trifft jedoch keine Aussage darüber, ob der Patient Medikamente einnimmt.

Die Initialisierung kann sowohl durch ein GDA-System als auch durch den ELGA-Teilnehmer über das Portal ausgelöst werden, indem erstmals ein **Plan-Read** durchgeführt wird.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Soll die Erstellung durch das Berechtigungssystem beim ersten Aufruf eines Patienten getriggert werden (nicht mehr Teil von $plan-read)?
</p>
</div>

##### Ablauf 

1. Ein Client führt für einen ELGA-Teilnehmer erstmalig ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan für den Patienten existiert.
3. Existiert noch kein Medikationsplan, erstellt die Fachanwendung initial eine List-Ressource mit *emptyReason = notstarted*.
4. Die List-Ressource wird als erste Version persistiert.
5. Für das Plan-Read erzeugt die Fachanwendung daraus ein temporäres Medikationsplan-Searchset-Bundle zur Auslieferung.
6. Dieses wird mit *List.emptyReason = notstarted* sowie dem zugehörigen ETag zurückgeliefert.

##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_03.svg){: .mx-auto style="width:45%;"}](plantuml/UC_eMed_01_03.svg)
<br> 


#### Sub_UC_eMed_01_04 - Medikationsplaneinträge lesen (Planentry-Search)

**Planentry-Search** dient der gezielten Suche nach Medikationsplaneintragsversionen eines ELGA-Teilnehmer. Als Medikationsplaneintrag gilt eine im Medikationsplan referenzierte Version einer *MedicationRequest*-Ressource mit *category = "Planeintrag"*.

Die Suche ermöglicht berechtigten GDA sowie ELGA-Teilnehmern den Zugriff auf aktuelle und historische Medikationsplaneinträge unabhängig von einer bestimmten Medikationsplanversion.

Die Historie ermöglicht die Nachverfolgung von Änderungen an Medikationsplaneinträgen, beispielsweise hinsichtlich Präparat, Dosierung oder Einnahmeanweisung.

Der Abruf erfolgt mittels **GET** unter Angabe geeigneter Suchparameter:<br>
<!-- TODO: search-parameter -->

* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum**
* **Erstellungszeitpunkt**
* **Status** des Medikationsplaneintrags (z.B. *active* oder *on-hold*)
* **StatusReason**: statusReason = z.B. "Medikament nicht vertragen" 
* **Historisch oder aktuell** (_history)

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Können bei einem GET _history beliebige Suchparameter definiert werden?<br>
</p>
</div>

<br>
Die gefundenen Medikationsplaneinträge können anschließend als Ausgangspunkt für weitere Abfragen verwendet werden, um jene Ressourcen zu ermittelnt, die genau auf diese Planeintragsversion referenzieren:

* die zugehörigen Medikationsplanversionen mittels [Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search)
* *Geplante Abgaben* (*Prescription-Search*) <!-- TODO Link -->
* *Durchgeführte Abgaben* (*Dispense-Search*) <!-- TODO Link -->

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
- Sind die Referenzen in Geplanten und Durchgeführten Abgaben versioniert?<br>
</p>
</div>

##### Ablauf

1. Der Client führt ein **GET** auf den Planentry-Search-Endpunkt mit den gewünschten Suchparametern aus (*MedicationRequest* mit *category = "Planeintrag"*).
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden Medikationsplaneinträge.
4. Die Fachanwendung liefert die Suchergebnisse als Bundle vom Typ *searchset* zurück.
6. Werden keine passenden Medikationsplaneinträge gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
7. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.

##### Sequenzdiagramm

<br>
[![overview](plantuml/UC_eMed_01_04.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_04.svg)
<br> 

##### Beispiele für Suchanfragen

In Arbeit. 
<!-- * Alle aktiven Medikationsplaneinträge eines Patienten:
  `GET /Patient/[id]/MedicationRequest?status=active` -->

<!-- * Medikationsplaneinträge zu einem bestimmten Arzneimittel:
  `GET /Patient/[id]/MedicationRequest?medication=<PZN>` -->

<!-- * Medikationsplaneinträge innerhalb eines Erstellungszeitraums:
  `GET /Patient/[id]/MedicationRequest?authoredon=ge2026-01-01&authoredon=le2026-12-31` -->
<!-- 
* Historische und aktuelle Medikationsplaneinträge eines bestimmten Wirkstoffs:
  `GET /Patient/[id]/MedicationRequest?ingredient=<Wirkstoff>` -->


#### Sub_UC_eMed_01_05 - Verzeichnis historischer Medikationspläne lesen (Plan-History-Directory-Search)

<!-- GET	/Patient/[id]/List	plan-history-directory-search	Verzeichnis historischer Medikationspläne abrufen
(_history?_elements=date,source) -->

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$plan-history-directory-search: in Arbeit.
</p>
</div>