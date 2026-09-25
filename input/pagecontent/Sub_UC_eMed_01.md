{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan lesen (UC_eMed_01) -->

Dieser technische Use Case beschreibt den lesenden Zugriff [berechtigter Akteure](actors.html#rollen-und-berechtigungen) auf den Medikationsplan eines ELGA-Teilnehmers.

Für ELGA-Teilnehmer und deren Vertretungen erfolgt der Zugriff über das ELGA-Zugangsportal. Für die übrigen Akteure erfolgt der Zugriff über die e-Medikations-Schnittstelle des jeweiligen GDA-Systems. 

Der lesende Zugriff umfasst:

* den Abruf des **aktuellen Medikationsplans**, der für eine mögliche Bearbeitung aufbereitet ist ([Plan-Read](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)),
* die Suche und den Abruf **historischer Versionen des Medikationsplans** ([Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search)),
* die Suche und den Abruf **einzelner Medikationsplaneinträge** bzw. historischer Versionen ([Planentry-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_04---medikationsplaneinträge-lesen-planentry-search))sowie 
* Abruf eines **Verzeichnisses historischer Medikationspläne** ([Plan-History-Directory-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_05---verzeichnis-historischer-medikationspläne-lesen-plan-history-directory-search)) <!-- Todo: -> keine fachliche Anforderung für Plan-History-Directory-Search? akl 25.09.2026 -->

<div class="hinweisbox">
Die fachlichen Anforderungen dieses Use Cases werden im <a href="Sub_UC_eMed_01.html">UC_eMed_01 Medikationsplan lesen</a> beschrieben.<br> 
Für sämtliche im Folgenden beschriebenen Zugriffsarten gelten zusätzlich die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert. 
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 25.09.2026 -->


### Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)

<!--Todo:  Wording im UC "anzeigen" statt lesen. ändern? akl 25.09.2026 -->

Plan-Read dient dem Abruf des aktuellen Medikationsplans in einem für die Bearbeitung durch den GDA **aufbereiteten Zustand**.

Hierfür erzeugt die Fachanwendung aus der aktuellen Version der [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource sowie den von ihr referenzierten Ressourcen ein **temporäres** [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) zur Auslieferung. Der Abruf erfolgt über die Custom Operation [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html).

#### Ablauf

1. Der Client führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft den Zustand des Medikationsplans und erzeugt ein Medikationsplan-Bundle zur Auslieferung (siehe [Prüfung des Planzustands und Erzeugung des Medikationsplan-Bundles](Sub_UC_eMed_01.html#prüfung-des-planzustands-und-erzeugung-des-medikationsplan-bundles)).
3. Die Fachanwendung liefert das Medikationsplan-Bundle zurück. Dieses enthält im HTTP-Header den ***ETag*** der aktuellen Version der *List*-Ressource für das [**Optimistic Locking**](https://hl7.org/fhir/http.html#concurrency).

Nachfolgend kann der Medikationsplan vom GDA bearbeitet und mittels [Plan-Write](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write) gespeichert werden.

<br>
[![overview](plantuml/UC_eMed_01_01.svg){: .mx-auto style="width:35%;"}](plantuml/UC_eMed_01_01.svg)
<br> 

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Fehlercodes sind noch zu definieren.
</p>
</div>


#### Custom Operations

POST [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html)

#### Prüfung des Planzustands und Erzeugung des Medikationsplan-Bundles

Nach Eingang eines **$plan-read** prüft die Fachanwendung den Zustand des Medikationsplans und führt entsprechende Schritte durch, bevor ein **Medikationsplan-Bundles zur Auslieferung** erstellt wird (siehe [Ablauf](Sub_UC_eMed_01.html#ablauf)). 

Die **persistierten Ressourcen am Server** werden durch die Transformationen für das Auslieferungs-Bundle **nicht verändert**.

#### Ablauf

1. **Es existiert kein Medikationsplan.**
* Es wird gemäß [Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan](Sub_UC_eMed_01.html#sub_uc_emed_01_03---initial-erstellter-medikationsplan) ein initialer Medikationsplan erstellt ([List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource mit *List.emptyReason = notstarted*).
* Es erfolgt keine Transformation.

2. **Es existiert ein Medikationsplan mit Planeinträgen.**
* Transformationen durchführen (siehe auch [Status des List.entry.flags im Medikationsplan](workflowmanagement.html#status-des-listentryflags-im-medikationsplan)):
  * Neue oder geänderte Planeinträge (*List.entry.flag = new* oder *changed*) werden auf ***unchanged*** gesetzt (siehe [Status des List.entry.flags im Medikationsplan](workflowmanagement.html#status-des-listentryflags-im-medikationsplan)).
  * Stornierte und beendete Planeinträge mit *List.entry.flag = **removed*** werden aus dem Medikationsplan **entfernt**.
  * Planeinträge mit **abgelaufenem Behandlungszeitraum** werden mit *List.entry.flag = removed* gekennzeichnet und werden mit **ausgeliefert**, um dem GDA die Möglichkeit zu geben, das Medikament weiterzuverodnen. Anderenfalls nimmt der GDA zur Kenntnis, dass der Planeintrag mit seinem nächsten Schreibvorgang entfernt wird.
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


### Sub_UC_eMed_01_02 - Historische Medikationsplanversion suchen (Plan-History-Search)

Bei der Plan-History-Search rekonstruiert die Fachanwendung historische Versionen des Medikationsplans aus Versionen der List-Ressource sowie den von diesen referenzierten Ressourcenversionen und liefert diese unverändert aus. Alle diese Ressourcen sind Teil des resultierenden Searchset-Bundles.

Beim Plan-History-Search erfolgt **keine Änderung** der Medikationspläne durch die Fachanwendung. Insbesondere werden keine Inhalte, Statusinformationen oder Kennzeichnungen (Flags) verändert. Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage persistierter Medikationsplanversionen.

#### Suchparameter

Der Abruf erfolgt mittels **GET** auf den *List*-Ressourcen-Endpunkt unter Angabe geeigneter **Suchparameter**:
* **Zeitraum der Erfassung** von Medikationsplanversionen
* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum** einer Medikation
* **Planeintragsid ohne Version**: Abrufen aller Medikationsplanversionen, die diesen Planeintrag enthalten
* **Planeintragsid mit Version**: Abrufen der Medikationsplanversionen, die genau diese Planeintragsversion enthalten.
* **StatusReason eines im Plan einthaltenen Planeintrags**: Abrufen aller Planversionen, mit Planeinträgen mit bestimmtem [statusReason](ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html).


#### Ablauf

1. Der Client führt ein GET auf *[base]/List/_history* <!-- Todo: prüfen  akl 25.09.26 --> mit den passenden Suchparametern aus.
2. Die Fachanwendung ermittelt anhand dieser die historischen Versionen der *List*-Ressource. Für jede gefundene *List*-Version rekonstruiert die Fachanwendung den historischen Medikationsplan, indem sie die zugehörigen historischen Versionen der referenzierten Ressourcen ermittelt und diese im Medikationsplan-Bundle ergänzt.
3. Die Fachanwendung liefert die den Suchparametern entsprechenden historischen Medikationspläne als Medikationsplan-Bundles in einem Bundle vom Typ searchset zurück.
4. Werden keine passenden historischen Medikationsplanversionen gefunden, enthält das zurückgelieferte *searchset* keine Einträge.
5. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.


<br>
[![overview](plantuml/UC_eMed_01_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_02.svg)
<br> 

#### Beispiele für Suchanfragen

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>in Arbeit.
</p>
</div>

<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Ist Plan-History-Search ein GET mit _include=* oder eine Custom Operation?<br>
- Können bei einem GET _history beliebige Suchparameter definiert werden?<br>
</p>
</div> TODO: Annahme treffen akl 25.09.26 -->

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


### Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan

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

1. Ein Client führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus.
2. Die Fachanwendung prüft, ob bereits ein Medikationsplan xistiert.
3. Existiert noch kein Medikationsplan, erstellt die Fachanwendung initial eine List-Ressource mit *emptyReason = notstarted*.
4. Die List-Ressource wird als erste Version persistiert.
5. Für das *Plan-Read* erzeugt die Fachanwendung daraus ein temporäres Medikationsplan-Bundle zur Auslieferung.
6. Dieses wird mit *List.emptyReason = notstarted* sowie dem zugehörigen ETag zurückgeliefert.

<br>
[![overview](plantuml/UC_eMed_01_03.svg){: .mx-auto style="width:40%;"}](plantuml/UC_eMed_01_03.svg)
<br> 

### Sub_UC_eMed_01_04 - Medikationsplaneinträge suchen (Planentry-Search)

**Planentry-Search** dient der gezielten Suche nach Medikationsplaneintragsversionen. Als Medikationsplaneintrag gilt eine im Medikationsplan referenzierte Version einer *MedicationRequest*-Ressource mit *category = "Planeintrag"*.

Die Suche ermöglicht berechtigten Akteuren den Zugriff auf aktuelle und historische Medikationsplaneinträge unabhängig von einer bestimmten Medikationsplanversion.

Die Historie ermöglicht die Nachverfolgung von Änderungen an Medikationsplaneinträgen, beispielsweise hinsichtlich Präparat, Dosierung oder Einnahmeanweisung.


#### Suchparameter

Die Suche nach Medikationsplaneinträgen erfolgt mittels **GET** unter Angabe geeigneter Suchparameter:<br>
* **Medikation** (PZN, Arzneimittelname oder Wirkstoff)
* **Einnahmezeitraum**
* **Erstellungszeitpunkt**
* **Status** (z.B. *stopped* oder *on-hold*)
* **StatusReason**: bestimmtes [statusReason](ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html)
* **Historisch oder aktuell** (_history)

<br>
Die gefundenen Medikationsplaneinträge können anschließend als Ausgangspunkt für weitere Abfragen verwendet werden, um jene Ressourcen zu ermittelnt, die genau auf diese Planeintragsversion referenzieren:

* die zugehörigen Medikationsplanversionen mittels [Plan-History-Search](Sub_UC_eMed_01.html#sub_uc_emed_01_02---historische-medikationsplanversion-lesen-plan-history-search)
* *Geplante Abgaben* ([Prescription-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) 
* *Durchgeführte Abgaben* ([Dispense-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) 

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
- Sind die Referenzen in Geplanten Abgaben und Durchgeführten Abgaben versioniert?<br>
</p>
</div>

#### Ablauf

1. Der Client führt ein **GET** auf den Planentry-Search-Endpunkt mit den gewünschten Suchparametern aus (*MedicationRequest* mit *category = "Planeintrag"*).
2. Die Fachanwendung ermittelt anhand der Suchparameter die passenden Medikationsplaneinträge.
4. Die Fachanwendung liefert die Suchergebnisse als Bundle vom Typ *searchset* zurück.
6. Werden keine passenden Medikationsplaneinträge gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
7. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.

<br>
[![overview](plantuml/UC_eMed_01_04.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_01_04.svg)
<br> 

#### Beispiele für Suchanfragen

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>in Arbeit.
</p>
</div>

<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Können bei einem GET _history beliebige Suchparameter definiert werden?<br>
</p>
</div> TODO: Annahmen Treffen akl 25.09.2026 -->


<!-- * Alle aktiven Medikationsplaneinträge eines Patienten:
  `GET /Patient/[id]/MedicationRequest?status=active` -->

<!-- * Medikationsplaneinträge zu einem bestimmten Arzneimittel:
  `GET /Patient/[id]/MedicationRequest?medication=<PZN>` -->

<!-- * Medikationsplaneinträge innerhalb eines Erstellungszeitraums:
  `GET /Patient/[id]/MedicationRequest?authoredon=ge2026-01-01&authoredon=le2026-12-31` -->
<!-- 
* Historische und aktuelle Medikationsplaneinträge eines bestimmten Wirkstoffs:
  `GET /Patient/[id]/MedicationRequest?ingredient=<Wirkstoff>` -->


### Sub_UC_eMed_01_05 - Verzeichnis historischer Medikationspläne lesen (Plan-History-Directory-Search)

<!-- GET	/Patient/[id]/List	plan-history-directory-search	Verzeichnis historischer Medikationspläne abrufen
(_history?_elements=date,source) -->

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$plan-history-directory-search: in Arbeit.
</p>
</div>