{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_03) -->

### Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) eines ELGA-Teilnehmers abrufen, um verordnete (rezeptierte) Arzneimittel einzusehen.

ELGA-Teilnehmer können *Geplante Abgaben* über das Zugangsportal einsehen. 

*Geplante Abgaben* bilden die Inhalte des e-Rezepts ab. Wurden mehrere Arzneimittel verordnet und sind demselben e-Rezept zugeordnet, sind die zugehörigen *Geplanten Abgaben* mit demselben *e-Med GroupIdentifier* versehen, den auch das e-Rezept mitführt (bildet damit die Rezept-Klammer). 

Der **Standardzugriff** (*Prescription-Search*) erfolgt nach **Kontaktbestätigung** des ELGA-Teilnehmers (z.B. mittels e-card). Der GDA erhält dadurch lesenden Zugriff auf die e-Medikation inkl. aller *Geplanten Abgaben* und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_05_01 - Durchgeführte Abgabe schreiben](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-schreiben)). Zusätzlich kann der GDA auf *Durchgeführte Abgaben* und den *Medikationsplan* zugreifen, um die *Geplanten Abgaben* im Kontext der gesamten Medikation zu beurteilen. 
<!-- TODO: Link auf Medikationsplan lesen einfügen -->

Als **alternative Zugriffsart** zur Kontaktbestätigung steht der **Zugriff mittels *e-Med GroupIdentifier*** (z.B. über den DataMatrix-Code eines e-Rezepts) zur Verfügung (*GroupIdentifier-Search*). Dieser ermöglicht ausschließlich einen eingeschränkten ELGA-Zugriff auf die dem e-Med GroupIdentifier zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben* und wird in [Sub_UC_eMed_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_03.html) beschrieben.

Bei **Prescription-Search** stellt die Fachanwendung alle *MedicationRequest*-Ressourcen mit der Kategorie *Geplante Abgabe* des ELGA-Teilnehmers bereit, die den angegebenen Suchkriterien entsprechen. 


##### Ablauf

1. Der GDA führt ein **GET** auf **MedicationRequest** mit der Kategorie **Geplante Abgabe** aus.<br> Folgende Suchparameter werden unterstützt: 
    - Zeitraum der Erfassung der *Geplanten Abgabe*
    - Medikation: PZN/Name bzw. Wirkstoff
        <!-- - Bei Angabe eines Wirkstoffs werden Wirkstoff-Angaben und Magistrale Zubereitungen durchsucht. -->
    - Einnahmezeitraum der Medikation der *Geplanten Abgabe* (extension:effectiveDosePeriod)
    - [status](ValueSet-GeplanteAbgabeStatusVS.html) der *Geplanten Abgabe* [active | completed | entered-in-error | stopped | cancelled ]
    - *Geplante Abgabe* zu einer *Durchgeführten Abgabe* 
    - *id* des Planeintrags, auf welchem die *Geplante Abgabe* basiert
    - alle *Geplanten Abgaben* zu einem *e-Med groupIdentifier*

2. Die Fachanwendung ermittelt alle den Suchkriterien entsprechenden *Geplanten Abgaben*.
3. Die Fachanwendung liefert das Suchergebnis als **Bundle (type = searchset)** mit sämtlichen den Suchkriterien entsprechenden *MedicationRequest*-Ressourcen.
4. Werden keine passenden Ressourcen gefunden, wird ein **leeres Searchset-Bundle** zurückgegeben.
5. Kann die Anfrage nicht verarbeitet werden, antwortet die Fachanwendung mit einer geeigneten **HTTP-4xx**-Antwort und einem **OperationOutcome**.
5. Optional kann der GDA zusätzlich den *Medikationsplan* oder *Durchgeführte Abgaben* abrufen.

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
ad: *Geplante Abgabe* zu einer Durchgeführten Abgabe:<br>
- Reverse-Include erlaubt oder eigene Operation?
</p>
</div>

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
ad: Suchparameter:<br>
- Gültigkeitszeitraum des Rezepts (validityPeriod)? 
</p>
</div>

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_01.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_01.svg)


<!-- ###### Suchparameter

Mögliche Suchparamter: (in Arbeit)
- category
- status
- validityPeriod
- groupIdentifier -->


### Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann *Durchgeführte Abgaben* eines ELGA-Teilnehmers abrufen, um bereits dokumentierte Arzneimittelabgaben einzusehen.

ELGA-Teilnehmer können *Durchgeführte Abgaben* über das Zugangsportal einsehen. 

*Durchgeführten Abgaben* spiegeln den Status der Abgaben des e-Rezepts wider. Eine *Durchgeführte Abgabe*, die auf einer *Geplanten Abgabe* basiert, enthält den *e-Med GroupIdentifier* der zugehörigen *Geplanten Abgabe* enthalten. Dadurch können zusammengehörige *Geplante Abgaben* und *Durchgeführte Abgaben* über denselben *e-Med GroupIdentifier* identifiziert und gemeinsam abgerufen werden.

Der **Standardzugriff** (*Dispense-Search*) auf *Durchgeführte Abgaben* erfolgt nach **Kontaktbestätigung** des ELGA-Teilnehmers (z.B. mittels e-card). Dadurch erhält der GDA lesenden Zugriff auf alle *Durchgeführten Abgaben* des ELGA-Teilnehmers. 
Zusätzlich kann der GDA lesend auf *Geplante Abgaben* und den *Medikationsplan* zugreifen, um die *Durchgeführten Abgaben* im Kontext der gesamten Medikation zu beurteilen.
<!-- TODO: Link auf Medikationsplan lesen + Geplante Abgaben lesen einfügen -->

Als **alternative Zugriffsart** zur Kontaktbestätigung steht der **Zugriff mittels *e-Med GroupIdentifier*** (z.B. über den DataMatrix-Code eines e-Rezepts) zur Verfügung (*GroupIdentifier-Search*). Dieser ermöglicht ausschließlich einen eingeschränkten ELGA-Zugriff auf die dem e-Med GroupIdentifier zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben* und wird in [Sub_UC_eMed_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_03.html) beschrieben.

Bei **Dispense-Search** stellt die Fachanwendung alle *MedicationDispense*-Ressourcen des ELGA-Teilnehmers bereit, die den angegebenen Suchkriterien entsprechen. 

##### Ablauf

1. Der GDA führt einen **GET**-Request auf **MedicationDispense** aus. Die Suche kann optional anhand von Suchparametern eingeschränkt werden. <br>Folgende Suchparameter werden unterstützt: 
- Zeitraum der Erfassung der *Durchgeführten Abgabe*
- Medikation: PZN/Name bzw. Wirkstoff
- [status](ValueSet-DurchgefuehrteAbgabeStatusVS.html) der *Durchgeführten Abgabe* [completed | cancelled | entered-in-error]
- [type](ValueSet-DurchgefuehrteAbgabeTypVS.html) (Abgabeart)
- *Durchgeführte Abgaben* zu einer *Geplanten Abgabe*
- *id* des Planeintrags, auf welchem die *Durchgeführte Abgabe* basiert
- alle *Durchgeführten Abgaben* zu einem *e-Med groupIdentifier*

2. Die Fachanwendung ermittelt alle den Suchkriterien entsprechenden *Durchgeführten Abgaben* des ELGA-Teilnehmers.
3. Die Fachanwendung liefert das Suchergebnis als **Bundle (type = searchset)** mit den entsprechenden *MedicationDispense*-Ressourcen.
4. Werden keine passenden Ressourcen gefunden, wird ein **leeres Searchset-Bundle** zurückgegeben.
4. Kann die Anfrage nicht verarbeitet werden, antwortet die Fachanwendung mit einer geeigneten **HTTP-4xx**-Antwort und einem **OperationOutcome**.
5. Optional kann der GDA zusätzlich den *Medikationsplan* oder *Geplante Abgaben* abrufen.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>
Suchparameter auf Vollständigkeit prüfen
</p>
</div>

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_02.svg)

<!-- im Diagramm die Optionale Box über das GET schieben: -> würde optionale aufrufe hinten anreihen damit der fokus hier auf dispense-search liegt und lesefluss einfacher ist. dem client können wir hier sowieso keine reihenfolge vorgeben. -->


<!-- ###### Suchparameter

-> Suchparameter wurden direkt in den Ablauf verschoben -> analog zu Geplante Abgaben

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>
Suchparameter
</p>
</div>

Mögliche Suchparamter: (in Arbeit)
- Zeitraum der Erfassung der durchgeführten Abgabe
- Medikation: PZN/Name bzw. Wirkstoff
- [status](ValueSet-DurchgefuehrteAbgabeStatusVS.html) der durchgeführten Abgabe [completed | cancelled | entered-in-error]
- [type](ValueSet-DurchgefuehrteAbgabeTypVS.html) (Abgabeart)
- Durchgeführte Abgaben zu einer geplanten Abgabe
- id des Planeintrags auf welchem die durchgeführte Abgabe basiert
- alle durchgeführten Abgaben zu einem groupIdentifier -->



<!-- Todo: entered-in-error nicht, weil nur eigene verworfen werden können? -->

### Sub_UC_eMed_03_03 - Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen (GroupIdentifier-Search)

Erfolgt die Arzneimittelabgabe **ohne Kontaktbestätigung** des ELGA-Teilnehmers, sondern auf Basis eines *e-Med GroupIdentifier* (z.B. über den DataMatrix-Code eines e-Rezepts), erhält ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) einen eingeschränkten ELGA-Zugriff. 

Dieser umfasst ausschließlich den lesenden Zugriff auf die dem *e-Med GroupIdentifier* zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben*. Der GDA kann anschließend *Durchgeführte Abgaben* ausschließlich für diesen *e-Med GroupIdentifier* dokumentieren (siehe *Sub_UC_eMed_05_01 - Durchgeführte Abgaben mittels e-Med GroupIdentifier schreiben*).

Ein lesender Zugriff auf weitere *Geplante Abgaben* oder *Durchgeführte Abgaben* sowie auf den Medikationsplan des ELGA-Teilnehmers ist nicht möglich. Ebenso können keine weiteren *Durchgeführten Abgaben* (z.B. OTC- oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers dokumentiert werden.

<!-- Todo: Wie Zugriff auf alle selbst erstellten Ressourcen möglich? -->

##### Ablauf

1. Der GDA führt die Custom Operation **POST** [$groupidentifier-search](OperationDefinition-AtElgaEmed.GroupIdentifier.Search.html) aus und übermittelt einen *e-Med GroupIdentifier*.
2. Die Fachanwendung führt eine **Prüfung** des übermittelten *e-Med GroupIdentifier* durch.
3. Ist der *e-Med GroupIdentifier* gültig, ermittelt die Fachanwendung alle *MedicationRequest*-Ressourcen der Kategorie *Geplante Abgabe*, die dem übermittelten *e-Med GroupIdentifier* entsprechen.
   <!-- 4 Ergibt die Suche mindestens eine offene Geplante Abgabe, ermittelt die Fachanwendung zusätzlich alle zugehörigen MedicationDispense*-Ressourcen mit: dem übermittelten e-Med GroupIdentifier und status = completed oder cancelled -->
4. Die Fachanwendung ermittelt zusätzlich alle *MedicationDispense*-Ressourcen, die dem übermittelten *e-Med GroupIdentifier* entsprechen.
5. Die Fachanwendung liefert die ermittelten *MedicationRequest*- und *MedicationDispense*-Ressourcen als **Bundle** vom Typ *searchset* zurück.
6. Ergibt die Suche keine passenden *Geplanten Abgaben* oder *Durchgeführten Abgaben*, liefert die Fachanwendung ein **leeres Bundle** vom Typ *searchset* zurück.
7. Ist der *e-Med GroupIdentifier* ungültig, lehnt die Fachanwendung die Operation ab und liefert einen entsprechenden *OperationOutcome* zurück.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_03.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_03.svg)

<!--TODO: je nach Entscheidung, ob wirklich nur bei gefundenen geplanten auch die durchgeführten gesucht werden muss evtl. das Diagramm angepasst werden. -->


##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$groupidentifier-search: in Arbeit.
</p>
</div>

