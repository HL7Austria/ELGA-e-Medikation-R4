### Überblick der Statusänderungen der e-Medikation Ressourcen 

#### Status des List.entry.flags im Medikationsplan

Ein Medikationsplaneintrag kann, abhängig vom jeweiligen Use Case, unterschiedliche Status einnehmen. Dieser Status wird sowohl in der MedicationRequest-Ressource selbst als auch auf List-Ebene im Element List.entry.flag dokumentiert.

Das *flag*-Element eines Entries der List-Ressource beschreibt die **Art der Änderung eines Mediaktionsplaneintrags auf Listenebene** und kann folgende Status einnehmen:<br>

| Status | Beschreibung |
|--------|------|
| **New** | Neuer Planeintrag wird der Liste hinzugefügt |
| **Unchanged** | Bestehender Planeintrag wird beibehalten/zur Kenntnis genommen |
|  **Changed**  | Bestehender Planeintrag wird geändert |
|  **Removed**  | Bestehender Planeintrag wird entfernt |

<br>
<div>{% include stateDiagram_list_flag.svg %}</div>
<br>

#### Auswirkung der Zugriffsart auf List.entry.flags und Bundle-Inhalte

Je nach Zugriffsart (Read-only, Read-to-Write oder Write) ergeben sich unterschiedliche Auswirkungen auf die Verarbeitung dieser Status sowie auf die enthaltenen Ressourcen in den jeweiligen Bundles (siehe [Zugriffsarten auf den Medikationsplan](interactions.html#zugriffsarten-auf-den-medikationsplan)).
<br>

| Status | Read-only-Zugriff | Read-to-Write-Zugriff | Write-Zugriff |
|--------|------|------|------|
| **new** |- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die neuen MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *new* geflaggt wurden, werden dem Medikationsplan neu hinzugefügt.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
| **unchanged** |- List-Entries, die vom Vorgänger-GDA mit *unchanged* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die unveränderten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA als *unchanged* geflaggt wurden, bleiben beim Read-to-Write-Zugriff von der Fachanwendung unverändert.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom aktuellen GDA nicht verändert wurden, bleiben beim schreibenden Zugriff mit *unchanged* geflaggt. Sie gelten somit als zur Kenntnis genommen.<br>-  Die betreffenden MedicationRequests sind nicht im Transaction Bundle enthalten, sondern werden in der Liste **nur referenziert**.|
|  **changed**  |- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die geänderten MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom aktuellen GDA mit *changed* geflaggt werden, wurden geändert.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
|  **removed**  |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, bleiben beim read-only-Zugriff **unverändert**.<br>- Die zum Entfernen markierten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, werden beim Read-to-Write-Zugriff von der **Fachanwendung entfernt**.<br>- Die betreffenden MedicationRequests sind im Collection Bundle **nicht enthalten**.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *removed* geflaggt wurden, sollen aus dem Medikationsplan entfernt werden.<br>- Die betreffenden MedicationRequests werden u.a. mit dem entsprechenden Status geflaggt und müssen im Transaction Bundle **enthalten** sein. |

<br>

#### Status des MedicationRequests im Medikationsplaneintrag

Das *status*-Element der MedicationRequest-Ressource beschreibt den **aktuellen Zustand eines Medikationsplaneintrags**. 

Im Kontext des Medikationsplans kann dieses Element folgende Statuswerte annehmen: 

| Status | Beschreibung |
|---------------|------|
| **active** | Planeintrag dokumentiert aktive Therapie: Medikation soll aktuell vom Patienten eingenommen werden |
| **on-hold** | Planeintrag ist pausiert: Therapie wurde vorübergehend unterbrochen, Wiederaufnahme ist vorgesehen |
| **completed** | Die im Planeintrag beschriebenen Maßnahmen wurden wie geplant durchgeführt. Der Planeintrag wird damit abgeschlossen.|
| **stopped** | Die im Planeintrag beschriebenen Maßnahmen werden dauerhaft gestoppt, bevor alle geplanten Einnahmen oder Verabreichungen durchgeführt wurden. Der Planeintrag wird damit abgeschlossen. |
| **entered-in-error** | Planeintrag ist storniert: Kennzeichnung eines fehlerhaften Planeintrages. Der Planeintrag wird damit abgeschlossen. |

<br>
<div>{% include stateDiagram_mr_status_planeintrag.svg %}</div>
<br>

##### Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status

Da der Status eines Medikationsplaneintrags im Medikationsplan auf **zwei Ebenen** geführt wird (List.entry.flag und MedicationRequest.status), müssen diese beiden Ebenen zur Sicherstellung einer konsistenten Verarbeitung inhaltlich aufeinander abgestimmt sein. Die folgende Tabelle beschreibt die geltenden Konsistenzregeln zwischen List.entry.flag und MedicationRequest.status in Abhängigkeit vom jeweiligen Use Case:
<br>


<table>
  <colgroup>
    <col style="width: 30%">
    <col style="width: 20%"> 
    <col style="width: 20%">
    <col style="width: 30%">
  </colgroup>
  <thead>
    <tr>
      <th>Use Case</th>
      <th>List.entry.flags</th>
      <th>MedicationRequest-Status<br>(Planeintrag)</th>
      <th>Beschreibung</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2"><span style="font-weight:normal">Neuen Planeintrag zum Medikationsplan hinzufügen</span></td>
      <td><span style="font-weight:bold">new</span></td>
      <td><span style="font-weight:bold">active</span></td>
      <td>
        <span style="font-weight:normal">Neuer Planeintrag wird erstellt und ist aktiv</span><br>
        <span style="font-weight:normal">- der Behandlungszeitraum kann in der Zukunft liegen</span>
      </td>
    </tr>
    <tr>
      <td><span style="font-weight:bold">new</span></td>
      <td><span style="font-weight:bold">on-hold</span></td>
      <td><span style="font-weight:normal">Neuer Planeintrag wird erstellt, wird aber pausiert</span></td>
    </tr>
    <tr>
      <td rowspan="2"><span style="font-weight:normal">Bestehenden Planeintrag im Medikationsplan beibehalten/zur Kenntnis nehmen</span></td>
      <td><span style="font-weight:bold">unchanged</span></td>
      <td><span style="font-weight:bold">active</span></td>
      <td>
        <span style="font-weight:normal">Bestehender Planeintrag bleibt unverändert</span><br>
        <span style="font-weight:normal">- der Behandlungszeitraum darf noch nicht abgelaufen sein</span>
      </td>
    </tr>
    <tr>
      <td><span style="font-weight:bold">unchanged</span></td>
      <td><span style="font-weight:bold">on-hold</span></td>
      <td>
        <span style="font-weight:normal">Bestehender Planeintrag bleibt unverändert pausiert</span><br>
        <span style="font-weight:normal">- der Behandlungszeitraum darf noch nicht abgelaufen sein</span>
      </td>
    </tr>
    <tr>
      <td rowspan="2"><span style="font-weight:normal">Bestehenden Planeintrag im Medikationsplan ändern</span></td>
      <td><span style="font-weight:bold">changed</span></td>
      <td><span style="font-weight:bold">active</span></td>
      <td><span style="font-weight:normal">Bestehender Planeintrag wird geändert</span></td>
    </tr>
    <tr>
      <td><span style="font-weight:bold">changed</span></td>
      <td><span style="font-weight:bold">on-hold</span></td>
      <td><span style="font-weight:normal">Bestehender Planeintrag wird geändert und pausiert</span></td>
    </tr>
    <tr>
      <td rowspan="3"><span style="font-weight:normal">Bestehenden Planeintrag aus Medikationsplan entfernen</span></td>
      <td><span style="font-weight:bold">removed</span></td>
      <td><span style="font-weight:bold">completed</span></td>
      <td><span style="font-weight:normal">Bestehender Planeintrag wird beendet. Die Therapie wurde wie geplant durchgeführt und ist abgeschlossen.</span></td>
    </tr>
    <tr>
      <td><span style="font-weight:bold">removed</span></td>
      <td><span style="font-weight:bold">stopped</span></td>
      <td><span style="font-weight:normal">Bestehender Planeintrag wird vor Ablauf des Behandlungszeitraums dauerhaft gestoppt. Die Medikation wurde, bevor alle geplanten Einnahmen oder Verabreichungen durchgeführt wurden, abgesetzt.</span></td>
    </tr>
    <tr>
      <td><span style="font-weight:bold">removed</span></td>
      <td><span style="font-weight:bold">entered-in-error</span></td>
      <td><span style="font-weight:normal">Bestehender Planeintrag wird storniert, aufgrund falscher Eingabe</span></td>
    </tr>
  </tbody>
</table>

<br>

#### Status des MedicationRequests in der geplanten Abgabe
In Arbeit.

#### Status des MedicationDispense in der durchgeführten Abgabe
In Arbeit.