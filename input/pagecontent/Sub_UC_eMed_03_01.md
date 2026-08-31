{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_03) -->

### Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann [Geplante Abgaben](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) eines ELGA-Teilnehmers abrufen, um verordnete (rezeptierte) Arzneimittel einzusehen.

ELGA-Teilnehmer können *Geplante Abgaben* über das Zugangsportal einsehen. 

*Geplante Abgaben* bilden die Inhalte des e-Rezepts ab. Wurden mehrere Arzneimittel verordnet und sind demselben e-Rezept zugeordnet, sind die zugehörigen *Geplanten Abgaben* mit demselben *e-Med GroupIdentifier* versehen, den auch das e-Rezept mitführt (bildet damit die Rezept-Klammer). 

Der **Standardzugriff** (*Prescription-Search*) erfolgt nach **Kontaktbestätigung** des ELGA-Teilnehmers (z.B. mittels e-card). Der GDA erhält dadurch lesenden Zugriff auf die e-Medikation inkl. aller *Geplanten Abgaben* und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_05_01 - Durchgeführte Abgabe schreiben](Sub_UC_eMed_05.html#Sub_UC_eMed_05_01---durchgeführte-abgabe-schreiben)). Zusätzlich kann der GDA auf *Durchgeführte Abgaben* und den *Medikationsplan* zugreifen, um die *Geplanten Abgaben* im Kontext der gesamten Medikation zu beurteilen. 
<!-- TODO: Link auf Medikationsplan lesen einfügen -->

Als **alternative Zugriffsart** zur Kontaktbestätigung steht der **Zugriff mittels *e-Med GroupIdentifier*** (z.B. über den DataMatrix-Code eines e-Rezepts) zur Verfügung (*Groupidentifier-Search*). Dieser ermöglicht ausschließlich einen eingeschränkten ELGA-Zugriff auf die dem e-Med GroupIdentifier zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben* und wird in [Sub_UC_eMed_03_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_03_03.html) beschrieben.

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

