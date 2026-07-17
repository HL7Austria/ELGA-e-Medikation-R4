{% include styleheader.md %}

<!-- Transaktionen -->

<!-- <br>
[![diagram](eMed_Interactions.png){: style="width: 60%"}](eMed_Interactions.png) -->

<br>
<div>{% include_relative plantuml/interaction_overview.svg %}</div>
<br>


### `/`

| Operation | HTTP | Rollen | Beschreibung |
|-----------|------|---------|--------------|
| `$groupidentifier-create` | POST | GDA | Erzeugen eines neuen e-Med GroupIdentifiers für Geplante Abgaben |
| `$groupidentifier-search` | POST | GDA | Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen |

---

### `/Patient/{id}/List`

| Operation | HTTP | Rollen | Beschreibung |
|-----------|------|---------|--------------|
| `$plan-read` | POST | GDA, PAT | Aktuelle Medikationsplanversion lesen |
| `$plan-write` | POST | GDA | Neue Version eines Medikationsplans schreiben |
| `$patient-plan-write` | POST | PAT | Medikationsplaneinträge löschen |
| `$plan-delete` | POST | PAT | Aktuelle oder historische Medikationsplanversion löschen |
| `plan-history-search` | GET | GDA, PAT | Historische Medikationsplanversion(en) lesen<br>(`_history?_include=*` bzw.<br>`_include=*&item=MedicationRequest/{id}&subject=Patient/{id}&date=...`) |
| `plan-history-directory-search` | GET | GDA, PAT | Verzeichnis historischer Medikationspläne abrufen<br>(`_history?_elements=date,source`) |

---

### `/Patient/{id}/MedicationRequest`

| Operation | HTTP | Rollen | Beschreibung |
|-----------|------|---------|--------------|
| `$prescription-write` | POST | GDA | Geplante Abgabe schreiben |
| `$prescription-discard` | POST | GDA | Eigene geplante Abgabe verwerfen |
| `prescription-search` | GET | GDA, PAT | Geplante Abgaben suchen<br>(`?category=GeplAbgabe`) |
| `planentry-search` | GET | GDA, PAT | Medikationsplaneinträge suchen<br>(`?category=Planeintrag`) |
| `prescription-delete` | DELETE | PAT | Geplante Abgabe löschen |

---

### `/Patient/{id}/MedicationDispense`

| Operation | HTTP | Rollen | Beschreibung |
|-----------|------|---------|--------------|
| `$dispense-write` | POST | GDA | Durchgeführte Abgabe schreiben |
| `$dispense-discard` | POST | GDA | Eigene durchgeführte Abgabe verwerfen |
| `$reference-plan` | POST | GDA | Referenz auf Medikationsplan erstellen |
| `dispense-search` | GET | GDA, PAT | Durchgeführte Abgaben suchen |
| `dispense-delete` | DELETE | PAT | Durchgeführte Abgabe löschen |