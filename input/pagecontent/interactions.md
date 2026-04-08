{% include styleheader.md %}

Im Folgenden werden standardisierte Interaktionen für den lesenden und schreibenden Zugriff auf FHIR-Ressourcen erläutert, die für alle technischen Use Cases relevant sind.

#### Ablauf Read-only-Zugriff

<div>{% include diagram_read.svg %}</div>

Beim Read-only-Zugriff prüft die Fachanwendung, ob bereits ein Medikationsplan erstellt wurde. Ist dies nicht der Fall wird dieser erstellt (siehe [Sub_UC_06_01 - Initial erstellter Medikationsplan](Sub_UC_eMed_06.html#sub_uc_06_01---initial-erstellter-medikationsplan)).


Existiert berets ein Medikationsplan, liefert die Fachanwendung die zuletzt gespeicherte Version des Medikationsplans (Collection Bundle). Dieses Bundle enthält die List-Ressource sowie alle darin referenzierten Ressourcen (z.B. MedicationRequest, Patient, Practitioner). Alle referenzierten Ressourcen werden vollständig im Bundle mitgeliefert (inline).


TODO: <br>
* Read als GET oder custom operation?<br>
* Historischen Medikationsplan abrufen<br>
* Search via bpk-gh des Patienten:<br>
    * Custom Suchparameter für List im Collection Bundle 

#### Ablauf Read-to-write-Zugriff

<div>{% include diagram_readtowrite.svg %}</div>

Beim Read-to-write-Zugriff prüft die Fachanwendung, ob bereits ein Medikationsplan erstellt wurde. Ist dies nicht der Fall wird dieser erstellt (siehe [Sub_UC_06_01 - Initial erstellter Medikationsplan](Sub_UC_eMed_06.html#sub_uc_06_01---initial-erstellter-medikationsplan)).

Existiert berets ein Medikationsplan, erzeugt die Fachanwendung aus der zuletzt gespeicherten Version des Medikationsplans ein neues Collection Bundle und nimmt folgende Änderungen vor:
- List-Flags von *new* oder *changed* auf *unchanged* setzen
- List-Entries mit Flag *removed* entfernen (stornierte, )
- List-Entries mit abgelaufenem Behandlungszeitraum + MedicationRequests mit  auf *completed* setzen (TODO: prüfen)

TODO: <br>
* Evtl. 2 Versionen: eine ungefiliterte Version (inkl. der seit dem letzten Speichern abgelaufener Einträge) und eine Version nur mit aktiven Einträgen/gültigem Behandlungszeitraum


Dieses Bundle enthält die List-Ressource sowie alle darin referenzierten Ressourcen (z.B. MedicationRequest, Patient, Practitioner). Alle referenzierten Ressourcen werden vollständig im Bundle mitgeliefert (inline).


###### Abgelehnter Read-to-write-Zugriff

TODO: Sequenzdaigramm: 2. GDA führt zeitgleich read-to-write aus -> späteres schreiben wird abgelehnt, da Identifier-Prüfung fehlschlägt



