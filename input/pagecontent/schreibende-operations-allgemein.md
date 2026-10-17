<div class="dragon" markdown="1">
<p class="note-to-balloters">
    <ul>
    <li>Die finale Liste der allgemeinen Businesslogik wird noch erarbeitet. Feedback für zusätzliche Prüfungen/Regeln ist erwünscht.</li>
    <li>Die genaue Struktur des OperationOutcome im Fehlerfall ist noch zu definieren.</li>
    </ul>
</p>
</div>

### Allgemeine Business-Logik für schreibende Operations
Die folgenden Regeln gelten für alle schreibenden Operations dieses Implementierungsleitfadens. Sie gelten sowohl für unmittelbar übermittelte Änderungen als auch für daraus resultierende serverseitige Folgeänderungen. Input und Output sind in den [Parameters](#parameters) festgelegt.Ergänzende Regelungen werden in der für die [Operation spezifischen Business-Logik](#operation-spezifische-business-logik) beschrieben.

Die folgenden Regeln gelten für alle schreibenden Operations dieses Implementierungsleitfadens. Sie gelten sowohl für unmittelbar übermittelte Änderungen als auch für daraus resultierende serverseitige Folgeänderungen. Input und Output sind in der jeweiligen OperationDefinition festgelegt. Ergänzende Regelungen werden in der operationsspezifischen Business-Logik beschrieben.

#### Generell
-  Für alle im IG entsprechend festgelegten Ressourcen MUSS die Narrative (.text) gemäß den ressourcenspezifischen Regeln erzeugt werden. Nach serverseitigen Änderungen MUSS sichergestellt sein, dass die Narrative dem tatsächlich gespeicherten beziehungsweise ausgelieferten strukturierten Inhalt entspricht.

#### Kontext
- Vor der Verarbeitung MUSS geprüft werden, ob der Aufrufer der Operation für den betroffenen Patienten und die betroffenen Ressourcen berechtigt ist.
- Es MUSS geprüft werden, dass der schreibende GDA nach der Transaktion auch als Autor der veränderten Ressourcen dokumentiert ist.
- Alle patientenbezogenen Ressourcen des fachlichen Schreibvorgangs MÜSSEN demselben ELGA-Teilnehmer zugeordnet sein. Dies MUSS auch für referenzierte bestehende Ressourcen und für die durch Folgeänderungen betroffenen Ressourcen geprüft werden.
- Client-Anwendungen dürfen keine eigenen Patient-, Practitioner-, PractitionerRole- oder Organization-Ressourcen zur Stammdatenanlage oder -änderung übermitteln. Die Identifikation erfolgt gemäß IG über die vorgegebenen logischen Referenzen.

#### Validierung
- Die Fachanwendung MUSS den Zustand der Ressourcen validieren, der nach Anwendung aller übermittelten Änderungen, Referenzauflösungen und serverseitigen Ergänzungen entstehen würde. Schlägt eine erforderliche Prüfung fehl, MUSS die Operation abgelehnt werden. Es DÜRFEN KEINE fachlichen Teiländerungen persistiert werden.
- Die Validierung MUSS mindestens die FHIR-R4-Basisregeln, die anzuwendenden IG-Profile und deren Abhängigkeiten, Kardinalitäten, Datentypen, Slicing-Regeln, fixe Werte, Terminology Bindings entsprechend ihrer Bindungsstärke, Must-Support Mechanismus sowie Invarianten umfassen.
- Werden Elemente übermittelt, welche im IG explizit gestrichen worden sind (Kardinalität 0..0) so MUSS die Operation abgelehnt werden.
- Werden Elemente übermittelt, welche im IG nicht als MS markiert sind, so ist in einem OperationOutcome mit der .severity #information in der Response deutlich zu kennzeichenen, dass die Elemente ignoriert und nicht vom Server verarbeitet werden.

#### Response
- Das Ergebnis von schreibenden Operations ist immer die persistierte Version der angelegten oder geänderten Ressource(n). Diese zurückgegebene Ressourcen MÜSSEN dem erfolgreich persistierten Zustand einschließlich aller serverseitigen Ergänzungen und Änderungen entsprechen:
    - Bei neuen Versionen einzelner Ressourcen wird statt einem Bundle nur die Ressource selbst zurückgegeben so wie sie nach der Operation am Server persistiert ist.
    - Bei einem TransactionBundle als Input wird auch als Response ein Bundle mit allen persistierten Resssourcen zurückgegeben
- Wird eine eigenständig persistierte Ressource neu angelegt oder eine neue Version einer bestehenden Ressource gespeichert, MUSS die Fachanwendung meta.lastUpdated auf den serverseitigen Speicherzeitpunkt setzen und eine neue meta.versionId vergeben. Bei Änderungen bleibt die logische id der Ressource unverändert. Vom Client übermittelte Werte für meta.versionId und meta.lastUpdated bestimmen nicht die neu gespeicherten Metadaten.

#### Fehlerfall
- Bei Ablehnung einer schreibenden Operation MUSS ein passender HTTP-Fehlerstatus zurückgegeben werden. Der Response-Body MUSS ein OperationOutcome mit den Fehlermeldungen enthalten.


