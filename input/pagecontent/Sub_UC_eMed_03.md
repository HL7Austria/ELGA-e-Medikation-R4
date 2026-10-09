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
Der Standardzugriff erfolgt nach nach Kontaktbestätigung des ELGA-Teilnehmers (z.B. mittels e-card). Dadurch erhält der GDA einen, seiner Rolle entsprechenden ELGA-Zugriff, inkl. lesenden Zugriff auf alle *Geplanten Abgaben* (siehe [Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) und auf alle *Durchgeführten Abgaben* (siehe [Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren ([Dispense-Write](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-schreiben)). Weiters kann der Medikationsplan des ELGA-Teilnehmers abgerufen werden ([Plan-Read](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)), um die die gesamte Medikation beurteilen zu können, oder [OTC-Abgaben](Sub_UC_eMed_05.html#sub_uc_emed_05_01_05---durchgeführte-abgabe-ohne-bezug-zu-einer-geplanten-abgabe-erfassen) dokumentiert werden.

* **Zugriff mittels *e-Med GroupIdentifier***:
Alternativ steht **ohne Kontaktbestätigung** des ELGA-Teilnehmers der Zugriff mittels *e-Med GroupIdentifier* (z.B. über den DataMatrix-Code eines e-Rezepts) zur Verfügung. Dieser ermöglicht ausschließlich einen **eingeschränkten ELGA-Zugriff** auf die dem *e-Med GroupIdentifier* zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben* und wird in [Sub_UC_eMed_03_03 - Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen (GroupIdentifier-Search)](Sub_UC_eMed_03.html#sub_uc_emed_03_03---geplante-und-durchgeführte-abgaben-mittels-e-med-groupidentifier-lesen-groupidentifier-search) beschrieben.

<div class="hinweisbox">
ℹ️ Die fachlichen Anforderungen dieses Use Cases werden im <a href="Sub_UC_eMed_03.html">UC_eMed_03 Geplante und durchgeführte Abgaben lesen</a> beschrieben.<br> 
Es gelten die dort festgelegten Vorbedingungen. Alle Zugriffe werden protokolliert. 
</div>
<!--Todo: Link korrigieren, Link zu allgemeinen BES-UCs ergänzen akl 2.10.2026 -->

### Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)

*Prescription-Search* dient dem Suche nach [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) eines ELGA-Teilnehmers, um vorgesehene Arzneimittelabgaben einzusehen. Als *Geplante Abgabe* gilt eine *MedicationRequest*-Ressource mit *category = "Geplante Abgabe"*.

*Geplante Abgaben* dokumentieren medizinische Inhalte des e-Rezepts. Wurden mehrere Arzneimittel gleichzeitig verordnet und sind demselben e-Rezept zugeordnet, sind die zugehörigen *Geplanten Abgaben* mit demselben *e-Med GroupIdentifier* zu versehen, den auch das e-Rezept mitführt (bildet damit die Rezept-Klammer). 


#### Suchparameter

Die Suche nach [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) erfolgt mittels **GET**-Request unter Angabe geeigneter Suchparameter:
* alle (ohne Einschränkung) <!-- TODO sinnvoll? akl 2.10. -->
* in einem bestimmten Zeitraum erfasste 
* mit bestimmter Medikation: PZN/Name bzw. Wirkstoff (inkl. Magistraler Zubereitungen) 
* mit einem bestimmten [status](ValueSet-GeplanteAbgabeStatusVS.html)  <!-- Todo: entered-in-error nicht, weil nur eigene storniert werden können? -->
* mit einem bestimmten *e-Med GroupIdentifier* 
<!-- * Erstellender GDA? Todo akl 2.10. -->

Die gefundenen *Geplanten Abgaben* können als Ausgangspunkt für weitere Abfragen verwendet werden:
* zugehöriger Medikationsplaneintrag und Medikationsplanversion <!-- wie kommt man auf die Planversion? keine Referenz im Planeintrag auf die List(version) Todo akl 7.10. -->
   * da in einer *Geplanten Abgabe* die Referenz auf den zugehöigen Planeintrag (*basedOn*) nicht versioniert ist, zeigt die *Geplante Abgabe* immer auf den aktuellen Planeintrag. Dieser kann zwischenzeitlich von den Inhalten der *Geplanten Abgabe* abweichen.
* zugehörige *Durchgeführte Abgaben* (gleicher *e-Med GroupIdentifier* der *Geplanten Abgabe*) 

Von ELGA-Teilnehmern gelöschte *Geplanten Abgaben* stehen nicht mehr zur Verfügung.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>
Suchparameter: Umsetzung in Arbeit.
</p>
</div>

##### Ablauf

1. Der GDA führt einen **GET**-Request auf den Prescription-Search-Endpunkt mit *MedicationRequest.category = "Geplante Abgabe"* und Suchparametern aus 
2. Die Fachanwendung ermittelt die den Suchkriterien entsprechenden *Geplanten Abgaben*.
3. Die Fachanwendung liefert das Suchergebnis als Bundle vom Typ *searchset* zurück.
4. Werden keine passenden Ressourcen gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
7. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.
5. Optional kann der GDA den *Medikationsplan* (siehe [Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)) und *Durchgeführte Abgaben* (siehe [Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)](Sub_UC_eMed_03.html#sub_uc_emed_03_02---durchgeführte-abgaben-lesen-dispense-search)) zur fachlichen Beurteilung abrufen.

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

#### Suchparameter 

Die Suche nach [Durchgeführten Abgaben](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html) erfolgt mittels **GET**-Request unter Angabe geeigneter Suchparameter:
* alle (ohne Einschränkung) <!-- TODO sinnvoll? akl 2.10. -->
* in einem bestimmten Zeitraum erfasste 
* mit bestimmter Medikation: PZN/Name bzw. Wirkstoff (inkl. Magistraler Zubereitungen) 
* mit einem bestimmten [status](ValueSet-DurchgefuehrteAbgabeStatusVS.html) <!-- Todo: entered-in-error nicht, weil nur eigene storniert werden können? -->
<!-- - mit einem bestimmten [type](ValueSet-DurchgefuehrteAbgabeTypVS.html) (Abgabeart) TODO akl 7.10. steht dzt nicht als Suchkriterium in UC3 -->
* mit einem bestimmten *e-Med GroupIdentifier* 
<!-- * Erstellender GDA? Todo akl 2.10. -->

Die gefundenen *Durchgeführten Abgaben* können als Ausgangspunkt für weitere Abfragen verwendet werden:
* zugehörige *Geplante Abgabe* (gleicher *e-Med GroupIdentifier*) 

Von ELGA-Teilnehmern gelöschte *Durchgeführten Abgaben* stehen nicht mehr zur Verfügung.


##### Ablauf

1. Der GDA führt einen **GET**-Request auf den MedicationDispense-Search-Endpunkt mit Suchparametern aus.
2. Die Fachanwendung ermittelt alle den Suchkriterien entsprechenden *Durchgeführten Abgaben*.
3. Die Fachanwendung liefert das Suchergebnis als Bundle vom Typ *searchset* zurück.
4. Werden keine passenden Ressourcen gefunden, enthält das zurückgelieferte Searchset Bundle keine Einträge.
5. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.
6. Optional kann der GDA den *Medikationsplan* (siehe [Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)](Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read)) oder *Geplante Abgaben* (siehe [Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)](Sub_UC_eMed_03.html#sub_uc_emed_03_01---geplante-abgaben-lesen-prescription-search)) zur fachlichen Beurteilung abrufen.


<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>
Suchparameter: Umsetzung in Arbeit.
</p>
</div>

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_02.svg)

<!-- im Diagramm die Optionale Box über das GET schieben: -> würde optionale aufrufe hinten anreihen damit der fokus hier auf dispense-search liegt und lesefluss einfacher ist. dem client können wir hier sowieso keine reihenfolge vorgeben. -->


### Sub_UC_eMed_03_03 - Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen (GroupIdentifier-Search)

Erfolgt die Arzneimittelabgabe **ohne Kontaktbestätigung** des ELGA-Teilnehmers, sondern auf Basis eines *e-Med GroupIdentifiers* (z.B. über den DataMatrix-Code eines e-Rezepts), erhält ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) einen eingeschränkten ELGA-Zugriff. 

Dieser umfasst ausschließlich den lesenden Zugriff auf die **dem *e-Med GroupIdentifier*** **zugeordneten** *Geplanten Abgaben* und *Durchgeführten Abgaben*. Der GDA kann anschließend *Durchgeführte Abgaben* ausschließlich für diesen *e-Med GroupIdentifier* dokumentieren (siehe [Zugriffsvariante B: Durchgeführte Abgabe mit e-Med GroupIdentifier schreiben](Sub_UC_eMed_05.html#zugriffsvariante-b-durchgeführte-abgabe-mit-e-med-groupidentifier-schreiben)).

Ein lesender Zugriff auf weitere *Geplante Abgaben* oder *Durchgeführte Abgaben* sowie auf den Medikationsplan des ELGA-Teilnehmers ist nicht möglich. Ebenso können keine weiteren *Durchgeführten Abgaben* (z.B. OTC- oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers dokumentiert werden.

<!-- Todo: Wie Zugriff auf alle selbst erstellten Ressourcen möglich? -->

##### Ablauf

1. Der GDA führt die Custom Operation **POST** [$groupidentifier-search](OperationDefinition-AtElgaEmed.GroupIdentifier.Search.html) aus und übermittelt einen *e-Med GroupIdentifier*.
2. Die Fachanwendung prüft den *e-Med GroupIdentifier*.
3. Ist der *e-Med GroupIdentifier* gültig, ermittelt die Fachanwendung alle *MedicationRequest*-Ressourcen der Kategorie *Geplante Abgabe* mit dem übermittelten *e-Med GroupIdentifier*.
   <!-- 4 Ergibt die Suche mindestens eine offene Geplante Abgabe, ermittelt die Fachanwendung zusätzlich alle zugehörigen MedicationDispense*-Ressourcen mit: dem übermittelten e-Med GroupIdentifier und status = completed oder cancelled -->
4. Die Fachanwendung ermittelt alle *MedicationDispense*-Ressourcen mit dem übermittelten *e-Med GroupIdentifier*.
5. Die Fachanwendung liefert die ermittelten *MedicationRequest*- und *MedicationDispense*-Ressourcen als Bundle vom Typ *searchset* zurück.
6. Im Fehlerfall wird ein entsprechender *OperationOutcome* zurückgegeben.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_03.svg){: .mx-auto style="width:60%;"}](plantuml/UC_eMed_03_03.svg)


##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$groupidentifier-search: in Arbeit.
</p>
</div>

