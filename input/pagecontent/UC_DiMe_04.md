{% include styleheader.md %}

## Anwendungsfall 4: UC_DiMe_04 Medikationsplan lesen

### Akteure

- ELGA-Teilnehmer bzw. Vertretung
- Obmudsstelle
- Behandelnde GDA:
    - Ärzte/Arztinnen (in Krankenanstalten und im niedergelassenen Bereich, mit und ohne Hausapotheke)
    - Apotheke
    - Pflegeeinrichtung, Mobile Pflege

### Beschreibung

**Patienten und behandlende GDA** können den Medikationsplan einsehen, um sich einen möglichst vollständigen Überblick zu allen verordneten Arzneimitteln und der zugehörigen Einnahmeninformation, ersichtlich in den Medikationsplaneinträgen, zu verschaffen.<br>


**Ärzte/Arztinnen** dient der Medikationsplan der Planung und Verordnung von Arzneimittelanwendungen bzw. der Überprüfung, ob eine Anpassungen der bestehenden Medikation erforderlich ist (siehe UC_DiMe_05 Medikationsplan schreiben).<br>


Sowohl **Ärzt:innen und berechtigte Pflegepersonen** in Pflegeeinrichtungen bzw. der mobilen Pflege können aus bestehenden Medikationsplaneinträgen geplante Abgaben (Rezepte) erstellen (siehe UC_DiMe_07).<br>


In der **Apotheke** kann vor einer Abgabe (basierend auf einer geplanten Abgabe, siehe UC_DiMe_06), mithilfe des Medikationsplans eine Medikationsanamnese durchgeführt werden bzw. der Medikationsstatus oder die Medikationshistorie erhoben werden.
<br>

Die Einsicht in geplante und durchgeführte Abgaben mit und ohne Medikationsplanbezug soll die Vollständigkeit der Information zur Medikation gewährleisten (siehe UC_DiMe_06, UC_DiMe_07, UC_DiMe_08).<br>



**Der Medikationsplan enthält:**
- Gesamtansicht aller verordneten, aktuell einzunehmenden Medikamente des Patienten samt Einnahmeinformationen (Medikationseinträge mit Status aktiv und aktuellem Datum)

- Je Medikationsplaneintrag werden folgende Information dargestellt:
    - Verantwortlicher GDA
    - Einnahmeinformation
    - Zugehörige geplante Abgaben
    - Zugehörige durchgeführte Abgaben (inkl. Abgaben von Substitutionen durch andere Arzneimittel(/“aut idem“) und „Leerabgaben“) Leerabgaben sind notwendig, um im Abgabeprozess im Zusammenspiel mit dem Einlösen eines Rezepts abzubilden, dass diese geplante Abgabe auch in Zukunft nicht mehr bedient werden wird.


- Einsicht in die „Zusätzlich erfolgte Abgaben“-Liste (Abgaben ohne zugehörigen Medikationsplaneintrag). 
    
    Sie enthält:
    - alle Abgaben, ohne zugehörigen Medikationsplaneintrag, die seit der letzten Version des Medikationsplans neu hinzugekommen sind bzw.
    - mit der letzten Version des Medikationsplans in der Liste beibehalten worden sind.


- Einsicht in die Vorversionen aller Medikationspläne (durch neue ersetzte Medikationspläne oder Medikationspläne mit Status ungültig)
    - Die Vorversionen enthalten keine „Zusätzlich erfolgte Abgaben“-Liste (keine Abgaben ohne zugehörigen Medikationsplaneintrag)
    - offen: Vorversionen können einen Korrekturvermerk (z.B. Änderung der Signatur oder Dosisänderung) enthalten

###	Abläufe
#### Standardablauf

1. Der Anwender wählt die Option Medikationsplan in der e-Medikation aus <br>

2. Primärsystem bzw. Portal ruft den Medikationsplan von der Zentralen Anwendung e-Medikation ab und bereitet ihn für die Anzeige auf:
    - filtert Medikationsplaneinträge heraus, die inzwischen zeitlich abgelaufen sind

3. Der Anwender kann die Ansicht wie folgt Ansicht anpassen:
    - Anzeigen von Änderungen an einem Medikationsplaneintrag:
        - Art der Änderung
        - Verantwortlicher GDA
        - Zeitpunkt der Änderung
    - Anzeigen des Medikationsplans zu einem bestimmten Zeitpunkt in der Vergangenheit (Historie)
        - Anzeige von stornierten Medikationsplänen (analog zu aktueller Umsetzung von stornierten Abgaben)
    - Anzeigen der geplanten und durchgeführten Abgaben zu einem Medikationsplaneintrag
        - Anzeige der Historie geplanter und durchgeführter Abgaben
    - Anzeigen der durchgeführten Abgaben ohne Medikationsplaneintrag
        - wird erst angezeigt, nachdem der erste Medikationsplan gespeichert wurde
        - Anzeige der Historie durchgeführter Abgaben ohne Medikationsplaneintrag ?

    - Optional können weitere Funktionen durch das Primärsystem bzw. Portal bereitgestellt werden, wie z.B.
        - Filter- und Suchfunktionen
        - Gruppierung (?) / Sortiermöglichkeit von Medikationsplaneintrag 
    
    - Das Portal stellt weiters zu Verfügung:
        - Export als PDF / FHIR Formate (JSON, XML)
        - Abruf von Gebrauchsinformationen der Arzneimittel (Beipackzettel)
        - Anpassung der Sprache, in der Informationen dargestellt werden
        - Darstellung von Bildern der Packung, Tablette oder zu Beipackzetteln von Arzneimitteln

    offen: Anzeige von Reichweitenberechnungen ? 

### Auslöser
- Der Medikationsplan einer/eines ELGA-Teilnehmer:in wird zur Ansicht aufgerufen

### Vorbedingungen
- Akteur ist authentifiziert und autorisiert
- GDA hat einen Behandlungsbezug und ist berechtigt lesend auf die e-Medikation der ELGA-Teilnehmerin/des ELGA-Teilnehmers zuzugreifen

###	Nachbedingungen/Ergebnis
- Der Medikationsplan der ELGA-Teilnehmerin/des ELGA-Teilnehmers wird angezeigt
- Zugriff wurde protokolliert


### Beispiel

### Technische Hinweise

### Relevante Profile

### Relevante Invarianten

### Mögliche Notifications