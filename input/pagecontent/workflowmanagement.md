{% include styleheader.md %}

### Überblick der Statusänderungen der e-Medikation Ressourcen 

#### Status des List.entry.flags (Medikationsplan)

Das *flag*-Element eines Entries der List-Ressource beschreibt die **Art der Änderung eines Mediaktionsplaneintrags auf Listenebene** und kann folgende Status einnehmen:

| Status | Beschreibung |
|--------|------|
| **New** | Neuer Planeintrag wird der Liste hinzugefügt |
| **Unchanged** | Bestehender Planeintrag wird beibehalten/zur Kenntnis genommen |
|  **Changed**  | Bestehender Planeintrag wird geändert |
|  **Removed**  | Bestehender Planeintrag wird entfernt |

<div>{% include stateDiagram_list_flag.svg %}</div>


#### Auswirkung der Zugriffsart auf List.entry.flags und Bundles

| Status | Read-only-Zugriff | Read-to-Write-Zugriff | Write-Zugriff |
|--------|------|------|------|
| **new** |- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die neuen MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *new* geflaggt wurden, werden dem Medikationsplan neu hinzugefügt.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
| **unchanged** |- List-Entries, die vom Vorgänger-GDA mit *unchanged* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die unveränderten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA als *unchanged* geflaggt wurden, bleiben beim Read-to-Write-Zugriff von der Fachanwendung unverändert.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom aktuellen GDA nicht verändert wurden, bleiben beim schreibenden Zugriff mit *unchanged* geflaggt. Sie gelten somit als zur Kenntnis genommen.<br>-  Die betreffenden MedicationRequests sind nicht im Transaction Bundle enthalten, sondern werden in der Liste **nur referenziert**.|
|  **changed**  |- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die geänderten MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom aktuellen GDA mit *changed* geflaggt werden, wurden geändert.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
|  **removed**  |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die zum Entfernen markierten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung entfernt**.<br>- Die betreffenden MedicationRequests sind im Collection Bundle **nicht enthalten**.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *removed* geflaggt wurden, sollen aus dem Medikationsplan entfernt werden.<br>- Die betreffenden MedicationRequests werden u.a. mit dem Status entsprechenden Statuts geflaggt und müssen im Transaction Bundle **enthalten** sein. |


#### Status des MedicationRequests im Medikationsplaneintrag

Das *status*-Element kann in Planeinträgen fogende Zustände annehmen:

| Status | Beschreibung |
|---------------|------|
| **active** | Planeintrag dokumentiert aktive Therapie: Medikation soll aktuell vom Patienten eingenommen werden |
| **on-hold** | Planeintrag ist pausiert: Therapie wurde vorübergehend unterbrochen, Wiederaufnahme ist vorgesehen |
| **completed** | Die im Planeintrag beschriebenen Maßnahmen wurden wie geplant durchgeführt. Der Planeintrag wird damit abgeschlossen.|
| **stopped** | Die im Planeintrag beschriebenen Maßnahmen werden dauerhaft gestoppt, bevor alle geplanten Einnahmen oder Verabreichungen durchgeführt wurden. Der Planeintrag wird damit abgeschlossen. |
| **entered-in-error** | Planeintrag ist storniert: Kennzeichnung eines fehlerhaften Planeintrages. Der Planeintrag wird damit abgeschlossen. |

<div>{% include stateDiagram_mr_status_planeintrag.svg %}</div>


##### Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status

| Use Case | List.entry.flags | MedicationRequest-Status      (Planeintrag) | Beschreibung |  |
|---|---|---|---|---|
| Neuen Planeintrag zum Medikationsplan hinzufügen | **new** | **active** | Neuer Planeintrag wird erstellt und ist aktiv<br> - der Behandlungszeitraum kann in der Zukunft liegen<br> - Bereits bestehender Planeintrag kann wieder reaktiviert werden (Client-SW) |  |
|  |  **new** | **on-hold** | Neuer Planeintrag wird erstellt, wird aber pausiert  |  |
| Bestehenden Planeintrag im Medikationsplan beibehalten/zur Kenntnis nehmen | **unchanged** | **active**  | Bestehender Planeintrag bleibt unverändert<br> - der Behandlungszeitraum darf noch nicht abgelaufen sein |  |
|  | **unchanged**  | **on-hold** | Bestehender Planeintrag bleibt unverändert pausiert<br> - der Behandlungszeitraum darf noch nicht abgelaufen sein |  |
| Bestehenden Planeintrag im Medikationsplan ändern | **changed** | **active** | Bestehender Planeintrag wird geändert |  |
|  | **changed** | **on-hold** | Bestehender Planeintrag wird geändert und pausiert |  |
| Bestehenden Planeintrag aus Medikationsplan entfernen | **removed**  | **completed** | Bestehender Planeintrag wird beendet (durch Ablauf des Behandlungszeitraums, wenn keine erneute Verordnung) |  |
|  | **removed**  | **stopped** | Bestehender Planeintrag wird vor Ablauf des Behandlungszeitraums abgesetzt  |  |
|  | **removed**  | **entered-in-error** | Bestehender Planeintrag wird storniert, aufgrund falscher Eingabe |  | 

#### Status des MedicationRequests in der geplanten Abgabe
In Arbeit.

#### Status des MedicationDispense (durchgeführte Abgabe)
In Arbeit.