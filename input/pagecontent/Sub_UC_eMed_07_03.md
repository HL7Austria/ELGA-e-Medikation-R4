{% include styleheader.md %}

<!-- Technische Use Cases für Geplante und Durchgeführte Abgaben lesen (UC_eMed_07) -->

### Sub_UC_eMed_07_03 - Geplante und Durchgeführte Abgaben mit e-Med GroupIdentifier lesen (Groupidentifier-Search)


<!-- nur offene, mit gültigem GI (noch nicht eingelöst oder abgelaufen) -->

Erfolgt die Arzneimittelabgabe basierend auf einem *e-Med GroupIdentifier* (z.B. mit DataMatrix-Code eines e-Rezepts), erhält ein [berechtigter GDA](actors.html#rollen-und-berechtigungen) ausschließlich lesenden Zugriff auf die zugehörigen *Geplanten* und *Durchgeführten Abgaben*. Diese werden über den im DataMatrix-Code enthaltenen gemeinsamen *e‑Med GroupIdentifier* in der e‑Medikation Fachanwendung identifiziert und abgerufen.

Der Zugriff mit *e-Med GroupIdentifier* ermöglicht ausschließlich einen eingeschränkten ELGA-Zugriff. Der GDA erhält in diesem Fall keinen Zugriff auf weitere offene *Geplante* oder *Durchgeführte Abgaben*, kann den *Medikationsplan* des ELGA-Teilnehmers nicht einsehen und kann auch keine zusätzlichen *Durchgeführten Abgaben* (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers dokumentieren.

<!-- Todo: Wie Zugriff auf alle selbst erstellten Ressourcen möglich? -->

##### Ablauf

1. Der GDA führt die Custom Operation **POST** [$groupidentifier-search](OperationDefinition-AtElgaEmed.GroupIdentifier.Search.html) aus und übermittelt einen *e-Med GroupIdentifier*.
2. Die Fachanwendung führt eine **syntaktische Prüfung** des übermittelten *e-Med GroupIdentifier* durch.
3. Ist der *e-Med GroupIdentifier* syntaktisch gültig, ermittelt die Fachanwendung alle *MedicationRequest*-Ressourcen mit:
   * *category = Geplante Abgabe*
   * dem übermittelten *e-Med GroupIdentifier*
   * *status = active*
4. Ergibt die Suche mindestens eine offene *Geplante Abgabe*, ermittelt die Fachanwendung zusätzlich alle zugehörigen *MedicationDispense*-Ressourcen mit:
   * dem übermittelten *e-Med GroupIdentifier*
   * *status = completed | cancelled*
5. Die Fachanwendung liefert ein **Bundle** vom Typ *searchset* mit den ermittelten *MedicationRequest*- und *MedicationDispense*-Ressourcen zurück.
6. Ergibt die Suche **keine offene Geplante Abgabe**, liefert die Fachanwendung ein **leeres Bundle** vom Typ *searchset* zurück.
7. Ist der *e-Med GroupIdentifier* syntaktisch ungültig, lehnt die Fachanwendung die Operation ab und liefert ein entsprechendes *OperationOutcome* zurück.

##### Sequenzdiagramm

[![overview](plantuml/UC_eMed_07_03.svg){: .mx-auto style="width:50%;"}](plantuml/UC_eMed_07_03.svg)

##### Custom Operations

 $groupidentifier-search: in Arbeit.


