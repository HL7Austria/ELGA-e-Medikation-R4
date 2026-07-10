{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

### Sub_UC_eMed_07_02 - Durchgeführte Abgaben lesen (Dispense-Search)

Ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) kann *Durchgeführte Abgaben* eines ELGA-Teilnehmers abrufen, um bereits abgegebene Arzneimittel bzw. den Status der *Durchgeführten Abgaben* einzusehen. 

ELGA-Teilnehmer können *Durchgeführte Abgaben* über das ELGA-Portal einsehen. 

Sofern ein zugehöriges e-Rezept vorliegt, spiegeln die *Durchgeführten Abgaben* den Status der Abgaben des e-Rezepts Anwendung wider.

Der Standardzugriff auf *Durchgeführte Abgaben* erfolgt mittels Kontaktbestätigung des ELGA-Teilnehmers (z.B. über die e-card). Dadurch erhält der GDA lesenden Zugriff auf alle *Durchgeführten Abgaben*. 
Zusätzlich kann der GDA lesend auf *Geplante Abgaben* und den *Medikationsplan* zugreifen, um die *Durchgeführten Abgaben* im Kontext der gesamten Medikation zu beurteilen.
<!-- TODO: Link auf Medikationsplan lesen + Geplante Abgaben lesen einfügen -->

Der Zugriff mittels *e-Med GroupIdentifier* (z.B. mittels DataMatrix-Code eines e-Rezepts)  ermöglicht nur eingeschränkten ELGA-Zugriff und wird in [Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_07_03.html) beschrieben. 

Bei der **Dispense-Search** stellt die Fachanwendung alle *MedicationDispense*-Ressourcen des ELGA-Teilnehmers bereit, die den angegebenen Suchkriterien entsprechen. Die Suche kann insbesondere nach Status und Zeitraum eingeschränkt werden.

##### Ablauf

1. Der GDA führt ein **GET** auf **MedicationDispense** aus. Die Suche kann optional anhand von Suchparametern eingeschränkt werden (siehe Suchparameter).
2. Die Fachanwendung ermittelt alle den Suchkriterien entsprechenden *Durchgeführten Abgaben* des ELGA-Teilnehmers.
3. Die Fachanwendung liefert das Suchergebnis als **Bundle (type = searchset)** mit sämtlichen den Suchkriterien entsprechenden *MedicationDispense*-Ressourcen.
4. Werden keine passenden Ressourcen gefunden, wird ein **leeres Searchset-Bundle** zurückgegeben.
4. Kann die Anfrage nicht verarbeitet werden, antwortet die Fachanwendung mit einer geeigneten **HTTP-4xx**-Antwort und einem **OperationOutcome**.
5. Optional kann der GDA zusätzlich den *Medikationsplan* oder *Geplante Abgaben* abrufen.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_07_02.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_02.svg)


###### Suchparameter

Mögliche Suchparamter: (in Arbeit)
- identifier (e-Med GroupIdentifier)
- [status](ValueSet-DurchgefuehrteAbgabeStatusVS.html) [completed | cancelled | entered-in-error]
- [type](ValueSet-DurchgefuehrteAbgabeTypVS.html) (Abgabeart)
- recorded (Datum und Uhrzeit der Erfassung)
<!-- Todo: entered-in-error nicht, weil nur eigene verworfen werden können? -->




