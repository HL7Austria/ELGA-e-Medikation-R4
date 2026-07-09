{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) kann *Geplante Abgaben* eines ELGA-Teilnehmers abrufen, um verordnete (rezeptierte) Arzneimittel bzw. den Status der *Geplanten Abgaben* einzusehen und eine entsprechende Arzneimittelabgabe durchzuführen. 

ELGA-Teilnehmer können *Geplante Abgaben* über das ELGA-Portal einsehen. 

Sofern ein zugehöriges e-Rezept vorliegt, spiegeln *Geplanten Abgaben* den Status der Verordnungen eines e-Rezepts wider.

Der Standard-Zugriff auf *Geplante Abgaben* erfolgt mittels Kontaktbestätigung des ELGA-Teilnehmers (z.B. über die e-card). Dadurch erhält der GDA lesenden Zugriff auf alle *Geplante Abgaben* und kann entsprechende Arzneimittelabgaben durchführen und dokumentieren (siehe [Sub_UC_eMed_09_01 - Durchgeführte Abgabe schreiben](Sub_UC_eMed_09.html#sub_uc_emed_09_01---durchgeführte-abgabe-schreiben)). Zusätzlich kann der GDA (Arzt/Apothekter) lesend auf den *Medikationsplan* des ELGA-Teilnehmers zugreifen, um zuvor evtl. Wechselwirkungen zu prüfen ([Plan-Read](interactions.html#plan-read)).
<!-- TODO: Link auf Medikationsplan lesen einfügen -->

Der Zugriff mittels *e-Med Groupidentifier* (z.B. bei Vorlage eines Papierrezepts) ermöglicht nur eingeschränkten ELGA-Zugriff und wird in [Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen](Sub_UC_eMed_07_03.html) beschrieben. 


### Sub_UC_eMed_07_01 - Geplante Abgaben lesen (Prescription-Search)

Bei der Prescription-Search stellt die Fachanwendung alle MedicationRequests des ELGA-Teilnehmers mit der Kategorie *Geplante Abgabe* bereit.
Status und Zeitraum können bei der Abfrage eingeschränkt werden.
<!-- TODO: default: Status offen / relevanter Zeitraum? Gültigkeits- oder Erstellungszeitraum? -->


##### Ablauf

1. Der GDA führt ein **GET** auf **MedicationRequest** mit der Kategorie **Geplante Abgabe** aus. Optional können weitere Suchparameter, z.B. Status oder Zeitraum, angegeben werden.
2. Die Fachanwendung ermittelt alle den Suchkriterien entsprechenden MedicationRequests.
3. Die Fachanwendung liefert das Suchergebnis als **Bundle (type = searchset)** mit sämtlichen den Suchkriterien entsprechenden MedicationRequest zurück.
4. Werden keine passenden MedicationRequests gefunden, wird ein **leeres Searchset-Bundle** zurückgegeben.
5. Kann die Anfrage nicht verarbeitet werden, antwortet die Fachanwendung mit einer geeigneten **HTTP-4xx**-Antwort und einem **OperationOutcome**.
6. Optional kann der GDA zusätzlich den Medikationsplan mittels **$plan-read** abrufen, um die *Geplanten Abgaben* im Kontext der aktuellen Gesamtmedikation zu beurteilen.


##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_07_01.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_01.svg)


###### Suchparameter

In Arbeit.


