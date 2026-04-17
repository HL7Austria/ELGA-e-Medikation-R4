{% include styleheader.md %}

<!-- Zugriffsarten auf den Medikationsplan -->

Im Folgenden werden standardisierte Interaktionen für den lesenden und schreibenden Zugriff auf den Medikationsplan eines Patienten bzw. einer Patientin erläutert, die für alle technischen Use Cases relevant sind.

### Read-only-Zugriff

Beim Read-only-Zugriff stellt die Fachanwendung den aktuellen Medikationsplan (zuletzt gespeichertes Collection Bundle inkl. aller referenzierten Ressourcen) **unverändert** bereit.


#### Ablauf

1. Der GDA führt ein GET auf das Collection Bundle des Medikationsplans aus.
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

**Beispiele für Zugriffe mittels Suchparameter**
* **Aktuelle Planversion** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_count=1&_sort=-timestamp&list.subject={bPK-GH}
* **Alle Planversionen** mit dem Suchparameter Patient abrufen: GET [base]/Bundle?type=collection&_sort=-timestamp&list.subject={bPK-GH}
* Abfrage aller **historischen Medikationsplan-Versionen** eines Patienten, die nach dem angegebenen Datum gespeichert wurden und Plan-Einträge enthalten, die als **storniert, beendet oder abgesetzt** gekennzeichnet sind:
    * GET [base]/Bundle?type=collection&_sort=-timestamp&timestamp=ge2025-01-01&list.subject={bPK-GH}&list.entry.flag=removed  (TODO query prüfen)

### Read-to-Write-Zugriff

Der Read-to-Write-Zugriff dient dem Abruf des Medikationsplans und der Vorbereitung einer nachfolgenden Änderung.

* Bei einem Read-to-Write-Zugriff prüft die Fachanwendung zunächst, ob bereits ein Medikationsplan vorhanden ist. Ist dies nicht der Fall, wird dieser erstellt (siehe [Sub_UC_06_01 - Initial erstellter Medikationsplan](Sub_UC_eMed_06.html#sub_uc_06_01---initial-erstellter-medikationsplan)) und zurückgeliefert.

* Existiert bereits ein Medikationsplan (d.h. es wurde bereits ein Collection Bundle persistiert), wird von der Fachanwendung aus diesem ein **Collection Bundle zur Auslieferung** erstellt: 
    * mit einem neuen oder bereits temporär gespeicherten **List.identifier** (wird von der Fachanwendung zur späteren Integritätsprüfung beim Schreibvorgang verwaltet)
    * die Inhalte werden von der Fachanwendung wie folgt aufbereitet:
        * Wenn ein List.entry.flag den Status **new** hat, wird dieser auf **unchanged** gesetzt
        * Wenn ein List.entry.flag den Status **changed** hat, wird dieser auf **unchanged** gesetzt
        * Wenn ein List.entry.flag den Status **removed** hat, wird der Eintrag aus der Liste **entfernt**
        * Einträge mit abgelaufenem Behandlungszeitraum bleiben erhalten 
        <!-- * fachlich zu prüfen (TODO): Einträge mit abgelaufenem Behandlungszeitraum und courseOfTherapyType **acute** automatisch entfernen -->
    * die Fachanwendung liefert das Collection Bundle an den GDA:
        * inkl. List und aller referenzierten Ressourcen (inline)
        * ergänzt um den List.identifier
        * Ziel ist ein neutraler, weiterbearbeitbarer Zustand für den nächsten GDA
* Der temporär gespeicherte List.identifier für die Integritätsprüfung beim Schreibvorgang wird von der Fachanwendung separat von den FHIR Ressourcen verwalten.


#### Custom Operations

[$readtowrite](OperationDefinition-AtEmed.List.ReadtoWrite.html)

### Write-Zugriff

Der Write-Zugriff ist eine eigenständige Operation, die ausschließlich im Kontext eines vorherigen Read-to-Writes erfolgen darf:

* Der GDA übermittelt den aktualisierten Medikationsplan als **Transaction Bundle**:
    * alle **neuen und geänderten Ressourcen** sind **inline** im Bundle enthalten 
    * alle unveränderten Ressourcen werden nur referenziert
* Die Fachanwendung prüft u.a. ob der übermittelte **List.identifier** mit dem List.identifier der temporär gespeicherten Medikationsplanversion **übereinstimmt** (d.h. es wurde zwischenzeitlich kein anderer Schreibvorgang durchgeführt)
    * Stimm der List.identifier nicht überein, lehnt die Fachanwendung das Speichern des Medikationsplans ab. Es muss erneut ein Read-to-Write ausgeführt werden und die Aktualisierungen übernommen werden, bevor ein neuerlicher Speicherversuch gestartet werden kann.
* Bei erfolgreicher Prüfung:
    * werden die übermittelten Änderungen in die Ressourcen übernommen und
    * der **neue Medikationsplan persistiert** (Collection Bundle)

#### Custom Operations

[$write](OperationDefinition-AtEmed.List.Write.html)

#### Ablauf

<div>{% include diagram_readtowrite.svg %}</div>
<br>

<!-- TODO: Evtl. 2 Versionen: eine ungefiliterte Version (inkl. der seit dem letzten Speichern abgelaufener Einträge) und eine Version nur mit aktiven Einträgen/gültigem Behandlungszeitraum -->


#### Abgelehnter Write-Zugriff

* Wenn weitere Akteure (hier GDA 2) ein Read-to-Write ausführen, während GDA 1 das von der Fachanwendung übermittelte Bundle bearbeitet, erhalten sie:
    * dasselbe Collection Bundle (mit dem selben List.identifier), das zuvor schon GDA 1 übermittelt wurde.
* Nur bei jenem Akteur, der **zuerst einen Write-Zugriff ausführt**, stimmt der temporär in der Fachanwendung vorgehaltene List.identifier mit dem im Transaction Bundle verwendeten List.identifier überein, da der **temporäre List.identifier nach einem erfolgreichen Speichern gelöscht wird**.
* Bei einem späteren Schreibversuch mit dem ursprünglich gleichen List.identifier wird die Prüfung daher fehlschlagen und ein Speichern abgelehnt.
* Erst ein weiteres Read-to-Write löst wieder das generieren eines zur Auslieferung bereitgestellten temporären Collection Bundles inkl. neuem List.identifier aus. 

#### Ablauf

<div>{% include diagram_write_error.svg %}</div>


