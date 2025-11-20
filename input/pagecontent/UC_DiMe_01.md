{% include styleheader.md %}

## Anwendungsfall 1: Medikationsplan lesen

### Akteure

* ELGA-Teilnehmer bzw. Vertretung
* Obmudsstelle
* Behandelnde GDA mit Behandlungsbezug:
    * Niedergelassener GDA
    * Krankenanstalt
    * Apotheke
    * Pflegeeinrichtung

### Beschreibung

Patienten und behandlende GDA können den Medikationsplan einsehen, um sich einen möglichst vollständigen Überblick zu allen verordneten Medikamenten und der zugehörigen Einnahmeninformation zu verschaffen. 
Der Medikationsplan dient GDA der Planung von Arzneimittelanwendungen bzw. der Überprüfung, ob etwaige Anpassungen bestehender erforderlich sind. GDA können aus den Einträgen des Medikationsplans geplante Abgaben (Rezepte) generieren.
Bevor in der Apotheke eine Abgabe erfolgt (basierend auf einer geplanten Abgaben, siehe UCx), kann eine Medikationsanamnese durchgeführt werden bzw. der Medikationsstatus oder die Medikationshistorie erhoben werden.


**Der Medikationsplan enthält:**
- Gesamtansicht aller verordneten, aktuell einzunehmenen Medikamente des Patienten samt Einnahmeinformationen (Medikationseinträge mit Status aktiv und aktuellem Datum)

- Je Medikationsplaneintrag werden folgende Information dargestellt:
    - Verantwortlicher GDA
    - Einnahmeinformation
    - Zugehörige geplante Abgaben
    - Zugehörige durchgeführte Abgaben (inkl. Abgaben von Substitutionen durch andere Arzneimittel(/“aut idem“) und „Leerabgaben“) Leerabgaben sind notwendig, um im Abgabeprozess im Zusammenspiel mit dem Einlösen eines Rezepts abzubilden, dass diese geplante Abgabe auch in Zukunft nicht mehr bedient werden wird.

- Einsicht in die „Zusätzlich erfolgte Abgaben“-Liste (Abgaben ohne zugehörigen Medikationsplaneintrag). Diese wird erst angezeigt, nachdem der erste Medikationsplan gespeichert wurde und soll die Vollständigkeit der Information zur Medikation gewährleisten. Sie enthält:
    - alle Abgaben, ohne zugehörigen Medikationsplaneintrag, die seit der letzten Version des Medikationsplans neu hinzugekommen sind bzw.
    - mit der letzten Version des Medikationsplans in der Liste beibehalten worden sind.

- Einsicht in die Vorversionen aller Medikationspläne (durch neue ersetzte Medikationspläne oder Medikationspläne mit Status ungültig)
    - Die Vorversionen enthalten keine „Zusätzlich erfolgte Abgaben“-Liste (keine Abgaben ohne zugehörigen Medikationsplaneintrag)
    - offen: Vorversionen können einen Korrekturvermerk (z.B. Änderung der Signatur oder Dosisänderung) enthalten

###	Abläufe
####	Standardablauf
Quelle https://gemspec.gematik.de/ig/fhir/epa-medication/1.2.0-ballot.1/dgmp-use-cases.html

1. Der Anwender wählt die Option Medikationsplan aus
2. Primärsystem bzw. Portal ruft den Medikationsplan von der Zentralen Anwendung e-Medikation ab und bereitet ihn für die Anzeige auf:
- filtert Einträge, die inzwischen zeitlich abgelaufen sind heraus
- ergänzt geplante Abgaben (mit Bezug zu Medikationsplaneintrag)
- ergänzt Abgaben (mit Bezug zu Medikationsplaneintrag)
3. Der Anwender kann die Ansicht anpassen durch:
- Anzeigen der Historie geplanter und durchgeführter Abgaben zu einem eMP-Eintrag (z.B. als aufklappbare Liste)
- Anzeigen von Änderungen an einem eMP-Eintrag (z.B. als Overlay oder Detailansicht) inkl.
- Art der Änderung
- Urheber der Änderung
- Zeitpunkt der Änderung
- Anzeigen eines Medikationsplans zu einem bestimmten Zeitpunkt in der Vergangenheit (Historie)
- Anzeige von stornierten Medikationsplänen: laut aktueller Umsetzung von stornierten Abgaben
- Optional können weitere Funktionen durch das Primärsystem bzw. Portal bereitgestellt werden, wie z.B.
Filter- und Suchfunktionen
- Gruppierung von Arzneimitteln im eMP  ?
- Beim Lesen kann diese Reihenfolge berücksichtigt werden. [Einer anderen Reihung durch das jeweilige Client-System steht aber grundsätzlich nichts entgegen]
Anzeige von Reichweitenberechnungen  ?
- Nur Portal: ?
    - Export als PDF / FHIR Formate
    - Abruf von Fach- und Gebrauchsinformationstexten
    - Anpassung der Sprache, in der Informationen dargestellt werden
    - Darstellung von Bildern der Packung, Tablette oder zu Beipackzetteln von Arzneimitteln

### Auslöser
* Der Medikationsplan einer/eines ELGA-Teilnehmer:in wird zur Ansicht aufgerufen

### Vorbedingungen
* Akteur ist authentifiziert und autorisiert
* GDA hat einen Behandlungsbezug und ist berechtigt auf lesend die e-Medikation des/der Bürgers/Bürgerin zuzugreifen

###	Nachbedingungen/Ergebnis
•	Der Medikationsplan des/der Bürgers/Bürgerin wird angezeigt
•	Zugriff wurde protokolliert


### Beispiel

### Technische Hinweise

### Relevante Profile

### Relevante Invarianten

### Mögliche Notifications