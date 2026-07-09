{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann *Geplante Abgaben* eines ELGA-Teilnehmers abrufen, um verordnete (rezeptierte) Arzneimittel bzw. den Status der *Geplanten Abgaben* einzusehen und eine entsprechende Arzneimittelabgabe durchzuführen. 

ELGA-Teilnehmer können *Geplante Abgaben* über das ELGA-Portal einsehen. 

Sofern ein zugehöriges e-Rezept vorliegt, spielgeln *Geplanten Abgaben* den Status der Verordnungen eines e-Rezepts wider.

Der Standard-Zugriff auf *Geplante Abgaben* erfolgt mittels Kontaktbestätigung des ELGA-Teilnehmers (z.B. über die e-card). Dadurch erhält der GDA lesenden Zugriff auf alle *Geplante Abgaben* (GET MedicationDispense) und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_09_01 - Durchgeführte Abgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01---durchgeführte-abgabe-erfassen)). Zusätzlich kann der GDA (Arzt/Apothekter) lesend auf den *Medikationsplan* des ELGA-Teilnehmers zugreifen, um zuvor evtl. Wechselwirkungen zu prüfen ([Plan-Read](interactions.html#plan-read)).
<!-- TODO: Link auf Medikationsplan lesen einfügen -->

Der Zugriff mittels *e-Med Groupidentifier* (z.B. bei Vorlage eines Papierrezepts) ermöglicht nur eingeschränkten ELGA-Zugriff und wird in [Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_07_03.html) beschrieben. 


### Sub_UC_eMed_07_01 - Geplante Abgaben lesen (Prescription-Search)

Bei der Prescription-Search stellt die Fachanwendung alle MedicationRequests des ELGA-Teilnehmers mit der Kategorie *Geplante Abgabe* bereit.
Status und Zeitraum können bei der Abfrage eingeschränkt werden.
<!-- TODO: definition "relevant": default: Status offen / relevanter Zeitraum? Gültigkeits- oder Erstellungszeitraum? -->


##### Ablauf

[![overview](plantuml/UC_eMed_07_01.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_01.svg)


<br>





