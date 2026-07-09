{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

### Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen

nur offene, mit gültigem GI (noch nicht eingelöst oder abgelaufen)

 
##### Variante B: Geplante Abgaben lesen mittels e-Med Groupidentifier

Erfolgt die Arzneimittelabgabe in der Apotheke auf Basis eines vorgelegten e‑Rezepts (papiergebunden oder digital), erhält der GDA ausschließlich lesenden Zugriff auf die zugehörigen *Geplanten Abgaben*. Diese werden über den im DataMatrix-Code enthaltenen gemeinsamen *e‑Med GroupIdentifier* in der e‑Medikation identifiziert und abgerufen, sofern sie den Status *active* aufweisen.

<!-- TODO: und bereits gespeicherte Durchgeführte Abgaben ? -->
Der GDA erhält in diesem Fall keinen Zugriff auf andere offene *Geplante Abgaben*, kann den *Medikationsplan* des ELGA-Teilnehmers zwecks Wechselwirkungsprüfung nicht einsehen und kann auch keine weiteren *Durchgeführten Abgaben* (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern.

[![overview](plantuml/UC_eMed_07_01_b.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_01_b.svg)

<!-- ##### Custom Operations -->



##### Variante B: Durchgeführte Abgaben lesen mittels e-Rezept

Erfolgt die Arzneimittelabgabe in der Apotheke auf Basis eines vorgelegten e-Rezepts (papiergebunden oder digital), erhält der GDA ausschließlich lesenden Zugriff auf die zugehörigen *Durchgeführten Abgaben*. 

Diese werden über den im QR‑Code enthaltenen gemeinsamen *e‑Med GroupIdentifier* in der e‑Medikation identifiziert und abgerufen, sofern sie:
- einen relevanten Status aufweisen, 
<!-- Welche Status der Durchgeführten Abgaben sind relevant? type mit completed? status kann auch cancelled sein! -->
- der *e‑Med GroupIdentifier* noch gültig ist (d.h. noch zugehörige offene *Geplante Abgaben* vorliegen). 
<!-- TODO: *Durchgeführte Abgaben* müssen mit dem *e-Med GroupIdentifier* ergänzt werden -->

[![overview](plantuml/UC_eMed_07_02_b.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_02_b.svg)

<br>
<!-- ##### Custom Operations -->