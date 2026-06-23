{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

### Sub_UC_eMed_07_01 - Geplante Abgaben lesen

Ein GDA (Arzt oder Apotheker) kann *Geplante Abgaben* von ELGA-Teilnehmer:innen abrufen, um verordnete Arzneimittel einzusehen.

#### Sub_UC_eMed_07_01_a Zugriff mittels e-card

Erfolgt die Abgabe in der Apotheke nach Identifikation des ELGA-Teilnehmers mittels e-card, erhält der GDA (Apotheker) lesenden Zugriff auf alle relevanten *Geplante Abgaben* und kann entsprechende Abgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_09_01 - Durchgeführte Abgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01---durchgeführte-abgabe-erfassen)). 
<!-- TODO: definition "relevant": default: Status offen / relevanter Zeitraum? -->

Zusätzlich kann der Apotheker evtl. Wechselwirkungen mit Hilfe des Medikationsplan des ELGA-Teilnehmers prüfen und weitere durchgeführten Abgaben (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern.


#### Sub_UC_eMed_07_01_b Zugriff mittels e-Rezept

<br>
{% include_relative plantuml/UC_eMed_07_01_a.svg %}{: style="max-width:80%; height:auto;" }
<br>


