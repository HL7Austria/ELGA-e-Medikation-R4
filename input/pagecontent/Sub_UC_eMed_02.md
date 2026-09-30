{% include styleheader.md %}

<!-- Technische Use Cases für Medikationsplan schreiben (UC_eMed_02) -->

Dieser technische Use Case beschreibt den schreibenden Zugriff [berechtigter Akteure](actors.html#rollen-und-berechtigungen) auf den Medikationsplan eines ELGA-Teilnehmers.

Für ELGA-Teilnehmer (bzw. deren Vertretungen) erfolgt der schreibende Zugriff im Rahmen der Ausübung von Teilnehmerrechten ausschließlich über das ELGA-Zugangsportal. Für GDA erfolgt der schreibende Zugriff über die e-Medikation-Schnittstelle des jeweiligen GDA-Systems.

Der schreibende Zugriff umfasst folgende Bearbeitungen der **aktuellen Version des Medikationsplans**:
* **GDA** können einzelne **Medikationsplaneinträge**
    * [hinzufügen](Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen),
    * [ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern),
    * [unverändert zur Kenntis nehmen](Sub_UC_eMed_02.html#sub_uc_emed_02_04---planeintrag-unverändert-zur-kenntnis-nehmen),
    * [pausieren bzw. reaktivieren](Sub_UC_eMed_02.html#sub_uc_emed_02_05---planeintrag-pausieren-oder-reaktivieren),
    * [beenden](Sub_UC_eMed_02.html#sub_uc_emed_02_08---planeintrag-im-medikationsplan-beenden),
    * [stornieren](Sub_UC_eMed_02.html#sub_uc_emed_02_07---planeintrag-im-medikationsplan-stornieren),
    * [mit abgelaufenem Einnahmezeitraum weiterverordnen oder beenden](Sub_UC_eMed_02.html#sub_uc_emed_02_09---abgelaufenen-planeintrag-weiterverordnen-oder-beenden)
 * die [Reihenfolge der Planeinträge ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_10---reihenfolge-der-planeinträge-ändern)
 * einen [Leeren Medikationsplan dokumentieren](Sub_UC_eMed_02.html#sub_uc_emed_02_06---leeren-medikationsplan-dokumentieren).

* **ELGA-Teilnehmer** können
  * einzelne aktuelle oder historische [Planeinträge löschen](Sub_UC_eMed_02.html#sub_uc_emed_02_11---planeintrag-durch-elga-teilnehmer-löschen) oder
  * den aktuellen oder historische Versionen des gesamten [Medikationsplans löschen](Sub_UC_eMed_02.html#sub_uc_emed_02_12---medikationsplan-durch-elga-teilnehmer-löschen).

Jede Änderung am Medikationsplan führt zur Erstellung einer **neuen Medikationsplanversion**.
Für GDA gilt zusätzich: 
* Historische Medikationspläne bzw. Planeinträge können **nicht** bearbeitet werden.
* Die Verträglichkeit der neu hinzugefügten/geänderten Medikation mit dem bestehenden Medikationsplan gilt mit der Erstellung einer neuen Medikationsplanversion als bestätigt.
<!--  TODO: wird ein Eintrag eines historischen Plans gelöscht, entsteht auch eine neue Version?-->

<div class="hinweisbox">
ℹ️ Die fachlichen Anforderungen dieses Use Cases werden beschrieben in:
<ul>
    <li>
        <a href="Sub_UC_eMed_02.html">UC_eMed_02 Medikationsplan schreiben</a>
    </li>
    <li>
    <a href="Sub_UC_eMed_06.html">UC_eMed_06 Teilnehmerrechte ausüben</a>
    </li>
</ul>
Es gelten die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert.  
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 25.09.2026 -->


<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Können nur ganze Planversionen oder auch einzelne Planeinträge (inkl. Historie) gelöscht werden?<br>
- Stichworte: referenzielle Integrität, links die nicht auflösen, Ressourcennetz, DataAbsentReason, Verlauf anderer Medikationen geht verloren, _history delete (R6)
</p>
</div> TODO: welche Fragestellungen bleiben übrg? akl 28.09.2026 -->


### Allgemeiner Ablauf Medikationsplan bearbeiten und schreiben

Für jeden Schreibvorgang auf dem **aktuellen Medikationsplan MUSS** der folgende technische Ablauf eingehalten werden:

1. **Aktuellen Medikationsplan abrufen**: mittels [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) (siehe [Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)).
2. **Medikationsplan-Bundle bearbeiten**: Die im zurückgegebenen Medikationsplan-Bundle enthaltenen Ressourcen entsprechend dem jeweiligen fachlichen Anwendungsfall bearbeiten.
3. **Aktualisierten Medikationsplan speichern**: mittels [$plan-write](OperationDefinition-AtElgaEmed.List.PlanWrite.html) als [Medikationsplan-Transaction-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html) an die Fachanwendung übermitteln. Der technische Ablauf, einschließlich der Integritätsprüfung mittels *ETag*, wird im [Sub_UC_eMed_02_01 - Medikationsplan schreiben (Plan-Write)](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write) beschrieben.
<!-- "Fachanwendung" generell mit "e-Medikationssystem" ersetzen? TODO akl 28.09.2026 -->

<br>
[![overview](plantuml/UC_eMed_02_02.svg){: .mx-auto style="width:40%;"}](plantuml/UC_eMed_02_02.svg)
<br> 

Die nachfolgenden technischen Use Cases beschreiben die für den jeweiligen Anwendungsfall erforderlichen Änderungen an den Ressourcen sowie die Struktur und Inhalte des *Medikationsplan-Transaction-Bundles*.


### Sub_UC_eMed_02_01 - Medikationsplan schreiben (Plan-Write)

Alle vom GDA ausgeführten, schreibenden Zugriffe auf den Medikationsplan erfolgen über die Custom Operation [$plan-write](OperationDefinition-AtElgaEmed.List.PlanWrite.html). Die Fachanwendung verwendet den im Request übermittelten *ETag* zur Integritätsprüfung ([Optimistic Locking](https://hl7.org/fhir/http.html#concurrency)), um konkurrierende Änderungen am Medikationsplan zu erkennen.
<!-- TODO: Link zur ETag-Beschreibung im ELGA-Core ergänzen -->

#### Ablauf

1. Das GDA-System übermittelt den aktualisierten Medikationsplan mittels **POST** [$plan-write](OperationDefinition-AtElgaEmed.List.PlanWrite.html) als [Medikationsplan-Transaction-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx). <br>Der Request enthält:
    * alle **neuen**, **geänderten** und **zu entfernenden** Ressourcen im Transaction Bundle
    * den von der Fachanwendung nach dem *$plan-read* übermittelten **ETag** (zur Durchführung des [Optimistic Locking](https://hl7.org/fhir/http.html#concurrency))
    * unveränderte Ressourcen werden ausschließlich referenziert.
2. Die Fachanwendung prüft den übermittelten *ETag* gegen den *ETag* der aktuell persistierten Medikationsplan-Version.
3. Ist der *ETag* gültig, validiert die Fachanwendung das *Medikationsplan-Transaction-Bundle* einschließlich der zulässigen [Zustandsübergänge](workflowmanagement.html#überblick-der-statusänderungen-der-e-medikation-ressourcen) der *List.Entry.Flags* und *MedicationReqeuest.Status*. 
4. Die Fachanwendung erstellt neue Versionen der geänderten Ressourcen und **persistiert** diese.
5. Die Fachanwendung bestätigt die erfolgreiche Aktualisierung des Medikationsplans. 
6. Schlägt die Validierung fehl, wird der Schreibvorgang mit einem **OperationOutcome** abgelehnt.
7. Stimmt der übermittelte *ETag* nicht mit dem der Fachanwendung überein, wird der Schreibvorgang mit einem *OperationOutcome* **abgelehnt**. Vor einem erneuten Schreibversuch muss der Medikationsplan mittels [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) erneut abgerufen und auf Basis der aktuellen Version bearbeitet werden.

<br>
[![overview](plantuml/UC_eMed_02_01.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_02_01.svg)
<br> 

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
- Liefert die Fachanwendung mit der HTTP 200 OK Response im Body auch die Ressourcen, so wie sie persistiert wurden, wieder zurück? Bei neu angelegten Ressourcen ist erst dadurch für den Client die id ersichtlich (wird vom Server vergeben).
</p>
</div>

<div class="dragon">
<p class="note-to-balloters">
Offener Punkt:<br>
- OperationOutcome defnieren
</p>
</div>

#### Custom Operations

* [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html)


### Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen

Der GDA kann dem Medikationsplan ein oder mehrere Planeinträge hinzufügen (neu einzunehmende, verordnete Medikation). 
Dabei muss er dokumentieren, ob dieser von ihm selbst stammt oder nicht (Fremdmedikation durch einen anderen GDA bzw. Eigenmedikation des Patienten).

#### Ablauf 

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source*: wird auf den aktuellen GDA (Ersteller) geändert
    - *List.date*: wird mit dem Zeitpunkt der Änderung des Medikationsplans aktualisiert
    - *List.entry*: Für jede neu einzunehmende Medikation wird ein **neuer** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html)) referenziert
    - *List.entry.flag* des neuen Planeintrags erhält den Wert ***new*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* *MedicationRequest*-Ressource(n) erstellen: [AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html): 
    - *extension:effectiveDosePeriod*: Einnahmezeitraum. Einnahme-Startdatum kann in der Zukunft oder in der Vergangenheit liegen (Nacherfassung); <!-- jedoch nicht vor dem Erfassungsdatum der aktuellen Medikationsplanversion??  TODO akl 29.09.2026 --> das Einnahme-Enddatum darf nicht in der Vergangenheit liegen.
    - *status* muss mit *active* oder *on-hold* dokumentiert werden (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag) und [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status))
    - *intent = order* und *category = "Planeintrag"* sind für alle Planeinträge verpflichtend mit festem Wert zu dokumentieren
    - *reportedBoolean* erhält den Wert *false*, wenn die Medikation vom Ersteller des Planeintrags (GDA) selbst stammt, sonst *true*
    - *Medication*: zur Dokumentation des Arzneimittels wird die *Medication*-Ressource verwendet. Diese muss bei Medikamenten mit PZN beim Schreiben als **Logical Reference** mit **PZN und Name** angegeben werden (beim Lesen ist diese contained in der Ressource enthalten). Magistrale Zubereitungen sind immer als contained Ressource anzugeben (siehe Kapitel [Medikation](ELGA-e-Medikation-R4/output/medication.html)).
    - *subject*: [ELGA Core Patient](https://build.fhir.org/ig/HL7Austria/ELGA-Core-R4/StructureDefinition-at-elga-core-patient.html) darf **nicht geändert** werden.  <!-- TODO: prüfen wir das? akl 30.09.2026 -->
    - *authoredOn*: Datum der Erstellung des Planeintrags
    - *requester*: Ersteller des Planeintrags (GDA). AT ELGA Core Practitioner, PractitionerRole bzw. Organization Profile (siehe [ELGA Core](https://build.fhir.org/ig/HL7Austria/ELGA-Core-R4/artifacts.html))
    - *courseOfTherapyType* dokumentiert verpflichtend die Art der Medikation. Mögliche Ausprägungen sind *continuous* für Dauermedikation und *acute* für Akutmedikation. Bei Aktumedikation ist in *extension:effectiveDosePeriod* verpflichtend ein Enddatum für den Einnahmezeitraum zu dokumentieren. Bei Dauermedikation kann ein Enddatum dokumentiert werden. <!-- TODO: Achtung Inkonsistenz Invariante bei Dauermedikation Enddatum! -->
    - *dosageInstruction*: siehe [Dosierungen](dosages.html) 

Im Anschluss übermittelt der GDA mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- alle neuen *MedicationRequests* sind im Transaction Bundle enthalten
- die unveränderten Ressourcen sind nicht im Bundle enthalten, sondern werden in der *List-Ressource* nur referenziert.

Anmerkung: Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) ändert die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) den Status der List.entry.flags von *new* automatisch auf *unchanged*.

#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird hinzufgefügt
        flag: new
        item: Referenz auf den Planeintrag 1  // siehe "Relevante Elemente (MedicationRequest - Planeintrag 1)"
    entry[1]:  // 2. Planeintrag wird hinzufgefügt
        flag: new
        item: Referenz auf den Planeintrag 2  // analog zu "Relevante Elemente (MedicationRequest - Planeintrag 1)"
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    status: active | on-hold
    category: "Planeintrag"  // fester Wert
    reportedBoolean: false | true       // false, wenn vom Ersteller des Planeintrags
    medicationReference.reference: Medikation mit PZN oder Magistrale Zubereitung // Contained Medication 
    authoredOn: Datum der Erstellung des Planeintrags    
    requester: veranwortlicher GDA      // wird auf Übereinstimmung mit List.source geprüft
    courseOfTherapyType: continuous | acute
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft)
```

<!-- TODO medicationReference.reference mit logical reference;  akl 29.09.2026 
- * medicationReference.reference = "Medication?code= https://termgit.elga.gv.at/CodeSystem/asp-liste|2450836" 
- muss PZN mit Displayname dokumentiert werden? wenn ja, muss geprüft werden. sonst durch Server ergänzt und zwecks Prüfung zurückgeben. -->



### Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern

Der GDA kann im Medikationsplan ein oder mehrere Planeinträge ändern. Dazu wird eine neue Version des Planeintrags erstellt.

Die Änderung des Planeintrags kann alle Inhalte umfassen, z.B.: Änderung des Status (pausieren/aktivieren), Änderung des Einnahmezeitraums, der Medikation oder der Dosierung. 
Bei fehlender fachlicher Kontinuität der Bearbeitung eines Planeintrages (z.B. Änderung des Arzneimittels von Blutdruckmittel auf Antibiotikum) muss ein neuer Planeintrag erfasst werden. 

#### Ablauf 

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Referenz auf den **geänderten** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html))
    - *List.entry.flag* des geänderten Planeintrags erhält den Wert ***changed*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* *MedicationRequest*-Ressource(n) bearbeiten: [AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html): 
    <!-- - *id*: bestehende *id* darf **nicht geändert** werden -->
    - *extension:effectiveDosePeriod*: ein optionales Einnahme-Enddatum darf nicht in der Vergangenheit liegen
    - *status* muss mit *active* oder *on-hold* dokumentiert werden (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag) und [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status))
    - *statusReason.coding* optionaler Grund für die Änderung (codiert oder Freitext)
    - alle weiteren Elemente analog zu *MedicationRequest*-Ressource(n) erstellen, siehe [Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen](Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen)


Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- alle geänderten *MedicationRequests* sind im Transaction Bundle enthalten


Anmerkung: Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) ändert die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) den Status der List.entry.flags von *changed* automatisch auf *unchanged*. 


#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird geändert
        flag: changed 
        item: Referenz auf den Planeintrag 1  // siehe "Relevante Elemente (MedicationRequest) Planeintrag 1"
    entry[1]:  // 2. Planeintrag bleibt unverändert
        flag: unchanged   
        item: Referenz auf den Planeintrag 2  
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    status: active | on-hold
    statusReason.coding: Grund der Änderung // optional
    [...]
    authoredOn: Datum der Änderung des Planeintrags    
    requester: für die Änderung verantwortlicher GDA 
    [...]
    priorPrescription: Referenz auf ersetzte Planeintragsversion
```
 <!-- statusReason.coding: prüfen ob nur bei stopped und entered-in-error möglich sein soll, Invariante TODO: akl 29.09.2026
 priorPrescription: Referenz auf ersetzte Planeintragsversion in Beispielen ergänzen! -->


### Sub_UC_eMed_02_04 - Planeintrag unverändert zur Kenntnis nehmen

Der GDA kann ein oder mehrere Planeinträge im Medikationsplan beibehalten und unverändert zur Kennntis nehmen. 
Bedingung dafür ist, dass der Einnahmezeitraum des im Planeintrag dokumentierten Arzneimittels noch nicht abgelaufen ist (siehe [Sub_UC_eMed_02_09 - Abgelaufenen Planeintrag weiterverordnen oder beenden](Sub_UC_eMed_02.html#sub_uc_emed_02_09---abgelaufenen-planeintrag-weiterverordnen-oder-beenden)).  
 

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Referenz auf den **unveränderten** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html))
    - *List.entry.flag* des unveränderten Planeintrags **bleibt** bei dem (von der Fachanwendung ausgelieferten Wert) ***unchanged*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* Die zu behaltenden Planeinträge ([AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html)) bleiben **unverändert**.

Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- die unveränderten Ressourcen sind nicht im Bundle enthalten, sondern werden in der Liste **nur referenziert**.


#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag bleibt unverändert
        flag: unchanged  // von der Fachanwendung gesetzt Wert bleibt unverändert
        item: Referenz auf den Planeintrag 1   // Ressource wird im Transaction Bundle nicht übermittelt
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    // unverändert (verantwortlicher GDA, Datum, Status der vorhergehenden Bearbeitung bleiben unverändert)
```

### Sub_UC_eMed_02_05 - Planeintrag pausieren oder reaktivieren

Ein GDA kann die Therapie eines Patienten vorübergehend unterbrechen, wenn eine Wiederaufnahme vorgesehen ist. Eine Begründung kann dokumentiert werden. Eine zukünftige geplante Unterbrechung kann nicht über den Status des list.entry.flags dokumentiert werden. 
<!-- , sondern nur über Dosierschemata.
TODO: Anja Dosierschemata prüfen + Link ergänzen akl 30.09.2026 -->

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Referenz auf den **pausierten** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html))
    - *List.entry.flag* des pausierten bzw. reaktiverten Planeintrags erhält den Wert ***changed*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* *MedicationRequest*-Ressource(n) bearbeiten: [AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html): 
    <!-- - *id*: bestehende *id* darf **nicht geändert** werden -->
    - *status* muss beim **Pausieren** mit *on-hold* und beim **Reaktivieren** mit *active* dokumentiert werden (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag) und [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status))
    - *statusReason.coding* kann **optional** mit einem Grund für die Pausierung als Code oder Freitext dokumentiert werden (siehe [ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html](AtElgaEmedValueSetPlaneintragStatusReasonVS)) 
    - opional können zusätzlich weitere Elemente geändert werden, siehe [Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern)

Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- alle geänderten Ressourcen sind inline im Bundle enthalten

Anmerkung: Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) ändert die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) den Status der List.entry.flags von *changed* automatisch auf *unchanged*. 


#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird pausiert
        flag: changed 
        item: Referenz auf den Planeintrag 1  
    entry[1]:  // 2. Planeintrag bleibt unverändert
        flag: unchanged 
        item: Referenz auf den Planeintrag 2  
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    status: Pausierung: on-hold | Aktivierung: active
    statusReason.coding: Grund der Pausierung (verplfichtend), Grund für Aktivierung (optional)
    [...]
    authoredOn: Datum der Änderung des Planeintrags    
    requester: für die Änderung verantwortlicher GDA 
    [...]
    priorPrescription: Referenz auf ersetzte Planeintragsversion
```
<!-- Grund für Aktivierung (optional) prüfen, akl 30.09.2026 -->



### Sub_UC_eMed_02_06 - Leeren Medikationsplan dokumentieren

Ein GDA kann explizit dokumentieren, dass für den Patienten derzeit **keine Medikation vorgesehen** ist.

#### Ablauf 

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

Die Vorgehensweise unterscheidet sich je nach Inhalt des Medikationspans:
1. der Medikationsplan ist leer: 
* A. er befindet sich noch im **Initialzustand** mit *List.emptyReason = notstarted* oder 
* B. er ist **nach dem Absetzen oder Stornieren aller Planeinträge** leer mit *List.emptyReason = unavailable*
* In beiden Fällen erstellt der GDA eine neue Planversion mit *List.emptyReason = nilknown* und übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html)
2. es bestehen Planeinträge: der GDA
* **beendet** (siehe [Sub_UC_eMed_02_08 - Planeintrag im Medikationsplan beenden](Sub_UC_eMed_02.html#sub_uc_emed_02_08---planeintrag-im-medikationsplan-beenden)) und/oder
* **storniert** (siehe [Sub_UC_eMed_02_07 - Planeintrag im Medikationsplan stornieren](Sub_UC_eMed_02.html#sub_uc_emed_02_07---planeintrag-im-medikationsplan-stornieren))

sämtliche Planeinträge. Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html) erkennt die Fachanwendung diesen Zustand und liefert den Medikationsplan mit *List.emptyReason = unavailable* aus. Optional kann der GDA nun explizit einen leeren Plan dokumentieren (siehe 1.B).

<!-- (TODO: Invariante zur Überprüfung) -->

#### Relevante Elemente (List) (1.A + 1.B)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    emptyReason: nilknown   // Patient soll keine Medikation einnehmen
```

### Sub_UC_eMed_02_07 - Planeintrag im Medikationsplan stornieren

Der GDA kann einen oder mehrere Planeinträge aufgrund einer falschen Eingabe stornieren. Ein Grund ist verpflichtend anzugeben.

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Referenz auf den **stornierten** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html))
    - *List.entry.flag* des stornierten Planeintrags erhält den Wert ***removed*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* *MedicationRequest*-Ressource(n) bearbeiten: [AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html): 
    <!-- - *id*: darf **nicht geändert** werden -->
    - *status* muss mit ***entered-in-error*** dokumentiert werden (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag) und [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status))
    - *statusReason.coding* muss **verpflichend** mit einem Grund für die Stornierung als Code oder Freitext dokumentiert werden (siehe [ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html](AtElgaEmedValueSetPlaneintragStatusReasonVS))

Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- alle zu entfernenden *MedicationRequests* sind im Transaction Bundle enthalten

Anmerkung: Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) entfernt die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) die mit *removed* gekennzeichneten Einträge automatisch aus dem Mediaktionsplan. 

#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird storniert
        flag: removed 
        item: Referenz auf den Planeintrag 1  // siehe "Relevante Elemente (MedicationRequest - Planeintrag 1)"
    entry[1]:  // 2. Planeintrag bleibt unverändert
        flag: unchanged 
        item: Referenz auf den Planeintrag 2  
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    status: entered-in-error
    statusReason.coding: Grund für die Stornierung  // verpflichtend
    [...]
    authoredOn: Datum der Stornierung  
    requester: für die Stornierung verantwortlicher GDA 
    [...]
    priorPrescription: Referenz auf ersetzte Planeintragsversion
```


### Sub_UC_eMed_02_08 - Planeintrag im Medikationsplan beenden 

Der GDA kann eine Medikation, welche in einen Planeintrag dokumentiert ist, beenden. Es wird keine Unterscheidung getroffen, ob die Medikation regulär abgeschlossen oder vorzeitig beendet wird. Ein Grund ist verpflichtend anzugeben.

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Referenz auf den **beendeten** Planeintrag ([MedicationRequests](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html))
    - *List.entry.flag* des beendeten Planeintrags erhält den Wert ***removed*** (siehe [Statusdiagramm](workflowmanagement.html#status-des-listentryflags-im-medikationsplan))

* *MedicationRequest*-Ressource(n) bearbeiten: [AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html): 
    <!-- - *id*: darf **nicht geändert** werden -->
    - *status* muss mit ***stopped*** dokumentiert werden (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag) und [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status))
    - *statusReason.coding* muss **verpflichend** mit einem Grund für die Beendigung als Code oder Freitext dokumentiert werden (siehe [ValueSet-AtElgaEmedValueSetPlaneintragStatusReasonVS.html](AtElgaEmedValueSetPlaneintragStatusReasonVS)) 

Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- alle zu beendeten *MedicationRequests* sind im Transaction Bundle enthalten


Anmerkung: Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) entfernt die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) die mit *removed* gekennzeichneten Einträge automatisch aus dem Mediaktionsplan. 


#### Relevante Elemente (List)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird beendet
        flag: removed 
        item: Referenz auf den Planeintrag 1  // siehe "Relevante Elemente (MedicationRequest - Planeintrag 1)"
    entry[1]:  // 2. Planeintrag bleibt unverändert
        flag: unchanged 
        item: Referenz auf den Planeintrag 2  
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    status: stopped
    statusReason.coding: Grund für das Beenden  // verpflichtend
    [...]
    authoredOn: Datum der Beendigung  
    requester: für die Beendigung verantwortlicher GDA 
    [...]
    priorPrescription: Referenz auf ersetzte Planeintragsversion
```

### Sub_UC_eMed_02_09 - Abgelaufenen Planeintrag weiterverordnen oder beenden 

Planeinträge mit abgelaufenem Einnahmezeitraum (überschrittenes Enddatum in *extension:effectiveDosePeriod*) werden im von der Fachanwendung ausgelieferten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) automatisch mit *List.entry.flag = removed* und *MedicationRequest.status = stopped* markiert.

1.A Möchte der GDA die Einnahme **weiterverordnen**, muss er entsprechende Anpassungen vornehmen (siehe [Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern](Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern)).

1.B Soll die Einnahme **nicht weiterverordnet** werden, nimmt der GDA **keine Änderung** am List.entry.flag und dem abgelaufenen Planeintrag vor (auch kein Beendigungsgrund und keine Aktualisierung des GDAs im Planeintrag). 

Er übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html): 
- alle geänderten Ressourcen (inkl. der beendeten) sind inline im Bundle enthalten

Beim nächsten [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) entfernt die Fachanwendung im zur Auslieferung bereitgestellten [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) die mit *removed* gekennzeichneten Einträge automatisch aus dem Mediaktionsplan. 


#### Relevante Elemente (List) (1.B)

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]:  // 1. Planeintrag wird entfernt
        flag: removed 
        item: Referenz auf den Planeintrag 1  // siehe "Relevante Elemente (MedicationRequest - Planeintrag 1)"
    entry[1]:  // 2. Planeintrag bleibt unverändert
        flag: unchanged   
        item: Referenz auf den Planeintrag 2  
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    extension:effectiveDosePeriod: liegt in der Vergangenheit         // bleibt unverändert
    status: stopped                        // von Fachanwendung gesetzt, bleibt unverändert
    statusReason.coding: Grund für die vorhergehende Statunsänderung  // bleibt unverändert
    [...]
    authoredOn: Datum der vorhergehenden Bearbeitung                  // bleibt unverändert 
    requester: für die vorhergehende Bearbeitung verantwortlicher GDA  // bleibt unverändert 
    [...]
    priorPrescription: Referenz auf ersetzte Planeintragsversion
```
<!-- Todo: Prüfen, ob diese Annahmen korrekt sind, akl 30.0.2026 -->


### Sub_UC_eMed_02_10 - Reihenfolge der Planeinträge ändern

Der GDA kann die Reihenfolge der Planeinträge ändern. Die Einträge selbst bleiben dabei unverändert.
Der Einnahmezeitraum der im Planeintrag dokumentierten Arzneimittel darf noch nicht abgelaufen sein (siehe [Sub_UC_eMed_02_09 - Abgelaufenen Planeintrag weiterverordnen oder beenden](Sub_UC_eMed_02.html#sub_uc_emed_02_09---abgelaufenen-planeintrag-weiterverordnen-oder-beenden)). 

#### Ablauf

Der GDA führt ein **POST** [$plan-read](OperationDefinition-AtElgaEmed.List.Planread.html) aus und bearbeitet die von der Fachanwendung im [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) bereitgestellten Ressourcen:

* *List*-Ressource bearbeiten: [AtElgaEmedListMedikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html):
    - *List.source* wird mit dem aktuellen GDA, *List.date* aktualisiert.
    - *List.entry*: Die Reihenfolge der Planeinträge wird angepasst, indem die Entries entsprechend gereiht werden.
    - *List.entry.flag* bereits bestehender Einträge bleibt unverändert (*unchanged*), sonst entsprechend des Use Cases. 

* Die zu behaltenden Planeinträge ([AtElgaEmedMedicationRequestPlaneintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html)) bleiben **unverändert**.

Der GDA übermittelt mit **POST** [$plan-write](OperationDefinition-AtEmed.List.PlanWrite.html) den aktualisierten Medikationsplan in einem [Transaction Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplantx.html):
- die unveränderten Ressourcen sind nicht im Bundle enthalten, sondern werden in der Liste nur referenziert
- neue oder geänderte Ressourcen sind im Transaction Bundle enthalten,

#### Relevante Elemente (List)

In folgendem Beispiel wird der ursprünglich 2. Eintrag als 1. gereiht. Beider Planeinträge wurden nicht geändert.

```JSON
AtElgaEmedListMedikationsplan
    date: Datum der aktuellen Bearbeitung des Medikationsplans
    source: für die Bearbeitung veranwortlicher GDA 
    entry[0]: // 2. Planeintrag 
        flag: unchanged 
        item: Referenz auf den Planeintrag 2 
    entry[1]: // 1. Planeintrag
        flag: unchanged 
        item: Referenz auf den Planeintrag 1 
```

#### Relevante Elemente (MedicationRequest - Planeintrag 1 und 2)

```JSON
AtElgaEmedMedicationRequestPlaneintrag
    // unverändert (verantwortlicher GDA, Datum, Status bleiben unverändert)
```


### Sub_UC_eMed_02_11 - Planeintrag durch ELGA-Teilnehmer löschen

<div class="dragon">
<p class="note-to-balloters">
Offene Fragen:
Ausüben der Teilnehmerrechte in Arbeit.
</p>
</div>

<!-- TODO: stand 7.9.2026:
Beim Löschen eines Planeintrags werden alle Planeintragsversionen gelöscht.
Alle auf den Planeintrag referenzierende Ressourcen enthalten somit tote Links.
Evtl Code "Data Absent Reason" (Anja?) für patient modified.
Autor der Liste könnte dann GDA bleiben vs. Patient wird Autor. -->

<!-- Der:die ELGA-Teilnehmer:in kann via Zugangsportal in der **aktuellen Version** seines:ihres Medikationsplans einzelne oder alle Planeinträge unwiderruflich löschen. Durch das Löschen wird durch die Fachanwendung eine neue Medikationsplanversion erzeugt. Wurden alle Planeinträge gelöscht, erhält die neue Medikationsplanversion das emptyReason *nilknown* (siehe [Sub_UC_eMed_02_02 - Leerer Medikationsplan (keine Medikation einnehmen)](Sub_UC_eMed_02.html#Sub_UC_eMed_02_02---leerer-medikationsplan-keine-medikation-einnehmen)).

Hierfür ruft der:die ELGA-Teilnehmer:in zunächst den aktuellen Medikationsplan mittels *$plan-read* ab und wählt die zu löschenden Planeinträge aus. 
Das Zugangsportal erstellt anschließend ein Transaction-Bundle und:
- aktualisiert *List.source* mit dem:der ELGA-Teilnehmer:in und *List.date*,
- entfernt die zu löschenden Planeinträge aus List.entry,
- referenziert unveränderte Ressourcen weiterhin über ihre Referenzen und
- enthält für jeden zu löschenden MedicationRequest einen DELETE-Request.

Das Transaction Bundle wird mittels POST *$plan-write* an die Fachanwendung übermittelt. Bei erfolgreicher Prüfung erzeugt und persistiert die Fachanwendung daraus eine neue Medikationsplanversion und führt die DELETE-Requests aus. Die betreffenden *MedicationRequest*-Ressourcen einschließlich ihrer versionierten Ausprägungen werden dadurch vollständig gelöscht.

Im Unterschied zum *Stornieren* oder *Beenden* durch den GDA wird der Planeintrag somit vollständig aus *List.entry* entfernt und die zugehörige *MedicationRequest* nicht lediglich als *removed* gekennzeichnet.

Historische Medikationsplanversionen oder bestehende *Geplante* bzw. *Durchgeführte Abgaben* können weiterhin Referenzen auf die gelöschten Planeinträge enthalten. Diese Referenzen sind nach dem vollständigen Löschen der MedicationRequest nicht mehr auflösbar. -->

<!--TODO: 
- kein Löschen von Planeinträgen in historischen Medikationsplaneinträgen! Planeinträge, die ausschließlich in historischen Medikationsplanversionen enthalten sind, können durch die Löschung der / aller historischen Medikationsplanversion/en gelöscht werden, die den Planeintrag referenzieren (siehe Sub_UC_eMed_02_12 - Medikationsplan durch ELGA-Teilnehmer löschen). Ist das möglich? Planeinträge referenzieren nicht den Medikationsplan ...
- kein Löschen von Planeinträgen nach einem *Planentry-Search* anhand geeigneter Suchkriterien? :
- Planentry-Search kann zwar über alle Planeinträge ausgeführt werden, es können aber nur jene, die in der aktuellen Planversion enthalten sind, gelöscht werden. Wie sollte das festgestellt werden, ob sie im aktuellen Plan enthalten sind, ohne gleich den ganzen Plan zu lesen?
- Planentry-Search liefert nur ein Search-Result Bundle mit MedicationRequests, also muss ohnehin auch ein Plan-Read erfolgen, weil ja auch ein patient-plan-write erfolgen muss.
-->

<!-- 

#### Relevante Elemente (List)

Zustand **vor dem Löschen** des 2. Planeintrags (Ergebnis von $plan-read):

```JSON
AtElgaEmedListMedikationsplan
    status: current
    mode: working
    date: Datum der vorhergehenden Bearbeitung des Medikationsplans
    source: veranwortlicher GDA der vorhergehenden Bearbeitung
    entry[0]:  
        flag: unchanged
        item: Referenz auf den Planeintrag 1  
    entry[1]:  
        flag: unchanged
        item: Referenz auf den Planeintrag 2  
```

Zustand **nach dem Löschen** des 2. Planeintrags (*List*-Ressource im Transaction Bundle von $patient-plan-write):

```JSON
AtElgaEmedListMedikationsplan
    status: current
    mode: working
    date: Datum des Löschens des Medikationsplans durch den:die ELGA-Teilnehmer:in
    source: ELGA-Teilnehmer:in
    entry[0]:  // 1. Planeintrag bleibt unverändert
        flag: unchanged
        item: Referenz auf den Planeintrag 1  
```

<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Fragen:
Gelöschte Planeinträge können von historischen Planversionen oder bestehenden Geplanten bzw. durchgeführten Abgaben referenziert werden. Diese Referenzen sind nach dem Löschen nicht mehr auflösbar. 
 - Mögliche Lösung: Vor dem Löschen prüfen, ob der Planeintrag von anderen Medikationsplanversionen, geplanten oder durchgeführten Abgaben referenziert wird, und gegebenenfalls eine Bestätigung des:der ELGA-Teilnehmers:in einholen.
</p>
</div> -->


### Sub_UC_eMed_02_12 - Medikationsplan durch ELGA-Teilnehmer löschen

<div class="dragon">
<p class="note-to-balloters">
Offene Fragen:
Ausüben der Teilnehmerrechte in Arbeit.
</p>
</div>


<!-- stand 25.9.: Wird die aktuelle Version vollständig gelöscht, wird ein leerer Medikationsplan zur neuen aktuellen Version.

alt:

Der:die ELGA-Teilnehmer:in kann über das Zugangsportal die *aktuelle Medikationsplanversion* sowie *einzelne oder mehrere historische Medikationsplanversionen* unwiderruflich löschen.

Hierfür muss der:die ELGA-Teilnehmer:in zunächst mittels *Plan-History-Search* oder *Plan-History-Directory-Search* über das Zugangsportal die betreffenden Medikationsplanversionen bzw. deren Identifikatoren ermitteln.
Anschließend markiert der:die ELGA-Teilnehmer:in die zu löschenden Medikationsplanversionen und führt über das Zugangsportal ein $plan-delete aus.

Beim Löschen einer Medikationsplanversion wird die betreffende *List*-Ressource gelöscht, einschließlich auch die von der Medikationsplanversion referenzierten versionierten Planeinträge (*MedicationRequest*-Ressourcen). 

<!-- TODO: stand 7.9.2026: Wird der aktuelle Plan gelöscht, ist das Ergebnis ein leerer Plan mit Status notstarted. Autor Patient oder Fachanwendung? -->


<!-- <div class="dragon">
<p class="note-to-balloters">
Offene Fragen zur Löschlogik:
- Sollen beim Löschen einer Medikationsplanversion auch die darin referenzierten Planeinträge gelöscht werden, wenn sie von einer anderen, weiterhin bestehenden Medikationsplanversion oder von Geplanten bzw. Durchgeführten Abgaben referenziert werden? Die Referenz wäre dann nicht mehr auflösbar.
Mögliche Lösung: Vor dem Löschen prüfen, ob die referenzierten Planeinträge von anderen Ressourcen referenziert werden, und gegebenenfalls eine Bestätigung des:der ELGA-Teilnehmers:in einholen.
- Was geschieht beim Löschen der aktuellen Medikationsplanversion? Wird die zuvor zuletzt gespeicherte Medikationsplanversion wieder zur aktuellen Version oder beginnt der:die ELGA-Teilnehmer:in mit einem leeren Medikationsplan (emptyReason = notstarted)?
</p>
</div> -->