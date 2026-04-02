{% include styleheader.md %}

### Überblick der Statusänderungen der unterschiedlichen Ressourcen 

#### Status-Änderungen der List-Flag (Medikationsplan)

Das *flag*-Element eines Entries in der List-Ressource beschreibt die Art der Änderung eines Medikationsplaneintrags auf Listenebene und kann folgende Status einnehmen:

| Status | Wert |
|--------|------|
| New | Neuen Planeintrag hinzufügen |
| Unchanged | Planeintrag beibehalten / zur Kenntnis nehmen |
| Changed | Planeintrag ändern |
| Removed | Planeintrag entfernen |

<div>{% include stateDiagram_list_flag.svg %}</div>


#### Status-Änderungen des MedicationRequests im Medikationsplaneintrag

Das *status*-Element beschreibt die Änderung eines MedicationRequests. Im Falle eines Planeintrags kann dieser foglende Status einnehmen:

| Status | Wert |
|--------|------|
| active | Planeintrag ist aktiv / gültig |
| on-hold | Planeintrag ist pausiert |
| completed | Eintrag ist beendet (automatisch durch Ablauf des Behandlungszeitraums, wenn keine erneute Verordnung) TODO: zu prüfen, ob dieser Status benötigt wird |
| stopped | Eintrag ist abgesetzt |
| entered-in-error | Storno / falscher Eintrag |


<div>{% include stateDiagram_mr_status_planeintrag.svg %}</div>


#### Status-Änderungen des MedicationRequests in der geplanten Abgabe
TODO

#### Status-Änderungen des MedicationDispense (durchgeführte Abgabe)
TODO