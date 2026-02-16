{% include styleheader.md %}

<!-- Anwendungsfall UC_eMed_07: Geplante und durchgeführte Abgaben lesen -->

### Beschreibung

GDA sollen alle geplanten und durchgeführten Abgaben von ELGA-Teilnehmer:innen mit Behandlungsbezug einsehen können, um sich einen Überblick zu den verordneten und abgegebenen Medikamenten zu verschaffen. 

ELGA-Teilnehmer:innen sollen alle geplanten und durchgeführten Abgaben einsehen können, um sich einen Überblick zu den verordneten und abgegebenen Medikamenten zu verschaffen. 

### Akteure

* GDA
* ELGA-Teilnehmer:in
* Vertretung 
* OBST 

### Auslöser

* Benutzer:in möchte alle geplanten und durchgeführten Abgaben eines:einer ELGA-Teilnehmer:in anzeigen lassen 

### Vorbediungungen

* Benutzer:in ist authentifiziert und autorisiert 
* ELGA-Teilnehmer:in ist eindeutig identifiziert 

### Nachbedingungen/Ergebnis 

* Die geplanten und durchgeführten Abgaben des:der ELGA-Teilnehmer:in werden angezeigt
* Zugriff wird protokolliert

###	Abläufe
#### Standardablauf

* Benutzer:in ruft die geplanten/durchgeführten Abgaben auf 
* Geplante/durchgeführte Abgaben werden angezeigt 


#### Alternativabläufe 
Keine

### Relevante ILF (Implementierungsleitfäden) + deren User Storys 

#### Beispiel

#### Technische Hinweise

#### Relevante Profile

#### Relevante Invarianten

#### Mögliche Notifications

### Abgrenzungen 
Keine.

### User Interface Beschreibungen 
Mockup folgt.

### Hinweise 


### Anzeige geplanter Abgaben (UC_eMed_07_H01)

Die geplanten Abgaben können gelesen werden: 
* Inhalte der geplanten Abgaben, siehe UC_eMed_08 Geplante Abgabe schreiben 
* Geplante Abgaben können Korrekturvermerke enthalten, siehe UC_eMed_07_H03 
* Ausgeblendete geplante Abgaben werden in der Abgabenübersicht nicht angezeigt 
* Geplante Abgaben stehen nach einer unwiderruflichen Löschung nicht mehr zur Verfügung

<div class="hinweisbox">
  ℹ️   
  Möglichkeiten zur Darstellung der geplanten Abgaben im Client-System:<br>
  <ul>
    <li> Zu den einzelnen Einträgen der geplanten Abgaben können folgende Informationen ergänzend dargestellt werden: 
      <ul>
        <li>zugehöriger Medikationsplan bzw. Medikationsplaneintrag </li>
        <li>zugehörige durchgeführte Abgaben
          <ul>
            <li>inkl. Abgaben von Substitutionen durch andere Arzneimittel und „Leerabgaben“ 
    (Leerabgaben sind notwendig, um im Abgabeprozess im Zusammenspiel mit dem Einlösen eines Rezepts abzubilden, dass diese geplante Abgabe auch in Zukunft nicht mehr bedient werden wird.)
            </li>
          </ul>
        </li>
        <li>abgelaufener Gültigkeitszeitraum einer geplanten Abgabe </li>
      </ul>
    </li>
    <li>Filter- und Suchfunktionen können hilfreich sein (v.a. bei Abgabenlisten, die viele Einträge enthalten) </li>
  </ul>
</div>

### Anzeige durchgeführter Abgaben (UC_eMed_07_H02)

Die durchgeführten Abgaben können gelesen werden: 
* Inhalte der durchgeführten Abgaben, siehe UC_eMed_09 Durchgeführte Abgabe schreiben 
* Durchgeführte Abgaben können Korrekturvermerke enthalten 
* Ausgeblendete durchgeführte Abgaben werden in der Abgabenübersicht nicht angezeigt 
* Durchgeführte Abgaben stehen nach einer unwiderruflichen Löschung nicht mehr zur Verfügung 

<div class="hinweisbox">
  ℹ️   
  Möglichkeiten zur Darstellung der geplanten Abgaben im Client-System:<br>
  <ul>
    <li> Zu den einzelnen Einträgen der durchgeführten Abgaben können folgende Informationen ergänzend dargestellt werden (sofern vorhanden):  
      <ul>
        <li>zugehöriger Medikationsplan bzw. Medikationsplaneintrag </li>
        <li>zugehörige geplante Abgabe </li>    
      </ul>
    </li>
    <li>Filter- und Suchfunktionen können hilfreich sein (v.a. bei Abgabenlisten, die viele Einträge enthalten) </li>
  </ul>
</div>



### Anzeige korrigierter Abgaben (Korrekturvermerk) (UC_eMed_07_H03)

Einzelne geplante bzw. durchgeführte Abgaben können Korrekturvermerke (inkl. Freitext) enthalten und müssen dem:der Benutzer:in angezeigt werden. 

<div class="hinweisbox">
  ℹ️   
  Möglichkeiten zur Darstellung der geplanten Abgaben im Client-System:<br>
  siehe UC_eMed_05 Medikationsplan lesen 
</div>

### Export der geplanten und durchgeführten Abgaben (UC_eMed_07_H04)

Folgende Exportformate stehen für Benutzer:innen zur Verfügung: 
ELGA-Teilnehmer:innen:
  * PDF zum Ausdrucken bzw. zur Darstellung in der Druckansicht 
  * Strukturierter Datendownload (FHIR) 
GDA:
  * PDF zum Ausdrucken bzw. zur Darstellung in der Druckansicht 

<div class="hinweisbox">
  ℹ️   
  Für den PDF-Export stellt die ELGA GmbH ein Softwaremodul zur Verfügung, welches in den jeweiligen Softwaresystemen eingebunden werden kann. Dieses "FHIR2PDF"-Softwaremodul stellt die Funktionen zur Verfügung, um die geplanten/durchgeführten Abgaben als PDF zu exportieren. Das exportierte PDF unter Nutzung des "FHIR2PDF" stellt ein signiertes Dokument dar. 
</div>


### Abgaben: Eigene Ansicht vs. Verwendung des e-Medikation Stylesheets (UC_eMed_07_H05)

Zur Anzeige der geplanten und durchgeführten Abgaben wird von der ELGA GmbH ein Stylesheet angeboten, welches in den jeweiligen Softwaresystemen eingebunden werden kann.  

* Dieses "e-Medikation Stylesheet" stellt alle notwendigen/vorhanden Informationen dar - Daten zur Person, aktuelle und vergangene Medikationsplaneinträge, geplante und durchgeführte Abgaben, etc. 

Neben der Verwendung des e-Medikation Stylesheets kann auch eine eigene Ansicht der geplanten/durchgeführten Abgaben in den Softwaresystemen umgesetzt werden. 