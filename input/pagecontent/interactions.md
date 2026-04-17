{% include styleheader.md %}

<!-- Zugriffsarten auf den Medikationsplan -->

Im Folgenden werden standardisierte Interaktionen für den lesenden und schreibenden Zugriff auf den Medikationsplan eines Patienten bzw. einer Patientin erläutert, die für alle technischen Use Cases relevant sind.

### Read-only-Zugriff

Beim Read-only-Zugriff stellt die Fachanwendung den aktuellen Medikationsplan (zuletzt gespeichertes Collection Bundle inkl. aller referenzierten Ressourcen) **unverändert** bereit.


#### Ablauf

1. Der GDA führt ein **GET** auf das Collection Bundle aus, das den Medikationsplan mit allen zugehörigen relevanten Ressourcen enthält.
2. Die Fachanwendung prüft, ob ein Medikationsplan für den/die Patient:in existiert.
3. Ist **kein Medikationsplan vorhanden**, wird ein **leeres Ergebnis** zurückgegeben.
4. Ist ein Medikationsplan vorhanden, wird das zuletzt gespeicherte Collection Bundle zurückgeliefert. <br>
Das **Collection Bundle** enthält:<br>
* die List-Ressource des Medikationsplans <br>
* alle referenzierten Ressourcen (z. B. MedicationRequest, Patient, Practitioner) vollständig (inline)

Beim Read-only-Zugriff erfolgt **keine Veränderung** von Flags, Status oder Inhalten durch die Fachanwendung.
Der Zugriff dient ausschließlich der Anzeige bzw. Informationsabfrage.

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
5. Existiert bereits ein Medikationsplan (d.h. es wurde bereits ein Collection Bundle persistiert), wird von der Fachanwendung aus diesem ein **Collection Bundle zur Auslieferung** erstellt:<br>
* mit einem neuen oder bereits temporär gespeicherten **List.identifier** (wird von der Fachanwendung zur späteren Integritätsprüfung beim Schreibvorgang verwaltet)<br>
* die Inhalte werden von der Fachanwendung wie folgt aufbereitet:<br>
    * Wenn ein List.entry.flag den Status **new** oder **changed** hat, wird dieser auf **unchanged** gesetzt.<br>
    * Wenn ein List.entry.flag den Status **removed** hat, wird der Eintrag aus der Liste **entfernt**.<br>
    * Einträge mit abgelaufenem Behandlungszeitraum bleiben erhalten. <br>
    <!-- * fachlich zu prüfen (TODO): Einträge mit abgelaufenem Behandlungszeitraum und courseOfTherapyType **acute** automatisch entfernen -->
6. Die Fachanwendung liefert das **Collection Bundle** an den GDA:<br>
* inkl. List und aller referenzierten Ressourcen (inline)<br>
* ergänzt um den List.identifier<br>
* Ziel ist ein neutraler, weiterbearbeitbarer Zustand für den abrufenden GDA<br>
7. Der GDA bearbeitet den Medikationsplan (er fügt Einträge hinzu, ändert bestehende oder entfernt diese).

Der temporär gespeicherte List.identifier für die Integritätsprüfung beim Schreibvorgang wird von der Fachanwendung separat von den FHIR Ressourcen verwaltet.


#### Custom Operations

[$readtowrite](OperationDefinition-AtEmed.List.ReadtoWrite.html)

### Write-Zugriff

Der Write-Zugriff ist eine eigenständige Operation, die ausschließlich im Kontext eines **zuvor ausgeführten** [Read-to-Write-Zugriffs](interactions.html#read-to-write-zugriff) erfolgen darf.

#### Ablauf

<ol start="8">
<li>1 bis 7 siehe vorhergehender <em>Read-to-Write-Zugriff</em><br></li>
<li>Der GDA übermittelt via <a href="interactions.html#custom-operations-1">POST $write</a> den aktualisierten Medikationsplan als <strong>Transaction Bundle</strong>:<ul>
<li>alle <strong>neuen und geänderten Ressourcen</strong> sind <strong>inline</strong> im Bundle enthalten</li>
<li>alle unveränderten Ressourcen werden nur referenziert<br></li>
</ul>
</li>
<li>Die Fachanwendung prüft, ob der übermittelte <strong>List.identifier</strong> mit dem List.identifier der temporär gespeicherten Medikationsplanversion <strong>übereinstimmt</strong> (d.h. es wurde zwischenzeitlich kein anderer Schreibvorgang durchgeführt)<br></li>
<li>Stimmt der List.identifier nicht überein, lehnt die Fachanwendung das Speichern des Medikationsplans ab.<br><ul>
<li>Es muss erneut ein Read-to-Write ausgeführt werden und die Aktualisierungen übernommen werden bzw. Fehler behoben werden, bevor ein neuerlicher Speicherversuch vorgenommen werden kann.<br></li>
</ul>
</li>
<li>Wenn kein Fehler auftritt, validiert die Fachanwendung den neuen Plan und stellt sicher, dass keine unzulässigen Zustandsübergänge vorgenommen wurden.<br></li>
<li>Bei erfolgreicher Prüfung:<br><ul>
<li>werden die übermittelten Änderungen in die Ressourcen übernommen und</li>
<li>der <strong>neue Medikationsplan persistiert</strong> (Collection Bundle)<br></li>
</ul>
</li>
<li>Der GDA erhält eine Meldung, dass der Medikationsplan erfolgreich aktualisiert wurde.</li>
</ol>

<br>
<div>{% include diagram_readtowrite.svg %}</div>
<br>

<!-- TODO: Evtl. 2 Versionen: eine ungefiliterte Version (inkl. der seit dem letzten Speichern abgelaufener Einträge) und eine Version nur mit aktiven Einträgen/gültigem Behandlungszeitraum -->

#### Custom Operations

[$write](OperationDefinition-AtEmed.List.Write.html)

#### Abgelehnter Write-Zugriff

1. bis 5. wie *Read-to-Write-Zugriff*<br>
6. GDA 2 führt ein [POST $readtowrite](interactions.html#custom-operations) auf den Medikationsplan aus, während GDA 1 das von der Fachanwendung übermittelte Collection Bundle bearbeitet.<br>
7. bis 9. GDA 2 erhält dasselbe Collection Bundle (mit demselben temporären List.identifier), das zuvor bereits GDA 1 übermittelt wurde.
10. GDA 2 bearbeitet zeitgleich mit GDA 1 den Medikationsplan.
11. GDA 2 sendet zuerst mittels <a href="interactions.html#custom-operations-1">POST $write</a> ein Transaction Bundle mit dem aktualisierten Medikationsplan. 
12. Die Fachanwendung prüft, ob der temporär in der Fachanwendung vorgehaltene List.identifier mit dem im Transaction Bundle verwendeten List.identifier übereinstimmt. 
13. Die Prüfung verläuft erfolgreich, der neue Medikationsplan wird gespeichert.
14. Die Fachanwendung löscht den temporären List.identifier.
15. GDA 2 erhält eine Meldung, dass der Medikationsplan erfolgreich aktualisiert wurde.
16. GDA 1 sendet mittels <a href="interactions.html#custom-operations-1">POST $write</a> ein Transaction Bundle mit dem aktualisierten Medikationsplan. 
17. Die Prüfung auf Übereinstimmung des von GDA 1 verwendeten List.identifier und dem von der der Fachanwendung vorgehaltenen temporären identifer schlägt fehl.
18. Die Fachanwendung lehnt das Speichern ab.
19. GDA 1 erhält eine Fehlermeldung und muss ein erneutes Read-to-Write ausführen, welches das Generieren eines zur Auslieferung bereitgestellten temporären Collection Bundles inkl. neuem List.identifiers auslöst.

<br>
<div>{% include diagram_write_error.svg %}</div>
<br>


