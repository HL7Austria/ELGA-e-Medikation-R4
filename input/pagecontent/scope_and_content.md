{% include styleheader.md %}

### Umfang des Implementation Guides

Dieser Implementation Guide beschreibt die technische Umsetzung der ELGA e-Medikation (Version 4) auf Basis von HL7® FHIR® R4. Er umfasst:

* den **[Medikationsplan](StructureDefinition-at-elga-emed-list-medikationsplan.html)** mit seinen [Planeinträgen](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html) und deren [Versionierung](design_choices.html#versionierung),
* die **[Geplanten Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html)** (mit Bezug zu einem Planeintrag),
* die **[Durchgeführten Abgaben](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html)**,
* die Abbildung von **[Arzneimitteln](medication.html)** (Arzneispezialitäten mit PZN, Wirkstoffangaben und magistrale Zubereitungen) und **[Dosierungen](dosages.html)**,
* die **[Schnittstellen](interactions.html)** der zentralen e-Medikation-Fachanwendung, d.h. die lesenden und schreibenden Transaktionen inklusive der dafür definierten Custom-Operations,
* die **[Statusmodelle und Konsistenzregeln](workflowmanagement.html)** (Workflowmanagement) zwischen Medikationsplan, Planeinträgen, Geplanten und Durchgeführten Abgaben.

#### Nicht im Umfang

* **Patientenkontakt und Zugriffssteuerung:** Wie der Kontext eines ELGA-Teilnehmers hergestellt und der Zugriff berechtigt wird, ist in der [Lösungsarchitektur](https://dev.elga.gv.at/apis/emed/v0.0.1/emed-fhir-anbindung/) beschrieben. Die Requests werden in diesem IG daher ab dem `/[type]` dargestellt (siehe [Transaktionen](interactions.html)).
* **Migration und Parallelbetrieb:** Zu Mapping, Migration und Parallelbetrieb mit der bestehenden CDA-basierten e-Medikation (Version 2, siehe [Hintergrund](background.html)) wird nur ein Ausblick in den [Herausforderungen](challenges.html) beschrieben.
* **Integration in Softwaresysteme:**
Die konkrete Gestaltung von Benutzeroberflächen und die Einbettung in lokale Arbeitsabläufe sind nicht Gegenstand dieses Implementation Guides. Zur Veranschaulichung zeigt ein [Clickdummy](https://www.figma.com/proto/BtrsW5Jb5s73A26ly5UcS9/ELGA-e-Medikation?node-id=199-14052&viewport=405%2C479%2C0.14&t=MPQWY1MpmDc1EUyi-1&scaling=scale-down&content-scaling=fixed&starting-point-node-id=199%3A14052&show-proto-sidebar=1&page-id=199%3A11859) exemplarisch, wie ausgewählte Anwendungsfälle aus ärztlicher Sicht in einem Arztinformationssystem umgesetzt werden könnten. Er dient als Diskussionsgrundlage und stellt keine verbindliche Vorgabe für die Gestaltung von Softwaresystemen dar. Der [Clickdummy](https://www.figma.com/proto/BtrsW5Jb5s73A26ly5UcS9/ELGA-e-Medikation?node-id=199-14052&viewport=405%2C479%2C0.14&t=MPQWY1MpmDc1EUyi-1&scaling=scale-down&content-scaling=fixed&starting-point-node-id=199%3A14052&show-proto-sidebar=1&page-id=199%3A11859) wird unabhängig vom Implementation Guide laufend weiterentwickelt und erweitert.


### Aufbau des Implementation Guides

Der IG ist in folgende Bereiche gegliedert (siehe auch Menüleiste bzw. [Inhaltsverzeichnis](toc.html)):

|**Bereich** |**Inhalt**|
|---|---|
|**Einleitung** | [Umfang und Inhalt](scope_and_content.html) (diese Seite), [Hintergrund](background.html) zur Ablöse der CDA-basierten e-Medikation, [Herausforderungen](challenges.html) bei Mapping und Parallelbetrieb |
|**Funktionales** | [Designentscheidungen](design_choices.html) (Ressourcenmodell, Must-Support-Ansatz, Versionierung, ID-Management, Locking u.a.), [Workflowmanagement](workflowmanagement.html) (Statusmodelle und Konsistenzregeln), [Transaktionen](interactions.html) (Übersicht aller Endpunkte und Operations), [Dosierungen](dosages.html), [Medikation](medication.html) |
|**Anwendungsfälle** | [Überblick](overview_sub_use_case.html) sowie die technischen Use Cases [UC 1](Sub_UC_eMed_01.html) bis [UC 5](Sub_UC_eMed_05.html) mit Sequenzdiagrammen und relevanten Elementen; die [Patient Journey](patient_journey.html) zeigt anhand eines durchgängigen Beispiels, wie sich Medikationsplan und Abgaben über die Zeit verändern |
|**Artifacts** | Alle technischen Artefakte: Profile, Extensions, OperationDefinitions, SearchParameter, ValueSets, CodeSystems und Beispiele (siehe [Artifacts](artifacts.html)) |
|**About** |[Autoren](contributors.html), [Downloads](downloads.html), [Publikationsinformationen](publication_info.html), [Dependencies](dependencies.html), [Copyright](copyright.html) und [Impressum](imprint.html) |


#### Artefakte im Überblick

Die Profile sind auf der Seite [Artifacts](artifacts.html) nach fachlichen Gruppen geordnet:

* **Medikationsplan:** Medikationsplan (*List*), Planeintrag (*MedicationRequest*), Medikationsplan-Bundle für lesende Zugriffe sowie Transaction Bundle für schreibende Zugriffe
* **Geplante Abgabe:** Geplante Abgabe (*MedicationRequest*) und zugehöriges Transaction Bundle
* **Durchgeführte Abgabe:** Durchgeführte Abgabe (*MedicationDispense*) und zugehöriges Transaction Bundle
* **Medikation:** Arzneispezialität mit PZN und magistrale Zubereitung (*Medication*)
* **Dosierungen:** Dosierung, Dosierschemata und Timing (*Dosage*, *Timing*)
* **Stammdaten:** Patient, Practitioner, Organization (abgeleitet von den Profilen des HL7 Austria FHIR Core IG)
* **Suchparameter**
* **OperationDefinitions** der Custom-Operations
* **Extensiohns:** Erweiterungen der Basisprofile
* **Terminologien:** ValueSets und Codesystemee
* **Example Instances:** Beispielressourcen

Für Elemente, die in FHIR R4 noch nicht verfügbar sind, werden Cross-Version-Extensions aus FHIR R5 verwendet (z.B. `effectiveDosePeriod` im [Planeintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html)). Die verwendeten Pakete sind unter [Dependencies](dependencies.html) gelistet.

### Wie die Profile zu lesen sind

Jede Profilseite (StructureDefinition) zeigt die Elemente des Profils in mehreren Ansichten, die über Tabs gewechselt werden können. Für die Arbeit mit diesem Leitfaden sind vor allem drei davon relevant:

| Ansicht | Was ist zu sehen? | Wofür ist sie gedacht? |
|---|---|---|
| **Key Elements** | Alle mit **Must Support (MS)** gekennzeichneten Elemente – also jene Elemente, die von der e-Medikation-Fachanwendung fachlich verarbeitet, gespeichert und für die Anzeige bereitgestellt werden. Inklusive Kardinalitäten, fixe Werte, Terminologie-Bindings, Slices und Extensions dieser Elemente. | **Einstiegspunkt für die Implementierung.** Diese Ansicht zeigt kompakt, welche Elemente ein System befüllen bzw. verarbeiten können muss. |
| **Differential** | Nur jene Elemente, die gegenüber dem Basisprofil verändert wurden: Einschränkungen von Kardinalitäten, MS-Kennzeichnungen, fixe Werte, Terminologie-Bindings, Slices, Extensions und **entfernte Elemente (Kardinalität 0..0)**. | Nachvollziehen, **was dieses Profil festlegt**, und insbesondere erkennen, **welche Elemente bewusst ausgeschlossen** wurden. |
| **Snapshot** | Die vollständige Struktur der Ressource mit **allen** Elementen – auch jenen, die nicht MS sind und im Rahmen der e-Medikation nicht explizit verwendet werden. | Vollständige Sicht, v.a. **für den Review** relevant: Hier wird sichtbar, welche Elemente der Ressource zwar zulässig sind, aber nicht unterstützt werden. |

#### Must Support, nicht unterstützte und entfernte Elemente

Aus den Ansichten ergeben sich drei Arten von Elementen, die unterschiedlich behandelt werden (Details unter [Kennzeichnung der relevanten Elemente](design_choices.html#kennzeichnung-der-relevanten-elemente)):

* **Elemente mit MS-Kennzeichnung** (sichtbar im Tab *Key Elements*) werden von der Fachanwendung fachlich verarbeitet und gespeichert. Ob ein Element tatsächlich befüllt werden muss, ergibt sich aus seiner Mindestkardinalität und gegebenenfalls aus Invarianten. Bei komplexen Elementen gilt die [MS-Kennzeichnung](design_choices.html#must-support-profilierung) nur für jene Unterelemente, die selbst als MS gekennzeichnet sind.
* **Elemente ohne MS-Kennzeichnung** (nur im Tab *Snapshot* sichtbar) sind zulässig, werden aber nicht verarbeitet. Die Fachanwendung ignoriert sie und weist in der Response per `OperationOutcome` (`severity = information`) darauf hin (siehe [Serverhalten bei Elementen ohne MS Markierung](design_choices.html#serverhalten-bei-elementen-ohne-ms-markierung)).
* **Elemente mit Kardinalität 0..0** (im Tab *Differential* sichtbar) wurden aufgrund einer fachlichen Entscheidung ausgeschlossen und DÜRFEN NICHT übermittelt werden; ein Request, der sie enthält, wird abgelehnt (siehe [Kardinalitäten](design_choices.html#kardinalitäten)). Die Begründung für den Ausschluss ist jeweils in der Kurzbeschreibung (*short*) des Elements als „Fachliche Begründung: …“ dokumentiert.

<div class="dragon" markdown="1">
<div class="note-to-balloters" markdown="1">

Um zu prüfen, ob für ein bestimmtes Element eine fachliche Entscheidung getroffen wurde, empfiehlt sich der Vergleich von *Snapshot* und *Differential*: Ist ein Element im *Snapshot* vorhanden, aber weder als MS gekennzeichnet noch im *Differential* auf 0..0 gesetzt, wurde zu diesem Element bisher keine Festlegung getroffen. Feedback, ob solche Elemente doch unterstützt oder ausgeschlossen werden sollen, ist ausdrücklich erwünscht.

</div>
</div>

#### Weitere Inhalte der Profilseiten

Neben den Tabellen enthalten die Profilseiten – sofern vorhanden – eine fachliche Einleitung, ergänzende Hinweise zur Befüllung (z.B. zu [Statuswerten](workflowmanagement.html) oder zur Narrative), Constraints (Invarianten), Terminologie-Bindings, Suchparameter, Verweise auf Beispiele sowie Hinweise zur Generierung des Narrative (siehe [Befüllung der Narrativen Teile](design_choices.html#befüllung-der-narrativen-teile)). Die Beispiele aus der [Patient Journey](patient_journey.html) zeigen die Profile im Zusammenspiel.
