{% include styleheader.md %}


### Überblick der Statusänderungen der e-Medikation Ressourcen 

[![diagram](Workflowmanagement_status_abhaengigkeiten.svg){: style="width: 100%"}](Workflowmanagement_status_abhaengigkeiten.svg)
<br>

#### Status des List.entry.flags im Medikationsplan

Ein *Medikationsplaneintrag* kann, abhängig vom jeweiligen ([Use Case für Medikationsplan schreiben](Sub_UC_eMed_02.html)), unterschiedliche Status einnehmen. Dieser Status wird sowohl in der MedicationRequest-Ressource selbst als auch auf **List-Ebene** im *List.entry.flag* dokumentiert.

Das *List.entry.flag* kann folgende Status einnehmen (siehe [CodeSystem-ElgaListEntryFlagCS](CodeSystem-ElgaListEntryFlagCS.html)):
<br><br>

| List.entry.flag | Beschreibung |
|--------|------|
| **New** | Neuer Planeintrag wird der Liste hinzugefügt |
| **Unchanged** | Bestehender Planeintrag wird beibehalten/zur Kenntnis genommen |
| **Changed**  | Bestehender Planeintrag wird geändert |
| **Removed**  | Bestehender Planeintrag wird entfernt |

<br>
<div>{% include_relative plantuml/workflow_list_flag.svg %}</div>
<br>

#### Auswirkung der Zugriffsart auf List.entry.flags und Bundle-Inhalte

Je nach Zugriffsart (Plan-History-Search, Plan-Read oder Write) ergeben sich unterschiedliche Auswirkungen auf die Verarbeitung dieser Status sowie auf die enthaltenen Ressourcen in den jeweiligen Bundles (siehe [Transaktionen](interactions.html)).
<br>
<br>

<div class="table-responsive">
  <table>
      <thead>
          <tr>
              <th>List.entry.flag</th>
              <th>Plan-History-Search</th>
              <th>Plan-Read</th>
              <th>Plan-Write</th>
          </tr>
      </thead>
      <tbody>
          <tr>
              <td><strong>new</strong></td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>new</em> geflaggt wurden, bleiben beim Plan-History-Search
                  <strong>unverändert</strong>.<br />- Die neuen MedicationRequests sind im Medikationsplan-Bundle
                  enthalten.
              </td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>new</em> geflaggt wurden, werden beim Plan-Read von der
                  <strong>Fachanwendung</strong> als <strong>unchanged</strong> geflaggt.<br />- Die betreffenden
                  MedicationRequests sind im Medikationsplan-Bundle enthalten.
              </td>
              <td>
                  - List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit <em>new</em> geflaggt wurden, werden
                  dem Medikationsplan neu hinzugefügt.<br />- Die betreffenden MedicationRequests müssen im Transaction
                  Bundle <strong>enthalten</strong> sein.
              </td>
          </tr>
          <tr>
              <td><strong>unchanged</strong></td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>unchanged</em> geflaggt wurden, bleiben beim
                  Plan-History-Search <strong>unverändert</strong>.<br />- Die unveränderten MedicationRequests sind im
                  Medikationsplan-Bundle enthalten.
              </td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA als <em>unchanged</em> geflaggt wurden, bleiben beim Plan-Read von
                  der Fachanwendung unverändert.<br />- Die betreffenden MedicationRequests sind im Medikationsplan-Bundle
                  enthalten.
              </td>
              <td>
                  - List-Entries, die vom aktuellen GDA nicht verändert wurden, bleiben beim schreibenden Zugriff mit
                  <em>unchanged</em> geflaggt. Sie gelten somit als zur Kenntnis genommen.<br />- Die betreffenden
                  MedicationRequests sind nicht im Transaction Bundle enthalten, sondern werden in der Liste
                  <strong>nur referenziert</strong>.
              </td>
          </tr>
          <tr>
              <td><strong>changed</strong></td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>changed</em> geflaggt wurden, bleiben beim
                  Plan-History-Search <strong>unverändert</strong>.<br />- Die geänderten MedicationRequests sind im
                  Medikationsplan-Bundle enthalten.
              </td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>changed</em> geflaggt wurden, werden beim Plan-Read von
                  der <strong>Fachanwendung</strong> als <strong>unchanged</strong> geflaggt.<br />- Die betreffenden
                  MedicationRequests sind im Medikationsplan-Bundle enthalten.
              </td>
              <td>
                  - List-Entries, die vom aktuellen GDA mit <em>changed</em> geflaggt werden, wurden geändert.<br />- Die
                  betreffenden MedicationRequests müssen im Transaction Bundle <strong>enthalten</strong> sein.
              </td>
          </tr>
          <tr>
              <td><strong>removed</strong></td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>removed</em> geflaggt wurden, bleiben beim
                  Plan-History-Search <strong>unverändert</strong>.<br />- Die zum Entfernen markierten MedicationRequests
                  sind im Medikationsplan-Bundle enthalten.
              </td>
              <td>
                  - List-Entries, die vom Vorgänger-GDA mit <em>removed</em> geflaggt wurden, werden beim Plan-Read von
                  der <strong>Fachanwendung entfernt</strong>.<br />- Die betreffenden MedicationRequests sind im
                  Medikationsplan-Bundle <strong>nicht enthalten</strong>.
              </td>
              <td>
                  - List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit <em>removed</em> geflaggt wurden,
                  sollen aus dem Medikationsplan entfernt werden.<br />- Die betreffenden MedicationRequests werden u.a.
                  mit dem entsprechenden Status geflaggt und müssen im Transaction Bundle <strong>enthalten</strong> sein.
              </td>
          </tr>
      </tbody>
  </table>
</div>

<br>

#### Status des Medikationsplaneintrags (MedicationRequest)

Das *status*-Element der MedicationRequest-Ressource beschreibt den **aktuellen Zustand eines Medikationsplaneintrags**. 

Im Kontext des Medikationsplans kann dieses Element folgende Statuswerte annehmen (siehe [CodeSystem-ElgaListEntryFlagCS](CodeSystem-ElgaListEntryFlagCS.html)): 
<br><br>

| MedicationRequest.status | Beschreibung |
|---------------|------|
| **active** | Der Planeintrag dokumentiert eine aktuell einzunehmende Medikation. |
| **on-hold** | Der Planeintrag dokumentiert ein pausierte Medikation (aktuell nicht einzunehmen). |
| **stopped** | Der Planeintrag ist nicht länger aktiv. Die Medikation wird nicht weiter verordnet. Dies gilt unabhängig davon, ob der Einnahmezeitraum abgelaufen ist oder die Medikation vorzeitig abgesetzt wurde. Der Planeintrag wird damit abgeschlossen (Endzustand). (\*)
| **entered-in-error** | Der Planeintrag ist storniert. Der Planeintrag wird damit abgeschlossen (Endzustand). |

(\*) Abweichung vom verpflichtenden Value-Set [medicationrequest-status](https://hl7.org/fhir/R4/valueset-medicationrequest-status.html): Der Status *stopped* vereint die Defintionen von *completed* und *stopped* und entspricht dem Stataus *ended* aus FHIR R6. 

<!-- **completed**  Die im Planeintrag beschriebenen Maßnahmen wurden wie geplant durchgeführt. Der Planeintrag wird damit abgeschlossen. -->
<!-- **stopped**  Die im Planeintrag beschriebenen Maßnahmen werden dauerhaft gestoppt, bevor alle geplanten Einnahmen oder Verabreichungen durchgeführt wurden. Der Planeintrag wird damit abgeschlossen. -->

<br>
<div>{% include_relative plantuml/workflow_mr_status_planeintrag.svg %}</div>
<br>

##### Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status

Da der Status eines Medikationsplaneintrags im Medikationsplan auf **zwei Ebenen** geführt wird (List.entry.flag und MedicationRequest.status), müssen diese beiden Ebenen zur Sicherstellung einer konsistenten Verarbeitung inhaltlich aufeinander abgestimmt sein. Die folgende Tabelle beschreibt die geltenden Konsistenzregeln zwischen List.entry.flag und MedicationRequest.status in Abhängigkeit vom jeweiligen Use Case:
<br><br>

<div class="table-responsive">
  <table>
    <thead>
      <tr>
        <th>Use Case</th>
        <th>List.entry.flag</th>
        <th>MedicationRequest-Status<br>(Planeintrag)</th>
        <th>Beschreibung</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td rowspan="2" class="use-case-heading">Neuen Planeintrag zum Medikationsplan hinzufügen</td>
        <td><b>new</b></td>
        <td><b>active</b></td>
        <td>
          Neuer Planeintrag wird erstellt und ist aktiv. Der Einnahmezeitraum kann in der Zukunft liegen.
        </td>
      </tr>
      <tr>
        <td><b>new</b></td>
        <td><b>on-hold</b></td>
        <td>Neuer Planeintrag wird erstellt, wird aber pausiert.</td>
      </tr>
      <tr>
        <td rowspan="2" class="use-case-heading">Bestehenden Planeintrag im Medikationsplan beibehalten/zur Kenntnis nehmen</td>
        <td><b>unchanged</b></td>
        <td><b>active</b></td>
        <td>
          Bestehender Planeintrag bleibt unverändert. Der Einnahmezeitraum darf noch nicht abgelaufen sein.
        </td>
      </tr>
      <tr>
        <td><b>unchanged</b></td>
        <td><b>on-hold</b></td>
        <td>
          Bestehender Planeintrag bleibt unverändert pausiert. Der Einnahmezeitraum darf noch nicht abgelaufen sein.
        </td>
      </tr>
      <tr>
        <td rowspan="2" class="use-case-heading">Bestehenden Planeintrag im Medikationsplan ändern</td>
        <td><b>changed</b></td>
        <td><b>active</b></td>
        <td>Bestehender Planeintrag wird geändert.</td>
      </tr>
      <tr>
        <td><b>changed</b></td>
        <td><b>on-hold</b></td>
        <td>Bestehender Planeintrag wird geändert und pausiert.</td>
      </tr>
      <tr>
        <td rowspan="2" class="use-case-heading">Bestehenden Planeintrag aus Medikationsplan entfernen</td>
        <td><b>removed</b></td>
        <td><b>stopped</b></td>
        <td>
          Bestehender Planeintrag wird dauerhaft gestoppt.
          Die Medikation wird nicht weiter verordnet.
        </td>
      </tr>
      <tr>
        <td><b>removed</b></td>
        <td><b>entered-in-error</b></td>
        <td>Bestehender Planeintrag wird aufgrund eines Fehlers storniert.</td>
      </tr>
    </tbody>
  </table>
</div>
<br>

#### Status der Geplanten Abgabe (MedicationRequest)

Eine [Geplante Abgabe](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) kann, abhängig vom jeweiligen ([Use Case für Geplante Abgabe schreiben](Sub_UC_eMed_04.html)), unterschiedliche Status einnehmen (Element *status*):<br><br>

<!-- Folgende Status sollen gemäß e-Rezept abgebildet werden: OFFEN, EINGELÖST, STORNIERT, ABGELAUFEN, NICHT_ABGEGEBEN<br> -->

<!-- Folgende Status sind gemäß required ValueSet medicationrequest-status verfügbar: https://hl7.org/fhir/R4/valueset-medicationrequest-status.html -->

| MedicationRequest.status | Beschreibung |
|--------|------|
| **active** | *Geplante Abgabe* **offen**: Status beim Erstellen einer Geplanten Abgabe, solange noch (Teil-)Abgaben offen sind (dh. Rezept kann noch eingelöst werden) |
|  **completed**  | *Geplante Abgabe* **abgeschlossen**: Der Status wird durch die Fachwendung **automatisch** gesetzt, wenn alle möglichen Einlösungen erfolgt und die entsprechenden *Durchgeführten Abgaben* erstellt wurden. Sonderfall: Sollte im Anschluss eine *Durchgeführte Abgabe* den Status *entered-in-error* erhalten, setzt die Fachanwendung gegebenfalls die *Geplante Abgabe* automatisch wieder auf *active*. |
| **stopped** | *Geplante Abgabe* ist **abgelaufen**, d.h. der Einlösezeitraum für die ausgewählte Rezeptart (*category:recipetype*) ist überschritten; der Status wird **automatisch durch die Fachanwendung** gesetzt. Die *Geplante Abgabe* ist damit abgeschlossen. |
|  **entered-in-error**  | *Geplante Abgabe* wird aufgrund eines Fehlers storniert. Es wurden noch **keine Abgaben durchgeführt**. Die *Geplante Abgabe* wird damit abgeschlossen. |
|  **cancelled**  | *Geplante Abgabe* erhält automatisch den Status **cancelled** ("nicht abgegeben"), wenn alle *Durchgeführten Abgaben* den Status *cancelled* erhalten haben. Wird eine gecancelte *Durchgeführte Abgabe* storniert, wird die *Geplante Abgabe* automatisch wieder aktiviert. |

<!-- |  **cancelled**  | *Geplante Abgabe* ist storniert, aufgrund eines Fehlers. Die *Geplante Abgabe* wurde zurückgezogen, **bevor eine Abgabe durchgeführt** wurde. Die *Geplante Abgabe* ist damit abgeschlossen. | -->

<!-- | **stopped** | *Geplante Abgabe* wird **nicht abgegeben**: Die *Geplante Abgabe* wird dauerhaft **durch den GDA** gestoppt, auch wenn bereits Teilabgaben durchgeführt worden sind. Wenn die *Geplante Abgabe* **abgelaufen** ist, d.h. der Einlösezeitraum für die ausgewählte Rezeptart (*category:recipetype*) ist überschritten, wird der Status **automatisch durch die Fachanwendung** gesetzt. Die *Geplante Abgabe* ist damit abgeschlossen. | -->

<!-- Gemäß:  [active | completed | entered-in-error | stopped]. Bedeutung: active: offene, *Geplante Abgabe* | completed: *Geplante Abgabe* abgeschlossen | entered-in-error: nach fehlerhafter Eingabe; Storno nur möglich, wenn noch keine zugehörige Abgabe durchgeführt wurde | stopped: Verwendung zu prüfen (Status soll analog zu e-Rezept abgebildet werden)"
//(nicht verwendet: on-hold, cancelled, draft, unknown) -->

<!-- TODO: Status abgelaufen ist nur über das Datum und die Rezeptart ersichtlich? -->

<br>
<div>{% include_relative plantuml/workflow_mr_status_geplanteabgabe.svg %}</div>
<br>

#### Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart

{% include styleheader.md %}

<div class="table-responsive">
  <table>
    <thead>
      <tr>
        <th>Rezeptart</th>
        <th>Gültigkeit<sup>[1]</sup></th>
        <th>Einlösungen<sup>[2]</sup></th>
        <th>Verlängerung</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Kassenrezept</td>
        <td>
          <ul>
            <li>1 Monat ab Beginn des Gültigkeitszeitraums (ab Datum der Verordnung)</li>
          </ul>
          z.B: Rezept wurde am 15.5. ausgestellt und kann bis inkl. 15.6. eingelöst werden.
        </td>
        <td>1× (kann nur in 1 Apotheke eingelöst werden)</td>
        <td>
          Im Zuge des „Besorgerprozesses“ (Medikament muss erst bestellt werden)
          wird bei einer gespeicherten Teilabgabe die gesamte Gültigkeitsdauer
          auf 3 Monate verlängert.
        </td>
      </tr>
      <tr>
        <td>Privatrezept</td>
        <td>
          Gültigkeit festgelegt durch verordnenden GDA:
          <ul>
            <li>Mindestens: 1 Monat ab Beginn des Gültigkeitszeitraums</li>
            <li>
              Maximal: 1 Jahr ab Beginn des Gültigkeitszeitraums
              (1. Einlösung muss innerhalb eines Monats ab Datum der Verordnung erfolgen)
            </li>
          </ul>
        </td>
        <td>
          Bis zu 6× (durch den Verordner festgelegt); kann in mehreren Apotheken
          eingelöst werden (je nach Anzahl der Einlösemöglichkeiten)
        </td>
        <td>Keine Verlängerung möglich.</td>
      </tr>
      <tr>
        <td>Substitutionsrezept</td>
        <td>
          Gültigkeit festgelegt durch verordnenden GDA:
          <ul>
            <li>Beliebige Dauer ab Beginn des Gültigkeitszeitraums</li>
            <li>
              Wenn kein Datum angegeben: Beginn des Gültigkeitszeitraums + 1 Monat
            </li>
          </ul>
        </td>
        <td>1×</td>
        <td>Keine Verlängerung möglich.</td>
      </tr>
    </tbody>
  </table>
</div>

[1] Die Anzahl der Einlösungen gibt an, wie oft ein Rezept eingelöst werden darf. Ist keine Einlösung mehr möglich erhält die zugehörige *Geplante Abgabe* den Status eingelöst (*completed*).<br>
[2] Ist der Gültigkeitszeitraum überschritten erhält die zugehörige *Geplante Abgabe* den Status abgelaufen (*stopped*). Das Einlösen eines Rezepts nach Ablauf der Gültigkeit wird durch e-Medikation nicht verhindert. Die Abgabe kann in diesem Fall ohne Verordnungsbezug in e-Medikation gespeichert werden. 
<br><br>

#### Status der Durchgeführten Abgabe (MedicationDispense)

Eine [Durchgeführte Abgabe](design_choices.html#durchgeführte-abgabe-atelgaemedmedicationdispensedurchgefuehrteabgabe-medicationdispense) kann, abhängig vom jeweiligen [Use Case für Durchgeführte Abgabe schreiben](Sub_UC_eMed_05.html), unterschiedliche Status einnehmen (Element *status*). 


| MedicationDispense.status | Beschreibung |
|--------|------|
| **completed** | Die Durchgeführte Abgabe ist abgeschlossen (Einzel- oder Teilabgabe durchgeführt). |
| **cancelled** | *Durchgeführte Abgabe* gecancelt (Leerabgabe): Der Patient benötigt die Medikation einer *Geplanten Abgabe* nicht. |
| **entered-in-error** | Vorhandene *Durchgeführte Abgabe* (im Status *completed* oder *cancelled*) wird aufgrund eines Fehlers storniert (eine mögliche abgeschlossene *Geplante Abgabe*, wird dadurch wieder *aktiv*)|


<!-- |  **preparation**  | *Durchgeführte Abgabe* wird vorbereitet (zubereitet oder bestellt) | -->


<br>
<div>{% include_relative plantuml/workflow_md_status_durchgefuehrteabgabe.svg %}</div>
<br>


#### Abhängigkeiten der *Geplanten Abgabe* und der *Durchgeführten Abgaben*



<div class="table-responsive">
<table>
  <thead>
    <tr>
      <th>Use Case - Geplante Abgabe</th>
      <th>Planeintrag (MedicationRequest-Status)</th>
      <th>Beschreibung</th>
      <th><em>Geplante Abgabe</em> (MedicationRequest-Status)</th>
      <th>Status Verordnung CDA</th>
      <th>Beschreibung</th>
      <th><em>Durchgeführte Abgabe</em> (MedicationDispense-Status)</th>
      <th>Status Abgabe CDA</th>
      <th>Beschreibung</th>
      <th>Use Case - Durchgeführte Abgabe</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><em>Geplante Abgabe</em> basierend auf Planeintrag erfassen</td>
      <td>active</td>
      <td>Planeintrag bleibt active, unabhängig von Status der Geplanten Abgabe (*)</td>
      <td>active</td>
      <td>OFFEN</td>
      <td>z.B. 6 Einlösungen bei Privatrezept</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>noch keine bzw. noch nicht alle mögl. Einlösungen erfolgt (mit Status completed)</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><em>Geplante Abgabe</em> beenden (durch Fachanwendung)</td>
      <td>active</td>
      <td>Planeintrag bleibt active, unabhängig von Status der Geplanten Abgabe (*)</td>
      <td>completed</td>
      <td>EINGELÖST</td>
      <td>auf Basis der Durchgeführten Abgaben automatisch gesetzt durch Fachanwendung; dh. Alle möglichen Einlösungen sind abgechlossen (entweder completed oder cancelled)</td>
      <td>completed</td>
      <td>ABGEGEBEN</td>
      <td>alle möglichen Einlösungen erfolgt</td>
      <td><em>Durchgeführte Abgabe</em> erfassen</td>
    </tr>
    <tr>
      <td><em>Geplante Abgabe</em> stornieren</td>
      <td>active</td>
      <td>Planeintrag bleibt active, unabhängig von Status der Geplanten Abgabe (*)</td>
      <td>entered-in-error</td>
      <td>STORNIERT</td>
      <td>bei fehlerhafter Eingabe, wenn noch keine Abgabe durchgeführt</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>keine Durchgeführten Abgaben vorhanden</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><em>Geplante Abgabe</em> abgelaufen (durch Fachanwendung)</td>
      <td>active</td>
      <td>Planeintrag bleibt active, unabhängig von Status der Geplanten Abgabe (*)</td>
      <td>stopped</td>
      <td>ABGELAUFEN</td>
      <td>automatisch erkannt durch Fachanwendung</td>
      <td>kein relevanter Status</td>
      <td>kein relevanter Status</td>
      <td>noch keine bzw. noch nicht alle mögl. Einlösungen erfolgt.<br/>Zu abgelaufenen Geplanten Abgaben können keine Abgaben mehr gespeichert werden. Die (nachträgliche) Speicherung von Abgaben zu einem abgelaufenen Rezept kann im Anlassfall allerdings ohne Verordnungsbezug erfolgen.</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><em>Geplante Abgabe</em> nicht abgegeben (durch Fachanwendung)</td>
      <td>active</td>
      <td>Planeintrag bleibt active, unabhängig von Status der Geplanten Abgabe (*)</td>
      <td>cancelled</td>
      <td>NICHT_ABGEGEBEN</td>
      <td>automatisch, wenn alle Einlösungen im MedicationDispense den Status "cancelled" erhalten haben</td>
      <td>cancelled</td>
      <td>ABGESETZT</td>
      <td>Apotheker dokumentiert in der Durchgeführten Abgabe, dass der Patient das Medikament in der Geplanten Abgabe nicht benötigt (mit Packungen 0) (Leerabgabe).<br/>Eine Stornierung ist möglich.</td>
      <td><em>Durchgeführten Abgabe</em> abgesetzt</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>entered-in-error</td>
      <td>STORNIERT</td>
      <td>bei fehlerhafter Eingabe</td>
      <td><em>Durchgeführte Abgabe</em> stornieren</td>
    </tr>
  </tbody>
</table>
</div>

<br>(\*) solange ein evtl. Einnahmezeitraum nicht überschritten

<br>


#### Varianten der (Teil-)Abgabe 

Im Element *MedicationDispense.type* einer Durchgeführten Abgabe wird die Art der Abgabe dokumentiert, welche von der [Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart) (Anzahl Einlösungen) und vom Use Case abhängt.

<br>
[![diagram](diagram_durchgefuehrte_abgaben_abgabearten.drawio.svg){: style="width: 100%"}](diagram_durchgefuehrte_abgaben_abgabearten.drawio.svg)

<br>

<div class="table-responsive">
  <table>
    <thead>
      <tr>
        <th>Abgabenart</th>
        <th><em><strong>Geplante Abgabe</strong></em> (MedicationRequest-Status)</th>
        <th>Beschreibung</th>
        <th><em><strong>Durchgeführte Abgabe</strong></em> (MedicationDispense-Status)</th>
        <th>Beschreibung</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Einzelabgabe (einmalige Einlösemöglichkeit)</td>
        <td>completed</td>
        <td>Sofern <em>Geplante Abgabe</em> vorhanden, wird diese nach erfolgter Abgabe automatisch auf <em>completed</em> gesetzt.</td>
        <td>type: FFC (First Fill - Complete)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>Abgabe abgeschlossen</td>
      </tr>
      <tr>
        <td>Vollständige Einzelabgabe (bei mehrmaliger Einlösemöglichkeit)</td>
        <td>active<br><br>wenn letzte Einlösung abgeschlossen: completed</td>
        <td><em>Geplante Abgabe</em> bleibt nach erfolgter Abgabe <em>active</em> und wird erst nach der letzten möglichen Einlösung von der Fachanwendung automatisch auf <em>completed</em> gesetzt.</td>
        <td>type: FFC (First Fill - Complete)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>je Einlösung wird eine <em>Durchgeführte Abgabe</em> erstellt</td>
      </tr>
      <tr>
        <td>1. Teilabgabe</td>
        <td>active</td>
        <td><em>Geplante Abgabe</em> bleibt <em>active</em></td>
        <td>type: FFP (First Fill - Part Fill)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>Je Teilabgabe wird eine <em>Durchgeführte Abgabe</em> erstellt. <em>Geplante Abgabe</em> kann nicht mehr in einer anderen Apotheke abgegeben werden</td>
      </tr>
      <tr>
        <td>Weitere Teilabgabe</td>
        <td>active</td>
        <td><em>Geplante Abgabe</em> bleibt <em>active</em></td>
        <td>type: RFP (Refill – Part Fill)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Letzte Teilabgabe</td>
        <td>completed</td>
        <td><em>Geplante Abgabe</em> bleibt <em>active</em>, solange weitere Einlösungen möglich. Danach setzt die Fachanwendung den Status der <em>Geplanten Abgabe</em> auf <em>completed</em>.</td>
        <td>type: RFC (Refill - Complete)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>"Besorgerprozess": Arzneimittel von Apotheke bestellt / zubereitet (ohne Abgabe)</td>
        <td>active</td>
        <td><em>Geplante Abgabe</em> bleibt <em>active</em></td>
        <td>type: FFP (First Fill - Part Fill)<br>quantity: 0 Packungen (wurden ausgegeben)<br>status: „completed“</td>
        <td>Arzneimittel bestellt oder Magistrale Zubereitung in Vorbereitung.</td>
      </tr>
      <tr>
        <td>"Besorgerprozess": Arzneimittel nach Teilabgaben von Apotheke bestellt (ohne Abgabe)</td>
        <td>active</td>
        <td><em>Geplante Abgabe</em> bleibt <em>active</em></td>
        <td>type: FFP (Refill – Part Fill)<br>quantity: 0 Packungen (wurden ausgegeben)<br>status: „completed“</td>
        <td>Arzneimittel nach bereits erfolgter Teilabgabe bestellt oder Magistrale Zubereitung in Vorbereitung.</td>
      </tr>
      <tr>
        <td>Leerabgabe beendet Einzelabgabe</td>
        <td>cancelled</td>
        <td>wenn alle möglichen Einlösungen mit <em>cancelled</em> gespeichert wurden, wird die zugehörige <em>Geplante Abgabe</em> automatisch auf <em>cancelled</em> gesetzt, sonst auf <em>completed</em>.</td>
        <td>type: FFC (First Fill - Complete)<br>quantity: 0 Packungen<br>status: „cancelled“</td>
        <td>Das Arzneimittel einer Geplanten Abgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt.</td>
      </tr>
      <tr>
        <td>Leerabgabe beendet Teilabgabe</td>
        <td>completed oder cancelled</td>
        <td>wenn alle möglichen Einlösungen mit <em>cancelled</em> gespeichert wurden, wird die zugehörige <em>Geplante Abgabe</em> automatisch auf <em>cancelled</em> gesetzt, sonst auf <em>completed</em>.</td>
        <td>type: RFC (Refill - Complete)<br>quantity: 0 Packungen<br>status: „cancelled“</td>
        <td>Teilabgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt. Dieser Einlösevorgang ist damit beendet.</td>
      </tr>
      <tr>
        <td>Notabgabe</td>
        <td>-</td>
        <td>keine <em>Geplante Abgabe</em> vorhanden</td>
        <td>type: FFC (First Fill - Complete)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>Das Medikament wurde ohne zugrundeliegende <em>Geplante Abgabe</em> abgegeben. Ein Planeintrag kann nacherfasst werden.</td>
      </tr>
      <tr>
        <td>OTC Abgabe (rezeptfrei)</td>
        <td>-</td>
        <td>keine <em>Geplante Abgabe</em> vorhanden</td>
        <td>type: FFC (First Fill - Complete)<br>quantity: x Packungen<br>status: „completed“</td>
        <td>Rezeptfreies Medikament wurde abgegeben. Ein Planeintrag kann nacherfasst werden.</td>
      </tr>
    </tbody>
  </table>
</div>
