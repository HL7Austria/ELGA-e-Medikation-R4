{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_03) -->

### Sub_UC_eMed_03_03 - Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen (Groupidentifier-Search)

Erfolgt die Arzneimittelabgabe **ohne Kontaktbestätigung** des ELGA-Teilnehmers, sondern auf Basis eines *e-Med GroupIdentifier* (z.B. über den DataMatrix-Code eines e-Rezepts), erhält ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) einen eingeschränkten ELGA-Zugriff. 

Dieser umfasst ausschließlich den lesenden Zugriff auf die dem *e-Med GroupIdentifier* zugeordneten *Geplanten Abgaben* und *Durchgeführten Abgaben*. Der GDA kann anschließend *Durchgeführte Abgaben* ausschließlich für diesen *e-Med GroupIdentifier* dokumentieren (siehe *Sub_UC_eMed_05_01 - Durchgeführte Abgaben mittels e-Med GroupIdentifier schreiben*).

Ein lesender Zugriff auf weitere *Geplante Abgaben* oder *Durchgeführte Abgaben* sowie auf den Medikationsplan des ELGA-Teilnehmers ist nicht möglich. Ebenso können keine weiteren *Durchgeführten Abgaben* (z.B. OTC- oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers dokumentiert werden.

<!-- Todo: Wie Zugriff auf alle selbst erstellten Ressourcen möglich? -->

##### Ablauf

1. Der GDA führt die Custom Operation **POST** [$groupidentifier-search](OperationDefinition-AtElgaEmed.GroupIdentifier.Search.html) aus und übermittelt einen *e-Med GroupIdentifier*.
2. Die Fachanwendung führt eine **Prüfung** des übermittelten *e-Med GroupIdentifier* durch.
3. Ist der *e-Med GroupIdentifier* gültig, ermittelt die Fachanwendung alle *MedicationRequest*-Ressourcen der Kategorie *Geplante Abgabe*, die dem übermittelten *e-Med GroupIdentifier* entsprechen.
   <!-- * *status = active*: nur offene  ? -->
<!-- 4. Ergibt die Suche mindestens eine offene *Geplante Abgabe*, ermittelt die Fachanwendung zusätzlich alle zugehörigen *MedicationDispense*-Ressourcen mit:
   * dem übermittelten e-Med GroupIdentifier
   * status = completed oder cancelled -->
4. Die Fachanwendung ermittelt zusätzlich alle *MedicationDispense*-Ressourcen, die dem übermittelten *e-Med GroupIdentifier* entsprechen.
5. Die Fachanwendung liefert die ermittelten *MedicationRequest*- und *MedicationDispense*-Ressourcen als **Bundle** vom Typ *searchset* zurück.
6. Ergibt die Suche keine passenden *Geplanten Abgaben* oder *Durchgeführten Abgaben*, liefert die Fachanwendung ein **leeres Bundle** vom Typ *searchset* zurück.
7. Ist der *e-Med GroupIdentifier* ungültig, lehnt die Fachanwendung die Operation ab und liefert einen entsprechenden *OperationOutcome* zurück.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_03_03.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_03_03.svg)

<!--TODO: je nach Entscheidung, ob wirklich nur bei gefundenen geplanten auch die durchgeführten gesucht werden muss evtl. das Diagramm angepasst werden. -->


##### Custom Operations

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte: <br>$groupidentifier-search: in Arbeit.
</p>
</div>
