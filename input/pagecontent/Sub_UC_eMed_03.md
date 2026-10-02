{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_03) -->

Dieser technische Use Case beschreibt den lesenden Zugriff [berechtigter Akteure](actors.html#rollen-und-berechtigungen) auf:

* [Geplante Abgaben](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search), um vorgesehene Arzneimittelabgaben einzusehen,
* [Durchgeführte Abgaben](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search), um bereits erfolgte Arzneimittelabgaben einzusehen
* [Geplante und Durchgeführte Abgaben mit e-Med Groupidentifier](Sub_UC_eMed_03.html#sub_uc_emed_03_03---geplante-und-durchgeführte-abgaben-mittels-e-med-groupidentifier-lesen-groupidentifier-search), um die zu einem e-Rezept zugehörigen *Gepanten Abgaben* und *Durchgeführten Abgaben* abzurufen zu können.

Für ELGA-Teilnehmer und deren Vertretungen erfolgt der lesende Zugriff auf *Gepanten Abgaben* und *Durchgeführten Abgaben* über das ELGA-Zugangsportal. 

Für die übrigen Akteure erfolgt der lesende Zugriff über die e-Medikations-Schnittstelle des jeweiligen GDA-Systems. 

Dabei werden folgende **Zugriffsarten** unterschieden:

* **Zugriff mit Kontaktbestätigung**:
Der Standardzugriff erfolgt nach nach **Kontaktbestätigung** des ELGA-Teilnehmers (z.B. mittels e-card). Dadurch erhält der GDA einen, seiner Rolle entsprechenden ELGA-Zugriff, inkl. lesenden Zugriff auf alle *Geplanten Abgaben* ([Prescription-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) und auf alle *Durchgeführten Abgaben* ([Dispense-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_05_01 - Durchgeführte Abgabe schreiben](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-schreiben)). Weiters kann der Medikationsplan des ELGA-Teilnehmers abgerufen werden, um die die gesamte Medikation beurteilen zu können, oder OTC-Abgaben dokumentiert werden.

* **Zugriff mittels *e-Med GroupIdentifier***:
Alternativ steht ohne Patientenkontakt der **Zugriff mittels *e-Med GroupIdentifier*** (z.B. über den DataMatrix-Code eines e-Rezepts) zur Verfügung ([GroupIdentifier-Search](Sub_UC_eMed_03.html#sub_uc_emed_03_03---geplante-und-durchgeführte-abgaben-mittels-e-med-groupidentifier-lesen-groupidentifier-search)). Dieser ermöglicht ausschließlich einen eingeschränkten ELGA-Zugriff auf die dem *e-Med GroupIdentifier* zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben* und wird in [Sub_UC_eMed_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_03.html) beschrieben.

<div class="hinweisbox">
ℹ️ Die fachlichen Anforderungen dieses Use Cases werden im <a href="Sub_UC_eMed_03.html">UC_eMed_03 Geplante und durchgeführte Abgaben lesen</a> beschrieben.<br> 
Es gelten die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert. 
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 2.10.2026 -->

### Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)

*Prescription-Search* dient dem Suche nach [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) eines ELGA-Teilnehmers, um vorgesehene Arzneimittelabgaben einzusehen. Als *Geplante Abgabe* gilt eine *MedicationRequest*-Ressource mit *category = "Geplante Abgabe"*.

*Geplante Abgaben* bilden einige Inhalte des e-Rezepts ab. Wurden mehrere Arzneimittel verordnet und sind demselben e-Rezept zugeordnet, sind die zugehörigen *Geplanten Abgaben* mit demselben *e-Med GroupIdentifier* versehen, den auch das e-Rezept mitführt (bildet damit die Rezept-Klammer). 


#### Suchparameter

Die Suche nach *Geplanten Abgaben* erfolgt mittels **GET** unter Angabe geeigneter Suchparameter:
* alle (ohne Einschränkung) <!-- TODO sinnvoll? akl 2.10. -->
* in einem bestimmten Zeitraum erfasste 
* mit bestimmter Medikation: PZN/Name bzw. Wirkstoff (bei Wirkstoff werden auch Magistrale Zubereitungen durchsucht) 
* mit einem bestimmten [status](ValueSet-GeplanteAbgabeStatusVS.html): [active | completed | entered-in-error | stopped | cancelled ] (z.B. alle offenen)
* mit einem bestimmten *e-Med GroupIdentifier* 
<!-- * Erstellender GDA? Todo akl 2.10. -->

Die gefundenen *Geplanten Abgaben* können als Ausgangspunkt für weitere Abfragen verwendet werden:
* zugehöriger Medikationsplaneintrag <!-- nur aktuelle Todo akl 2.10. --> / zugehörige Medikationsplanversion 
* zugehörige *Durchgeführte Abgaben* (inkl. Status, auch Leerabgaben oder Substitutionen)

Von ELGA-Teilnehmer:innen gelöschte *Geplanten Abgaben* stehen nicht mehr zur Verfügung.

##### Ablauf

1. Der GDA führt ein **GET** auf den Prescription-Search-Endpunkt mit den gewünschten Suchparametern aus (*MedicationRequest* mit *category = "Geplante Abgabe"*) 
2. Die Fachanwendung ermittelt die den Suchkriterien entsprechenden *Geplanten Abgaben*.
3. Die Fachanwendung liefert das Suchergebnis als als Bundle vom Typ *searchset* zurück.
4. Werden keine passenden Ressourcen gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
7. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.
5. Optional kann der GDA den *Medikationsplan* oder *Durchgeführte Abgaben* zur fachlichen Beurteilung abrufen.

<div class="dragon">
<p class="note-to-balloters">
Offene Frage:<br>
ad: Suchkritierien: <br>
- Geplante Abgabe zu einer Durchgeführten Abgabe: Reverse-Include erlaubt oder eigene Operation? <br>
- Gültigkeitszeitraum des Rezepts (validityPeriod)? <br>
- Erstellender GDA?<br>
</p>
</div>

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_01.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_01.svg)


### Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)

*Dispense-Search* dient dem Suche nach [Durchgeführten Abgaben](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html) eines ELGA-Teilnehmers, um bereits dokumentierte Arzneimittelabgaben einzusehen.

*Durchgeführten Abgaben* spiegeln den Status der Abgaben des e-Rezepts wider. Eine *Durchgeführte Abgabe*, die auf einer *Geplanten Abgabe* basiert, enthält den *e-Med GroupIdentifier* der zugehörigen *Geplanten Abgabe*. Dadurch können zusammengehörige *Geplante Abgaben* und *Durchgeführte Abgaben* über denselben *e-Med GroupIdentifier* identifiziert und gemeinsam abgerufen werden.

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
5. Optional kann der GDA den *Medikationsplan* oder *Geplante Abgaben* zur fachlichen Beurteilung abrufen.


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

