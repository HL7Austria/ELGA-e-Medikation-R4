{% include styleheader.md %}

### Überblick der Statusänderungen der e-Medikation Ressourcen 

#### Status-Änderungen der List-Flag (Medikationsplan)

Das *flag*-Element eines Entries in der List-Ressource beschreibt die Art der Änderung eines Planeintrags auf Listenebene und kann folgende Status einnehmen:

| Status | Beschreibung |
|--------|------|
| **New** | Neuer Planeintrag hinzugefügt |
| **Unchanged** | Planeintrag wird beibehalten/zur Kenntnis genommen |
|  **Changed**  | Planeintrag geändert |
|  **Removed**  | Planeintrag entfernt |

<div>{% include stateDiagram_list_flag.svg %}</div>





#### Status-Änderungen des MedicationRequests im Medikationsplaneintrag

Das *status*-Element kann in Planeinträgen foglende Status einnehmen:

| Status | Beschreibung |
|--------|------|
| **active** | Planeintrag ist aktiv/gültig |
| **on-hold** | Planeintrag ist pausiert |
| **completed** | Planeintrag ist beendet (automatisch durch Ablauf des Behandlungszeitraums, 
wenn keine erneute Verordnung) TODO: zu prüfen, ob dieser Status benötigt wird |
| **stopped** | Planeintrag ist abgesetzt (vor Ablauf des Behandlungszeitraums) |
| **entered-in-error** | Storno/falscher Planeintrag |

<div>{% include stateDiagram_mr_status_planeintrag.svg %}</div>


##### Planeintrag-Status in Abhängigkeit des Flag-Status des Medikationsplans

| Use Case | List-Flag | MedicationReqeust-Status      (Planeintrag) | Beschreibung |  |
|---|---|---|---|---|
| Neuen Planeintrag zum Medikationsplan hinzufügen | **New** | **active** | Neuer Planeintrag wird erstellt und ist aktiv<br> * der Behandlungszeitraum kann in der Zukunft liegen<br> * Bereits bestehender Planeintrag kann wieder reaktiviert werden (Client-SW) |  |
|  |  | **on-hold** | Neuer Planeintrag wird erstellt, wird aber pausiert  |  |
| Planeintrag beibehalten/zur Kenntnis nehmen | **Unchanged** | **active**  | Bestehender Planeintrag bleibt unverändert<br> * der Behandlungszeitraum darf noch nicht abgelaufen sein |  |
|  |  | **on-hold** | wie **active** |  |
| Planeintrag ändern | **Changed** | **active** | Bestehender Planeintrag wird geändert |  |
|  |  | **on-hold** | Bestehender Planeintrag wird geändert, wird aber pausiert |  |
| Planeintrag entfernen | **Removed**  | **completed** | Bestehender Planeintrag wird beendet (durch Ablauf des Behandlungszeitraums,<br> wenn keine erneute Verordnung) TODO: fachlich prüfen, ob dieser Status   benötigt wird |  |
|  |  | **stopped** | Bestehender Planeintrag wird vor Ablauf des Behandlungszeitraums abgesetzt  |  |
|  |  | **entered-in-error** | Bestehender Planeintrag wird storniert, aufgrund falscher Eingabe |  | 

#### Status-Änderungen des MedicationRequests in der geplanten Abgabe
TODO

#### Status-Änderungen des MedicationDispense (durchgeführte Abgabe)
TODO