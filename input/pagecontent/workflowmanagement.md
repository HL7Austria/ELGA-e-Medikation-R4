### Überblick der Statusänderungen der e-Medikation Ressourcen 

<br>

#### Status des List.entry.flags im Medikationsplan

Ein *Medikationsplaneintrag* kann, abhängig vom jeweiligen ([Use Case für Medikationsplan schreiben](Sub_UC_eMed_06.html#%E2%80%8Btechnische-use-cases-für-medikationsplan-schreiben-uc_emed_06)), unterschiedliche Status einnehmen. Dieser Status wird sowohl in der MedicationRequest-Ressource selbst als auch auf List-Ebene im Element List.entry.flag dokumentiert.

Das *flag*-Element eines Entries der List-Ressource beschreibt die **Art der Änderung eines Mediaktionsplaneintrags auf Listenebene** und kann folgende Status einnehmen:
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

Je nach Zugriffsart (Plan-History-Read, Plan-Read oder Write) ergeben sich unterschiedliche Auswirkungen auf die Verarbeitung dieser Status sowie auf die enthaltenen Ressourcen in den jeweiligen Bundles (siehe [Transaktionen](interactions.html)).
<br>
<br>

| List.entry.flag | Plan-History-Read | Plan-Read | Plan-Write |
|--------|------|------|------|
| **new** |- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, bleiben beim Plan-History-Read **unverändert**.<br>- Die neuen MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *new* geflaggt wurden, werden beim Plan-Read von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *new* geflaggt wurden, werden dem Medikationsplan neu hinzugefügt.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
| **unchanged** |- List-Entries, die vom Vorgänger-GDA mit *unchanged* geflaggt wurden, bleiben beim Plan-History-Read **unverändert**.<br>- Die unveränderten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA als *unchanged* geflaggt wurden, bleiben beim Plan-Read von der Fachanwendung unverändert.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom aktuellen GDA nicht verändert wurden, bleiben beim schreibenden Zugriff mit *unchanged* geflaggt. Sie gelten somit als zur Kenntnis genommen.<br>-  Die betreffenden MedicationRequests sind nicht im Transaction Bundle enthalten, sondern werden in der Liste **nur referenziert**.|
|  **changed**  |- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, bleiben beim Plan-History-Read **unverändert**.<br>- Die geänderten MedicationRequests sind im Collection Bundle enthalten.|- List-Entries, die vom Vorgänger-GDA mit *changed* geflaggt wurden, werden beim Plan-Read von der **Fachanwendung** als **unchanged** geflaggt.<br>- Die betreffenden MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom aktuellen GDA mit *changed* geflaggt werden, wurden geändert.<br>- Die betreffenden MedicationRequests müssen im Transaction Bundle **enthalten** sein.|
|  **removed**  |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, bleiben beim Plan-History-Read **unverändert**.<br>- Die zum Entfernen markierten MedicationRequests sind im Collection Bundle enthalten. |- List-Entries, die vom Vorgänger-GDA mit *removed* geflaggt wurden, werden beim Plan-Read von der **Fachanwendung entfernt**.<br>- Die betreffenden MedicationRequests sind im Collection Bundle **nicht enthalten**.|- List-Entries, die beim schreibenden Zugriff vom aktuellen GDA mit *removed* geflaggt wurden, sollen aus dem Medikationsplan entfernt werden.<br>- Die betreffenden MedicationRequests werden u.a. mit dem entsprechenden Status geflaggt und müssen im Transaction Bundle **enthalten** sein. |

<br>

#### Status des MedicationRequests im Medikationsplaneintrag

Das *status*-Element der MedicationRequest-Ressource beschreibt den **aktuellen Zustand eines Medikationsplaneintrags**. 

Im Kontext des Medikationsplans kann dieses Element folgende Statuswerte annehmen: 
<br><br>

| MedicationRequest.status | Beschreibung |
|---------------|------|
| **active** | Planeintrag dokumentiert aktive Therapie: Medikation soll aktuell vom Patienten eingenommen werden |
| **on-hold** | Planeintrag ist pausiert: Therapie wurde vorübergehend unterbrochen, Wiederaufnahme ist vorgesehen |
| **completed** | Die im Planeintrag beschriebenen Maßnahmen wurden wie geplant durchgeführt. Der Planeintrag wird damit abgeschlossen.|
| **stopped** | Die im Planeintrag beschriebenen Maßnahmen werden dauerhaft gestoppt, bevor alle geplanten Einnahmen oder Verabreichungen durchgeführt wurden. Der Planeintrag wird damit abgeschlossen. |
| **entered-in-error** | Planeintrag ist storniert: Kennzeichnung eines fehlerhaften Planeintrages. Der Planeintrag wird damit abgeschlossen. |

<br>
<div>{% include_relative plantuml/workflow_mr_status_planeintrag.svg %}</div>
<br>

##### Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status

Da der Status eines Medikationsplaneintrags im Medikationsplan auf **zwei Ebenen** geführt wird (List.entry.flag und MedicationRequest.status), müssen diese beiden Ebenen zur Sicherstellung einer konsistenten Verarbeitung inhaltlich aufeinander abgestimmt sein. Die folgende Tabelle beschreibt die geltenden Konsistenzregeln zwischen List.entry.flag und MedicationRequest.status in Abhängigkeit vom jeweiligen Use Case:
<br><br>


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
      <th>List.entry.flag</th>
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
      <td><span style="font-weight:normal">Bestehender Planeintrag wird aufgrund eines Fehlers storniert</span></td>
    </tr>
  </tbody>
</table>

<br>

#### Status des MedicationRequests in der geplanten Abgabe

Eine [Geplante Abgabe](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) kann, abhängig vom jeweiligen ([Use Case für Geplante Abgabe schreiben](Sub_UC_eMed_08.html#%E2%80%8Btechnische-use-cases-für-geplante-abgabe-schreiben-uc_emed_08)), unterschiedliche Status einnehmen (Element *status*):<br><br>

<!-- Folgende Status sollen gemäß e-Rezept abgebildet werden: OFFEN, EINGELÖST, STORNIERT, ABGELAUFEN, NICHT_ABGEGEBEN<br> -->

<!-- Folgende Status sind gemäß required ValueSet medicationrequest-status verfügbar: https://hl7.org/fhir/R4/valueset-medicationrequest-status.html -->

| MedicationRequest.status | Beschreibung |
|--------|------|
| **active** | Geplante Abgabe **offen**: Status beim Erstellen einer Geplanten Abgabe, solange noch (Teil-)Abgaben offen sind (dh. Rezept kann noch eingelöst werden) |
|  **completed**  | Geplante Abgabe **eingelöst**: Der Status wird durch die Fachwendung **automatisch** gesetzt, wenn alle möglichen Einlösungen durchgeführt wurden. Sonderfall: Sollte im Anschluss eine Durchgeführte Abgabe den Status *entered-in-error* erhalten, setzt die Fachanwendung gegebenfalls die Geplante Abgabe automatisch wieder auf *active*. |
| **stopped** | Geplante Abgabe ist **abgelaufen**, d.h. der Einlösezeitraum für die ausgewählte Rezeptart (*category:recipetype*) ist überschritten; der Status wird **automatisch durch die Fachanwendung** gesetzt. Die Geplante Abgabe ist damit abgeschlossen. |
|  **entered-in-error**  | Geplante Abgabe wird aufgrund eines Fehlers verworfen. Es wurden noch **keine Abgaben durchgeführt**. Die Geplante Abgabe wird damit abgeschlossen. |
|  **cancelled**  | Geplante Abgabe erhält automatisch den Status **cancelled** ("nicht abgegeben"), wenn alle Durchgeführten Abgaben (jede Einlösung) den Status **cancelled** erhalten haben ("Leerabgabe"). Wird eine gecancelte Abgabe verworfen, wird die geplante Abgabe automatisch wieder aktiviert. |

<!-- |  **cancelled**  | Geplante Abgabe ist storniert, aufgrund eines Fehlers. Die Geplante Abgabe wurde zurückgezogen, **bevor eine Abgabe durchgeführt** wurde. Die Geplante Abgabe ist damit abgeschlossen. | -->

<!-- | **stopped** | Geplante Abgabe wird **nicht abgegeben**: Die geplante Abgabe wird dauerhaft **durch den GDA** gestoppt, auch wenn bereits Teilabgaben durchgeführt worden sind. Wenn die Geplante Abgabe **abgelaufen** ist, d.h. der Einlösezeitraum für die ausgewählte Rezeptart (*category:recipetype*) ist überschritten, wird der Status **automatisch durch die Fachanwendung** gesetzt. Die Geplante Abgabe ist damit abgeschlossen. | -->

<!-- Gemäß:  [active | completed | entered-in-error | stopped]. Bedeutung: active: offene, geplante Abgabe | completed: geplante Abgabe abgeschlossen | entered-in-error: nach fehlerhafter Eingabe; Storno nur möglich, wenn noch keine zugehörige Abgabe durchgeführt wurde | stopped: Verwendung zu prüfen (Status soll analog zu e-Rezept abgebildet werden)"
//(nicht verwendet: on-hold, cancelled, draft, unknown) -->

<!-- TODO: Status abgelaufen ist nur über das Datum und die Rezeptart ersichtlich? -->

<br>
<div>{% include_relative plantuml/workflow_mr_status_geplanteabgabe.svg %}</div>
<br>

#### Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart


| Rezeptart | Gültigkeit | Einlösungen | Verlängerung | Statuswechsel |
|-------|------|-------|------|------|
| Kassenrezept | 1 Monat ab Datum der Verordnung: Beginn des Gültigkeitszeitraums + 1 Monat + 1 Tag | 1× (kann nur in 1 Apotheke eingelöst werden) | Im Zuge des "Besorgerprozesses" (Medikament muss erst bestellt werden) wird bei einer gespeicherten Teilabgabe die gesamte Gültigkeitsdauer auf 3 Monate verlängert. | Ein Kassenrezept muss innerhalb von 1 Monat eingelöst werden, sonst erhält das Rezept den Status "abgelaufen" (*stopped*). |
| Privatrezept | 1 Monat ab Datum der Verordnung für die erste Einlösung; mindestens: Beginn des Gültigkeitszeitraums + 1 Monat + 1 Tag; maximal: Beginn des Gültigkeitszeitraums + 1 Jahr (+ 1 Tag?) | Bis zu 6× (durch den Verordner festgelegt); kann in mehreren Apotheken eingelöst werden (je nach Anzahl der Einlösemöglichkeiten) | Keine Verlängerung möglich. | Ein Privatrezept muss innerhalb von 1 Monat eingelöst werden, sonst erhält es den Status (*stopped*). |
| Substitutionsrezept | Angabe eines beliebigen Gültigkeitszeitraums durch den Verordner; Datum frei wählbar, aber später als das Beginndatum | 1× | Keine Verlängerung möglich. | Ein Substitutionsrezept erhält den Status (*stopped*), wenn das "Bis-Datum" erreicht ist. |


[^1] Die Anzahl der Einlösungen gibt an, wie viele Einlösungen auf ein Rezept durchgeführt werden dürfen bis die Verordnung auf dem Rezept und das Rezept den Status eingelöst(*completed*) erhält.<br>
[^2] Das Einlösen eines Rezepts nach Ablauf der Gültigkeit wird durch e-Medikation nicht verhindert. Die Abgabe wird in diesem Fall ohne Verordnungsbezug in e-Medikation gespeichert. Wird die Gültigkeitsdauer nicht angegeben, kann die Gültigkeitsdauer vom empfangenden System nur mit 1 Monat angenommen werden, gerechnet vom Erstellungsdatum an.
<br><br>

#### Status des MedicationDispense in der durchgeführten Abgabe

Eine [Durchgeführte Abgabe](design_choices.html#durchgeführte-abgabe-AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe-medicationdispense) kann, abhängig vom jeweiligen [Use Case für Durchgeführte Abgabe schreiben](Sub_UC_eMed_09.html), unterschiedliche Status einnehmen (Element *status*). 


| MedicationDispense.status | Beschreibung |
|--------|------|
| **completed** | Einzel- oder Teilabgabe wurde durchgeführt |
| **cancelled** | Durchgeführte Abgabe gecancelt: Der Patient benötigt die Medikation einer geplanten Abgabe nicht (Medikation "abgesetzt") |
| **entered-in-error** | Vorhandene Durchgeführte Abgabe (im Status *completed* oder *cancelled*) wird aufgrund eines Fehlers verworfen (eine mögliche beendete Geplante Abgabe, wird dadurch wieder *aktiv*)|


<!-- |  **preparation**  | Durchgeführte Abgabe wird vorbereitet (zubereitet oder bestellt) | -->


<br>
<div>{% include_relative plantuml/workflow_md_status_durchgefuehrteabgabe.svg %}</div>
<br>


#### Abhängigkeiten der Geplanten Abgabe und der Durchgeführten Abgaben


| Use Case                                              | Planeintrag (MedicationRequest-Status) | Beschreibung                                                            | geplante Abgabe (MedicationRequest-Status) | Status Verordnung CDA | Beschreibung                                                                                                                                                       | durchgeführte Abgabe (MedicationDispense-Status) | Status Abgabe CDA      | Beschreibung                                                                                                                                                                                                                                                                                  | Use Case                        |
| ----------------------------------------------------- | -------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------------ | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------ | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| Geplante Abgabe basierend auf Planeintrag erfassen    | active                                 | Planeintrag bleibt active, unabhängig von Status der gepanten Abgabe \* | active                                     | OFFEN                 | z.B. 6 Einlösungen bei Privatrezept                                                                                                                                |                                                  |                        | noch keine bzw. noch nicht alle mögl. Einlösungen erfolgt (mit Status completed)                                                                                                                                                                                                               |                                 |
| Geplante Abgabe beenden (durch Fachanwendung)         | active                                 | Planeintrag bleibt active, unabhängig von Status der gepanten Abgabe \* | completed                                  | EINGELÖST             | auf Basis der durchgeführten Abgaben automatisch gesetzt durch Fachanwendung; dh. Alle möglichen Einlösungen sind abgechlossen (entweder completed oder cancelled) | completed                                        | ABGEGEBEN              | alle möglichen Einlösungen erfolgt                                                                                                                                                                                                                                                            | Durchgeführte Abgabe erfassen   |
| Geplante Abgabe verwerfen                             | active                                 | Planeintrag bleibt active, unabhängig von Status der gepanten Abgabe \* | entered-in-error                           | STORNIERT             | bei fehlerhafter Eingabe, wenn noch keine Abgabe durchgeführt                                                                                                      |                                                  |                        | keine durchgeführten Abgaben vorhanden                                                                                                                                                                                                                                                        |                                 |
| Geplante Abgabe abgelaufen (durch Fachanwendung)      | active                                 | Planeintrag bleibt active, unabhängig von Status der gepanten Abgabe \* | stopped                                    | ABGELAUFEN            | automatisch erkannt durch Fachanwendung                                                                                                                            | kein relevanter Status                           | kein relevanter Status | noch keine bzw. noch nicht alle mögl. Einlösungen erfolgt<br>Zu abgelaufenen geplanten Abgaben können keine Abgaben mehr gespeichert werden. Die (nachträgliche) Speicherung von Abgaben zu einem abgelaufenen Rezept kann im Anlassfall allerdings ohne Verordnungsbezug erfolgen.           |                                 |
| Geplante Abgabe nicht abgegeben (durch Fachanwendung) | active                                 | Planeintrag bleibt active, unabhängig von Status der gepanten Abgabe \* | cancelled                                  | NICHT_ABGEGEBEN       | automatisch, wenn alle Einlösungen im MedicationDispense den Status "cancelled" erhalten haben                                                                     | cancelled                                        | ABGESETZT              | Apotheker dokumentiert in der durchgeführten Abgabe, dass der Patient das Medikament in der geplanten Abgabe nicht einnimmt (mit Packungen 0) (entspricht der Leerabgabe).<br>Kann wieder rückgängig gemacht werden (durch Storno) | Durchgeführten Abgabe abgesetzt |
|                                                       |                                        |                                                                         |                                            |                       |                                                                                                                                                                    | entered-in-error                                 | STORNIERT              | bei fehlerhafter Eingabe                                                                                                                                                                                                                                                                      | Durchgeführte Abgabe verwerfen  |

<br>* solange ein evtl. Behandlungszeitraum nicht überschritten

<br>


#### Varianten der (Teil-)Abgabe 

Im Element *MedicationDispense.type* einer durchgeführten Abgabe wird die Art der Abgabe dokumentiert, welche von der [Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart) (Anzahl Einlösungen) und vom Use Case abhängt.

| Use Case (pro Einlösung)                                   | Geplante Abgabe (MedicationRequest.status)                   | Beschreibung                                                                                          | Durchgeführte Abgabe (MedicationDispense)                                                             | Beschreibung                                                                                                                                                                               |
| ---------------------------------------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Vollständige Abgabe<br>Sub_UC_eMed_09_01_01 | completed, wenn letzte Einlösung abgeschlossen, sonst active | Geplante Abgabe wird nach erfolgter Dispense automatisch auf completed gesetzt                        | type: FFC (First Fill - Complete)<br>quantity:  x Packungen<br>status: „complete“                            | Dispense abgeschlossen; Kann nicht mehr verändert werden.                                                                                                                                  |
| "Besorgerprozess": Medikament von Apotheke bestellt<br>Sub_UC_eMed_09_01_02| active                                                       | Geplante Abgabe bleibt active                                                                         | type: FFP (First Fill - Part Fill)<br>quantity:  0 Packungen (wurden  ausgegeben)<br>status: „preparation?“   | Medikament bestellt oder Magistrale Zubereitung in Vorbereitung. Geplante Abgabe kann nicht mehr in einer anderen Apotheke abgegeben werden                                                |
| "Besorgerprozess": bestelltes Medikament wird ausgehändigt<br>Sub_UC_eMed_09_01_02 | completed                                                     | wenn Dispense completed, dann auch Geplante Abgabe completed                                            | type: RFC (Refill - Complete)<br>quantity:  x Packungen<br>status: „complete“                                | Durchgeführte Abgabe abgeschlossen                                                                                                                                                         |
| 1\. Teilabgabe                                             | active                                                       | Geplante Abgabe bleibt active                                                                         | type: FFP (First Fill - Part Fill)<br>quantity:  x Packungen<br>status: „complete“                           | 1\. Teilabgabe                                                                                                                                                                             |
| Weitere Teilabgabe                                         | active                                                       | Geplante Abgabe bleibt active                                                                         | type: RFP (Refill - Part Fill)<br>quantity:  x Packungen<br>status: „complete“                               | weitere Teilabgabe                                                                                                                                                                         |
| Vollständige Teilabgabe                                          | completed                                                     | nach der letzten Teilabgabe wird die Geplante Abgabe automatisch auf completed gesetzt                 | type:  RFC (Refill - Complete)<br>quantity:  x Packungen<br>status: „complete“                               | letzte Teilabgabe                                                                                                                                                                          |
| Leerabgabe bei Einzelabgabe                               | completed                                                     | die Geplante Abgabe wird automatisch auf completed gesetzt                                             | type: FFC (First Fill - Complete) bzw. RFC (Refill Complete)<br>quantity:  0 Packungen<br>status: „cancelled“ | Das Medikament einer geplanten Abgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt.                                                                                 |
| Leerabgabe beendet Teilabgaben                             | completed                                                     | nach einer Leerabgabe bei einer  Teilabgabe wird die Geplante Abgabe automatisch auf completed gesetzt | type: RFC (Refill - Complete)<br>quantity:  0 Packungen<br>status: „cancelled“                                | Das Medikament einer geplanten Abgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt. Dieser Einlösevorgang ist damit beendet.                                        |
| Notabgabe                                                  |  -                                                           | keine Geplante Abgabe vorhanden                                                                       | type: EM (Emergency Supply)<br>quantity:  x Packungen<br>status: „complete“                                  | Das Medikament wurde ohne zugrundeliegende Geplante Abgabe abgegeben.<br>Es wird kein Rezept nachgereicht                                                                                  |
| Rezept wird nachgebracht                                   |  -                                                           | keine Geplante Abgabe vorhanden                                                                       | type: SO (Script Owing)<br>quantity:  x Packungen<br>status: „complete“                                      | Medikament wurde abgegeben oder reserviert, das formale Rezept wird später nachgereicht.  Planeintrag + Geplante Abgabe für wechselwirkungsrelevante Medikamente soll nacherfasst werden. |
| OTC Abgabe (rezeptfrei)                                    |  -                                                           | keine Geplante Abgabe vorhanden                                                                       | type: OTC (hinzufügen)<br>quantity:  x Packungen<br>status: „complete“                                       | Rezeptfreies Medikament wurde abgegeben. Ein Planeintrag für wechselwirkungsrelevante Medikamente soll nacherfasst werden.                                                                |

<br>