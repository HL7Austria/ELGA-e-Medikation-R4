{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Dieser technische Use Case beschreibt den lesenden Zugriff [berechtigter Akteure](actors.html#rollen-und-berechtigungen) auf den Medikationsplan eines ELGA-Teilnehmers.

Für ELGA-Teilnehmer und deren Vertretungen erfolgt der lesende Zugriff über das ELGA-Zugangsportal. Für die übrigen Akteure erfolgt der lesende Zugriff über die e-Medikations-Schnittstelle des jeweiligen GDA-Systems. 

Der lesende Zugriff umfasst:

* den Abruf des **aktuellen Medikationsplans**, der für eine mögliche Bearbeitung aufbereitet ist ([Plan-Read](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)),

* die Suche und den Abruf **einzelner aktueller Planeinträge** ([Planentry-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---medikationsplaneinträge-lesen-planentry-search)) sowie 

* die Suche und den Abruf (History-Search): 
  * historischer Medikationsplanversionen ([Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_03_01---historische-medikationsplanversionen-suchen-plan-history-search))
  * historischer Planeintragversionen ([Planentry-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_03_02---historische-planeintragversionen-suchen-planentry-history-search))
  * Verzeichnis historischer Medikationsplanversionen ([Plan-History-Directory-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_03_03---verzeichnis-der-medikationspanversionen-lesen-plan-history-directory-search))

<div class="hinweisbox">
ℹ️ Die fachlichen Anforderungen dieses Use Cases werden im <a href="Sub_UC_eMed_01.html">UC_eMed_01 Medikationsplan lesen</a> beschrieben.<br> 
Es gelten die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert. 
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 25.09.2026 -->


### Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)

*Plan-Read* dient dem Abruf des aktuellen Medikationsplans in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Hierfür erzeugt die Fachanwendung aus der aktuellen Version der [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource sowie den von ihr referenzierten Ressourcen ein **temporäres** [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) zur Auslieferung. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

#### Ablauf

1. Der Client führt **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft den Zustand des Medikationsplans (siehe Kapitel [Prüfung des Planzustands und Erzeugung des Medikationsplan-Bundles](Sub_UC_eMed_01.html#prüfung-des-planzustands-und-erzeugung-des-medikationsplan-bundles)) und erzeugt ein [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) zur Auslieferung.
3. Die Fachanwendung liefert das Medikationsplan-Bundle zurück. Dieses enthält im HTTP-Header den ***ETag*** der aktuellen Version der *List*-Ressource für das [**Optimistic Locking**](https://hl7.org/fhir/http.html#concurrency) (siehe auch [Designentscheidungen - Optimistisches Locking mit ETags](design_choices.html#optimistisches-locking-mit-etags)).

<!-- TODO check ob ETAG noch im header akl. 14.10. -->

Nachfolgend kann der Medikationsplan vom GDA bearbeitet und mittels [Plan-Write](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write) gespeichert werden.

<br>
[![overview](plantuml/UC_eMed_01_01.svg){: .mx-auto style="width:35%;"}](plantuml/UC_eMed_01_01.svg)
<br> 

#### Custom Operations

POST [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html)

#### Prüfung des Planzustands und Erzeugung des Medikationsplan-Bundles

Nach Eingang eines *$plan-read* prüft die Fachanwendung den Zustand des Medikationsplans und führt entsprechende Schritte durch, bevor ein Medikationsplan-Bundle zur Auslieferung erstellt wird (siehe [Ablauf](Sub_UC_eMed_01.html#ablauf)). 

Die **persistierten Ressourcen am Server** werden durch die Transformationen für das Auslieferungs-Bundle **nicht verändert**.

#### Ablauf

1. **Es existiert kein Medikationsplan**:
* Es wird gemäß ein [initialer Medikationsplan]((Sub_UC_eMed_01.html#sub_uc_emed_01_01_01---initial-erstellter-medikationsplan)) erstellt ([List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource mit *List.emptyReason = notstarted*).
* Es erfolgt keine Transformation.

2. **Es existiert ein Medikationsplan mit Planeinträgen**:
* Folgende Transformationen werden durchgeführt (siehe [Status des List.entry.flags im Medikationsplan](workflowmanagement.html#status-des-listentryflags-im-medikationsplan)):
  * Neue oder geänderte Planeinträge (*List.entry.flag = new* oder *changed*) werden auf ***unchanged*** gesetzt.
  * Stornierte und beendete Planeinträge mit *List.entry.flag = **removed*** werden aus dem Medikationsplan **entfernt**.
  * Planeinträge mit **abgelaufenem Behandlungszeitraum** werden mit *List.entry.flag = removed* gekennzeichnet und werden mit **ausgeliefert**, um dem GDA die Möglichkeit zu geben, das Arzneimittel weiterzuverodnen. Anderenfalls nimmt der GDA zur Kenntnis, dass der Planeintrag mit seinem nächsten Schreibvorgang entfernt wird. <!--   todo: auch medicationrequests mit neuem status vorbereitet -> wenn nein, muss der GDA jedenfalls "etwas tun"  akl. 14.10.-->
  * Sind nach der Transformation keine Planeinträge mehr vorhanden, wird *List.emptyReason = nilknown* gesetzt.
<!-- Todo: wie ermittelt die Fachanwendung, ob Behandlungszeitraum abgelaufen akl 25.09.2026 -->
3. **Es existiert ein leerer Medikationsplan** (mit einem [List.emptyReason](https://fhir.hl7.at/r4-ELGA-e-Medikation-main/ValueSet-ElgaListEmptyReasonVS.html)).
* Es erfolgt keine Transformation.
4. Das **Medikationsplan-Bundle** ist zur Auslieferung bereit. Es enthält:
* die (ggf. transformierte) [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource,
* sämtliche von der *List* referenzierten Ressourcen

<br>
[![overview](plantuml/UC_eMed_01_01_plancheck.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_01_01_plancheck.svg)
<br> 

#### Sub_UC_eMed_01_01_01 - Initial erstellter Medikationsplan

Die initiale Erstellung eines Medikationsplans erfolgt ausschließlich durch die e-Medikation-Fachanwendung. Sie wird ausgelöst, wenn im Rahmen eines erstmaligen Aufrufs von [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) noch kein Medikationsplan für den ELGA-Teilnehmer existiert.

Der dabei erzeugte initiale Medikationsplan besitzt den Wert *List.emptyReason = notstarted*. Dieser kennzeichnet ausschließlich den **Initialzustand** des Medikationsplans und bedeutet, dass bisher noch keine Medikationsplaneinträge erfasst wurden. Er trifft jedoch keine Aussage darüber, ob der Patient Medikamente einnimmt.

Die Initialisierung kann sowohl durch ein GDA-System als auch durch den ELGA-Teilnehmer über das Zugangsportal ausgelöst werden.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Soll die Erstellung durch das Berechtigungssystem beim ersten Aufruf eines Patienten getriggert werden (nicht mehr Teil von $plan-read)?
</p>
</div>

#### Ablauf 

1. Ein Client führt **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan xistiert.
3. Existiert noch kein Medikationsplan, erstellt die Fachanwendung initial eine List-Ressource mit *emptyReason = notstarted*.
4. Die List-Ressource wird als erste Version persistiert.
5. Für das *Plan-Read* erzeugt die Fachanwendung daraus ein temporäres Medikationsplan-Bundle zur Auslieferung.
6. Dieses wird mit *List.emptyReason = notstarted* sowie dem zugehörigen ETag zurückgeliefert.

<br>
[![overview](plantuml/UC_eMed_01_01_01.svg){: .mx-auto style="width:40%;"}](plantuml/UC_eMed_01_01_01.svg)
<br> 

### Sub_UC_eMed_01_02 - Medikationsplaneinträge suchen (Planentry-Search)

**Planentry-Search** dient der gezielten Suche nach **aktuellen** Planeinträgen. Als Planeintrag gilt eine im Medikationsplan referenzierte *MedicationRequest*-Ressource mit *category = "Planeintrag"*.


#### Suchparameter

Die Suche nach Planeinträgen erfolgt mittels **GET**-Request unter Angabe geeigneter Suchparameter:<br>
* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum**
* **Erstellungszeitpunkt**
* **Status**: [Value Set](ValueSet-PlaneintragStatusVS.html)
* **StatusReason**: [Value Set](ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html)
<!-- * Erstellender GDA? Todo akl 2.10. -->

Die gefundenen Planeinträge können als Ausgangspunkt für weitere Abfragen verwendet werden:

* *Geplante Abgaben* ([Prescription-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) 
* *Durchgeführte Abgaben* ([Dispense-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) 

<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
- Sind die Referenzen in Geplanten Abgaben und Durchgeführten Abgaben versioniert?<br>
</p>
</div> Todo: akl 2.10. dzt. Annahme: nein  -> gehört zu Geplanten u Durchgef.Abgaben -->


#### Ablauf

1. Der Client führt einen **GET**-Request auf den Planentry-Search-Endpunkt mit den gewünschten Suchparametern aus (*MedicationRequest* mit *category = "Planeintrag"*).
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden Medikationsplaneinträge.
4. Die Fachanwendung liefert die Suchergebnisse als Bundle vom Typ *searchset* zurück.
6. Werden keine passenden Medikationsplaneinträge gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
7. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.


<br>
[![overview](plantuml/UC_eMed_01_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_02.svg)
<br> 


### Sub_UC_eMed_01_03 Suche und den Abruf historischer Versionen (History-Search)

Diese umfasst die Suche und den Abruf historischer Medikationsplan- und Planeintragversionen und eine Verzeichnissuche der Medikationspanversionen.  <!-- TODO Anja bitte erklären -->

Die hiefür verwendete Operation [$history-search](Sub_UC_eMed_01.html#custom-operations-1) und die entsprechenden Inputparameter werden in den folgenden Use Cases beschrieben.

#### Sub_UC_eMed_01_03_01 - Historische Medikationsplanversionen suchen (Plan-History-Search)

Bei der *Plan-History-Search* rekonstruiert die Fachanwendung historische Versionen des Medikationsplans aus Versionen der List-Ressource sowie den von diesen referenzierten Ressourcenversionen und liefert diese unverändert aus. Alle diese Ressourcen sind Teil des resultierenden Searchset-Bundles.

Bei der *Plan-History-Search* erfolgt **keine Änderung** der Medikationspläne durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert. Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage persistierter Medikationsplanversionen.

##### Inputparameter

Der Abruf erfolgt mittels POST [$history-search](Sub_UC_eMed_01.html#custom-operations-1) auf den *List*-Ressourcen-Endpunkt unter Angabe geeigneter Inputparameter:

* **Zeitraum der Erfassung** von Medikationsplanversionen
* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum** einer Medikation
* **Planeintragsid ohne Version**: Abrufen aller Medikationsplanversionen, die diesen Planeintrag enthalten
* **Planeintragsid mit Version**: Abrufen der Medikationsplanversionen, die genau diese Planeintragsversion enthalten.
* **StatusReason eines im Plan einthaltenen Planeintrags**: Abrufen aller Planversionen, mit Planeinträgen mit bestimmtem [statusReason](ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html).
<!-- * Erstellender GDA? Todo akl 2.10. -->

#### Sub_UC_eMed_01_03_02 - Historische Planeintragversionen suchen (Planentry-History-Search)

*Planentry-History-Search* ermöglicht den Zugriff auf aktuelle und historische Versionen von Medikationsplaneinträge und somit die Nachverfolgung von Änderungen an Medikationsplaneinträgen, beispielsweise hinsichtlich Präparat, Dosierung oder Einnahmeanweisung.

#### Inputparameter

Der Abruf erfolgt mittels POST [$history-search](Sub_UC_eMed_01.html#custom-operations-1) auf den *MedicationRequest*-Ressourcen-Endpunkt unter Angabe geeigneter Inputparameter:

* *MedicationRequest.category* = "Planteintrag"
* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum**
* **Erstellungszeitpunkt**
* **Status**: [Value Set](ValueSet-PlaneintragStatusVS.html)
* **StatusReason**: [Value Set](ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html)
<!-- * Erstellender GDA? Todo akl 2.10. -->

Die gefundenen Planeinträge können als Ausgangspunkt für weitere Abfragen verwendet werden, um jene Ressourcen zu ermittelnt, die genau auf diese Planeintragsversion referenzieren:

* *Geplante Abgaben* ([Prescription-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) 
* *Durchgeführte Abgaben* ([Dispense-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) 
* die zugehörigen Medikationsplanversionen ([Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_03_01---historische-medikationsplanversionen-suchen-plan-history-search))


#### Sub_UC_eMed_01_03_03 - Verzeichnis der Medikationspanversionen lesen (Plan-History-Directory-Search)

Gleich wie Sub_UC_eMed_01_03_01 - Historische Medikationsplanversionen suchen (Plan-History-Search) nur list ohne referenzierte Ressourcen. 

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>in Arbeit.
</p>
</div>


#### Ablauf

1. Der Client führt POST [$history-search](Sub_UC_eMed_01.html#custom-operations-1) mit geeigneten Inputparametern aus.
2. Die Fachanwendung ermittelt anhand dieser die historischen Ressourcen-Versionen und rekonstruiert gegebenenfalls  historische Medikationsplanversionen, indem sie die zugehörigen Versionen der referenzierten Ressourcen ermittelt.
3. Die Fachanwendung liefert das Ergebnis in einem Bundle vom Typ searchset zurück.
4. Werden keine passenden Ressourcen-Versionen gefunden, enthält das zurückgelieferte *searchset* Bundle keine Einträge.
5. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.

<br>
[![overview](plantuml/UC_eMed_01_03.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_03.svg)
<br> 

#### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$history-search: in Arbeit.
</p>
</div>


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


<!-- * Alle aktiven Medikationsplaneinträge eines Patienten:
  `GET /Patient/[id]/MedicationRequest?status=active` -->
<!-- * Medikationsplaneinträge zu einem bestimmten Arzneimittel:
  `GET /Patient/[id]/MedicationRequest?medication=<PZN>` -->
<!-- * Medikationsplaneinträge innerhalb eines Erstellungszeitraums:
  `GET /Patient/[id]/MedicationRequest?authoredon=ge2026-01-01&authoredon=le2026-12-31` -->
<!-- 
* Historische und aktuelle Medikationsplaneinträge eines bestimmten Wirkstoffs:
  `GET /Patient/[id]/MedicationRequest?ingredient=<Wirkstoff>` -->