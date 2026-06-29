{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->


### Sub_UC_eMed_07_02 - Durchgeführte Abgaben lesen

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann *Durchgeführte Abgaben* eines ELGA-Teilnehmers abrufen, um bereits abgegebene Arzneimittel bzw. den Status der *Durchgeführten Abgaben* einzusehen. Sofern ein zugehöriges e-Rezept vorliegt, spielgeln *Durchgeführten Abgaben* den Status der Abgaben in der e-Rezept Anwendung wider.

Der Zugriff auf *Durchgeführte Abgaben* erfolgt abhängig davon, ob eine Kontaktbestätigung des ELGA-Teilnehmers (z.B. mittels e-card) vorliegt oder ob der Zugriff mittels QR-Code des e-Rezepts erfolgt.
ELGA-Teilnehmer können *Durchgeführte Abgaben* über das ELGA-Portal abrufen. 

<!-- TODO: Welcher Zeitraum / Status relevant für Abfrage -->

#### Dispense-Search

Im Folgenden wird exemplarisch der lesende Zugriff auf *Durchgeführte Abgaben* mittels e-card bzw. e-Rezept in der Apotheke dargestellt.

##### Variante A: Zugriff mit Kontaktbestätigung am Beispiel der e-card

Erfolgt der Zugriff in der Apotheke nach Identifikation des ELGA-Teilnehmers mittels e-card, erhält der GDA Zugriff auf alle *Durchgeführten Abgaben*.
<!-- TODO: definition "relevant": default: Status offen / relevanter Zeitraum? -->

[![overview](plantuml/UC_eMed_07_02_a.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_02_a.svg)

<br>

##### Variante B: Zugriff mittels e-Rezept

Erfolgt die Arzneimittelabgabe in der Apotheke auf Basis eines vorgelegten e-Rezepts (papiergebunden oder digital), erhält der GDA ausschließlich lesenden Zugriff auf die zugehörigen *Durchgeführten Abgaben*. 

Diese werden über den im QR‑Code enthaltenen gemeinsamen *e‑Med GroupIdentifier* in der e‑Medikation identifiziert und abgerufen, sofern sie:
- einen relevanten Status aufweisen, 
<!-- Welche Status der Durchgeführten Abgaben sind relevant? type mit completed? status kann auch cancelled sein! -->
- der *e‑Med GroupIdentifier* noch gültig ist (d.h. noch zugehörige offene *Geplante Abgaben* vorliegen). 
<!-- TODO: *Durchgeführte Abgaben* müssen mit dem *e-Med GroupIdentifier* ergänzt werden -->

[![overview](plantuml/UC_eMed_07_02_b.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_02_b.svg)

<br>
<!-- ##### Custom Operations -->



