{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

### Sub_UC_eMed_07_01 - Geplante Abgaben lesen

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann *Geplante Abgaben* eines ELGA-Teilnehmers abrufen, um verordnete (rezeptierte) Arzneimittel bzw. den Status der *Geplanten Abgaben* einzusehen und eine entsprechende Arzneimittelabgabe durchzuführen. 

Sofern ein zugehöriges e-Rezept vorliegt, spielgeln *Geplanten Abgaben* den Status der Verordnungen eines e-Rezepts wider.

Der Zugriff auf *Geplante Abgaben* erfolgt unterschiedlich – je nachdem, ob eine Kontaktbestätigung des ELGA-Teilnehmers vorliegt (z.B. über die e-card) oder ob der Zugriff mittels *e-Med Groupidentifier* z.B. mittels QR-Code des e-Rezepts erfolgt.
ELGA-Teilnehmer können *Geplante Abgaben* über das ELGA-Portal einsehen. 

#### Prescription-Search

Im folgenden wird exemplarisch der lesende Zugriff auf *Geplante Abgaben* mittels e-card bzw. e-Rezept in der Apotheke dargestellt.

##### Variante A: Zugriff mittels Kontaktbestätigung

Erfolgt die Arzneimittelabgabe nach Identifikation des ELGA-Teilnehmers mittels e-card, erhält der GDA lesenden Zugriff auf alle *Geplante Abgaben* (GET MedicationDispense) und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_09_01 - Durchgeführte Abgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01---durchgeführte-abgabe-erfassen)). 
<!-- TODO: definition "relevant": default: Status offen / relevanter Zeitraum? -->

Zusätzlich kann der GDA (Arzt/Apothekter) lesend auf den *Medikationsplan* des ELGA-Teilnehmers zugreifen, um zuvor evtl. Wechselwirkungen zu prüfen ([Plan-Read](interactions.html#plan-read)).
<!-- TODO: Link auf Medikationsplan lesen einfügen -->
<!-- Der Zugriff auf e-Rezept kann parallel erfolgen. -->

[![overview](plantuml/UC_eMed_07_01_a.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_01_a.svg)


<br>

##### Variante B: Zugriff mittels e-Med Groupidentifier

Erfolgt die Arzneimittelabgabe in der Apotheke auf Basis eines vorgelegten e‑Rezepts (papiergebunden oder digital), erhält der GDA ausschließlich lesenden Zugriff auf die zugehörigen *Geplanten Abgaben*. Diese werden über den im QR‑Code enthaltenen gemeinsamen *e‑Med GroupIdentifier* in der e‑Medikation identifiziert und abgerufen, sofern sie den Status *active* aufweisen.

<!-- TODO: und bereits gespeicherte Durchgeführte Abgaben ? -->
Der GDA erhält in diesem Fall keinen Zugriff auf andere offene *Geplante Abgaben*, kann den *Medikationsplan* des ELGA-Teilnehmers zwecks Wechselwirkungsprüfung nicht einsehen und kann auch keine weiteren *Durchgeführten Abgaben* (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern.

[![overview](plantuml/UC_eMed_07_01_b.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_01_b.svg)

<!-- ##### Custom Operations -->



