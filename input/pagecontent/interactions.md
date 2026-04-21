{% include styleheader.md %}

<!-- Zugriffsarten auf den Medikationsplan -->

Im Folgenden werden standardisierte Interaktionen für den lesenden und schreibenden Zugriff auf den Medikationsplan eines Patienten bzw. einer Patientin erläutert, die für alle technischen Use Cases relevant sind.

### Read-only-Zugriff

Beim Read-only-Zugriff stellt die Fachanwendung **die aktuelle oder historische Versionen** des Medikationsplans (persistierte Collection Bundles inkl. aller referenzierten Ressourcen) **unverändert** bereit.


#### Ablauf

1. Der GDA führt ein **GET** auf das Collection Bundle aus, das den Medikationsplan mit allen zugehörigen relevanten Ressourcen enthält.
2. Die Fachanwendung prüft, ob ein Medikationsplan für den/die Patient:in existiert.
3. Ist **kein Medikationsplan vorhanden**, wird ein **leeres Ergebnis** zurückgegeben.
4. Ist ein Medikationsplan vorhanden, wird das zuletzt gespeicherte Collection Bundle zurückgeliefert. <br>
Das **Collection Bundle** enthält:<br>
* die List-Ressource des Medikationsplans <br>
* alle referenzierten Ressourcen (z. B. MedicationRequest, Patient, Practitioner) vollständig (inline)

Beim Read-only-Zugriff erfolgt **keine Veränderung** von Flags, Status oder Inhalten durch die Fachanwendung.<br>
Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage von aktuellen bzw. historischen Planversionen.

#### Sequenzdiagramm Read-only-Zugriff
<br>
<div>{% include diagram_read.svg %}</div>
<br>

**Beispiele für Zugriffe mittels Suchparameter:**
* **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH}
* **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH}
* Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum gespeichert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind: GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed  (TODO query prüfen)

### Read-to-Write-Zugriff

Der Read-to-Write-Zugriff dient dem **Abruf des Medikationsplans und der Vorbereitung einer nachfolgenden Änderung**.

#### Ablauf

1. Der GDA führt ein [POST $readtowrite](interactions.html#custom-operations) auf das Collection Bundle aus, das den Medikationsplan mit allen zugehörigen relevanten Ressourcen enthält.
2. Die Fachanwendung prüft, ob ein Medikationsplan für den/die Patient:in existiert.
3. Ist **kein Medikationsplan vorhanden**, wird dieser erstellt (siehe [Sub_UC_06_01 - Initial erstellter Medikationsplan](Sub_UC_eMed_06.html#sub_uc_06_01---initial-erstellter-medikationsplan)) und 
4. ein leerer Medikationsplan mit dem emptyReason *notstarted* wird zurückgeliefert.
5. Existiert bereits ein Medikationsplan (d.h. es wurde bereits ein Collection Bundle persistiert), wird von der Fachanwendung aus diesem ein **Collection Bundle zur Auslieferung** bereitgestellt:<br>
* mit einem neuen oder bereits temporär gespeicherten **List.identifier** (wird von der Fachanwendung zur späteren Integritätsprüfung beim Schreibvorgang verwaltet)<br>
* Die Inhalte werden von der Fachanwendung wie folgt aufbereitet:<br>
    * Falls der vorherige GDA neue Medikationsplaneinträge hinzugefügt oder bestehende geändert hat (List.entry.flag haben den Wert **new** oder **changed**), werden diese auf **unchanged** gesetzt.<br>
    * Falls der vorherige GDA Medikationsplaneinträge beendet hat (deren List.entry.flag haben den Wert **removed**), werden diese Einträge aus der Liste **entfernt**.<br>
    * Falls der vorherige GDA **alle vorhandenen Einträge** mit removed gekennzeichnet hat, wird List.emptyReason mit *nilknown* zurückgeliefert, um nachfolgenden GDA zu signalisieren, dass der Patient zum Zeitpunkt des letzten Schreibens keine Medikamente eingenommen hat bzw. einnehmen sollte.<br>
    * Einträge mit abgelaufenem Behandlungszeitraum bleiben erhalten.<br>
    <!-- * fachlich zu prüfen (TODO): Einträge mit abgelaufenem Behandlungszeitraum und courseOfTherapyType **acute** automatisch entfernen -->
6. Die Fachanwendung liefert das **Collection Bundle** an den GDA:<br>
* inkl. List und aller referenzierten Ressourcen (inline)<br>
* ergänzt um den List.identifier<br>
* Ziel ist ein neutraler, weiterbearbeitbarer Zustand für den abrufenden GDA<br>
7. Der GDA bearbeitet den Medikationsplan (er fügt Einträge hinzu, ändert bestehende oder entfernt diese).

Der temporär gespeicherte List.identifier für die Integritätsprüfung beim Schreibvorgang wird von der Fachanwendung separat von den FHIR Ressourcen verwaltet.


#### Custom Operations

[$readtowrite](OperationDefinition-AtEmed.List.Readtowrite.html)


#### Sequenzdiagramm Read-to-Write-Zugriff
<br>
<div>{% include diagram_readtowrite.svg %}</div>
<br>


### Write-Zugriff

Der Write-Zugriff ist eine eigenständige Operation, die ausschließlich im Kontext eines **zuvor ausgeführten** [Read-to-Write-Zugriffs](interactions.html#read-to-write-zugriff) erfolgen darf.

#### Ablauf

1. Der GDA übermittelt via [POST $write](interactions.html#custom-operations-1) den aktualisierten Medikationsplan als **Transaction Bundle**:
* alle **neuen und geänderten und zu entfernenden Ressourcen** sind **inline** im Bundle enthalten,
* alle unveränderten Ressourcen werden nur referenziert.
2. Die Fachanwendung prüft, ob der übermittelte **List.identifier** mit dem List.identifier der temporär gespeicherten Medikationsplanversion **übereinstimmt** (d.h. es wurde zwischenzeitlich kein anderer Schreibvorgang durchgeführt).
3. Stimmt der List.identifier nicht überein, lehnt die Fachanwendung das Speichern des Medikationsplans ab.
Es muss erneut ein Read-to-Write ausgeführt werden und die Aktualisierungen übernommen werden bzw. Fehler behoben werden, bevor ein neuerlicher Speicherversuch vorgenommen werden kann.
4. Wenn kein Fehler auftritt, validiert die Fachanwendung den neuen Plan und stellt sicher, dass keine unzulässigen Zustandsübergänge vorgenommen wurden.
5. Bei erfolgreicher Prüfung:
* werden die übermittelten Änderungen in die Ressourcen übernommen.
* Auf Basis der aktualisierten Ressourcen erstellt die Fachanwendung ein neues Collection Bundle, das als **neuer Medikationsplan persistiert** wird.
6. Der GDA erhält eine Meldung, dass der Medikationsplan erfolgreich aktualisiert wurde.


#### Custom Operations

[$write](OperationDefinition-AtEmed.List.Write.html)


#### Sequenzdiagramm Write-Zugriff
<br>
<div>{% include diagram_write.svg %}</div>
<br>

<!-- TODO: Evtl. 2 Versionen: eine ungefiliterte Version (inkl. der seit dem letzten Speichern abgelaufener Einträge) und eine Version nur mit aktiven Einträgen/gültigem Behandlungszeitraum -->


#### Abgelehnter Write-Zugriff

#### Ablauf


1. **GDA 1** möchte den Medikationsplan seiner Patientin bearbeiten und führt ein [POST $readtowrite](interactions.html#custom-operations) auf das Collection Bundle des Medikationsplans aus.
2. Die Fachanwendung prüft, ob ein Medikationsplan für den/die Patient:in existiert (siehe [Read-to-Write-Zugriff](interactions.html#read-to-write-zugriff)). Annahme: Es ist bereits ein Medikationsplan vorhanden. 
3. Die Fachanwendung erstellt ein **Collection Bundle zur Auslieferung** (siehe [Read-to-Write-Zugriff](interactions.html#read-to-write-zugriff)) mit dem temporären **List.identifier** "123"
4. Die Fachanwendung liefert das Collection Bundle an den GDA 1.
5. GDA 1 bearbeitet den Medikationsplan.
6. **GDA 2** führt ein POST $readtowrite auf den Medikationsplan aus, während GDA 1 das von der Fachanwendung übermittelte Collection Bundle bearbeitet.
7. Die Fachanwendung prüft erfolgreich, ob ein Medikationsplan für den/die Patient:in existiert. 
8. Die Fachanwendung erstellt, genau wie für GDA 1, ein **Collection Bundle zur Auslieferung** (siehe [Read-to-Write-Zugriff](interactions.html#read-to-write-zugriff)) mit dem temporären **List.identifier** "123"
9. Die Fachanwendung liefert das Collection Bundle an den GDA 2.
10. GDA 2 **bearbeitet zeitgleich** mit GDA 1 den Medikationsplan.
11. **GDA 2 sendet zuerst** mittels POST $write ein Transaction Bundle mit dem aktualisierten Medikationsplan.12. Die Fachanwendung prüft, ob der temporär in der Fachanwendung vorgehaltene **List.identifier** mit dem im Transaction Bundle verwendeten List.identifier **übereinstimmt**. Beide haben den Wert "123".
13. Die Fachanwendung validert den neuen Plan (keine unzulässigen Zustandsübergänge)
14. Die Prüfung verläuft erfolgreich, der **neue Medikationsplan** mit List.identifier "123" wird **persistiert**.
15. Die Fachanwendung **löscht** den **temporären List.identifier** "123".
16. GDA 2 erhält eine Meldung, dass der Medikationsplan erfolgreich aktualisiert wurde.
17. GDA 1 sendet mittels POST $write ein Transaction Bundle mit dem aktualisierten Medikationsplan mit List.identifier "123".
18. Die Prüfung auf Übereinstimmung des von GDA 1 verwendeten List.identifier und dem von der der Fachanwendung vorgehaltenen temporären identifer schlägt fehl.
19. Die Fachanwendung **lehnt das Speichern ab**.
20. GDA 1 erhält eine **Fehlermeldung** und muss ein erneutes Read-to-Write ausführen, welches das Generieren eines zur Auslieferung bereitgestellten temporären Collection Bundles inkl. neuem List.identifiers auslöst.


#### Sequenzdiagramm Abgelehnter Write-Zugriff
<br>
<div>{% include diagram_write_error.svg %}</div>
<br>


