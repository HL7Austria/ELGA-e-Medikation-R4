{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann *Durchgeführte Abgaben* eines ELGA-Teilnehmers abrufen, um bereits abgegebene Arzneimittel bzw. den Status der *Durchgeführten Abgaben* einzusehen. 

ELGA-Teilnehmer können *Durchgeführte Abgaben* über das ELGA-Portal einsehen. 

Sofern ein zugehöriges e-Rezept vorliegt, spiegeln *Durchgeführten Abgaben* den Status der Abgaben in der e-Rezept Anwendung wider.

Der Standard-Zugriff auf *Durchgeführte Abgaben* erfolgt mittels Kontaktbestätigung des ELGA-Teilnehmers (z.B. über die e-card). Dadurch erhält der GDA lesenden Zugriff auf alle *Durchgeführten Abgaben* und erhält Einblick auf bereits durchgeführte Arzneimittelabgaben. Zusätzlich kann der GDA (Arzt/Apothekter) lesend auf *Geplante Abgaben* und den *Medikationsplan* des ELGA-Teilnehmers zugreifen.
<!-- TODO: Link auf Medikationsplan lesen + Geplante Abgaben lesen einfügen -->

Der Zugriff mittels *e-Med Groupidentifier* (z.B. bei Vorlage eines Papierrezepts) ermöglicht nur eingeschränkten ELGA-Zugriff und wird in [Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_07_03.html) beschrieben. 


### Sub_UC_eMed_07_02 - Durchgeführte Abgaben lesen (Dispense-Search)

Bei der Dispense-Search stellt die Fachanwendung alle MedicationDispenses des ELGA-Teilnehmers bereit.
Status und Zeitraum können bei der Abfrage eingeschränkt werden.

##### Ablauf

In Arbeit.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_07_02_a.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_02_a.svg)


###### Suchparameter

In Arbeit.




