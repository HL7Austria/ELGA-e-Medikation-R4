{% include styleheader.md %}

<!-- Anwendungsfall UC_eMed_06: Medikationsplan schreiben -->

### Beschreibung

Als GDA möchte ich den Medikationsplan von einem:einer ELGA-Teilnehmer:in bearbeiten können, um eine Übersicht über die gesamte aktuell einzunehmende Medikation zur Verfügung zu stellen. 

Als ELGA-Teilnehmer:in möchte ich Medikationsplaneinträge oder ganze Medikationsplanversionen unwiderruflich löschen können, um gezielt die Verfügbarkeit meiner Medikationsdaten einzuschränken. 


### Akteure

* GDA
* ELGA-Teilnehmer:in
* Vertretung 
* OBST 

### Auslöser

* GDA möchte einen Medikationsplan für eine:n ELGA-Teilnehmer:in bearbeiten 
* ELGA-Teilnehmer:in möchte einen Medikationsplaneintrag oder eine vollständige Medikationsplanversion unwiderruflich löschen 

### Vorbedingungen

* Benutzer:in ist authentifiziert und autorisiert 
* ELGA-Teilnehmer:in ist eindeutig identifiziert 

### Nachbedingungen/Ergebnis 

* eine neue Medikationsplanversion wurde durch die Bearbeitung des bestehenden Medikationsplans erzeugt (durch GDA oder ELGA-Teilnehmer:in) oder  
* eine bestehende Version wurde gelöscht (durch ELGA-Teilnehmer:in) 
* Zugriff wird protokolliert

###	Abläufe
#### Standardablauf: Medikationsplan bearbeiten 

1. GDA startet die Bearbeitung des Medikationsplans basierend auf der zuletzt erfassten Medikationsplanversion (initial steht ein „leerer“ Medikationsplan zur Verfügung). Es können 
    a. neue Medikationsplaneinträge hinzugefügt werden<br>
    b. bestehende Medikationsplaneinträge unverändert beibehalten werden <br>
    c. bestehende Medikationsplaneinträge verändert werden (fachliche Änderung) <br>
    d. bestehende Einträge entfernt werden (Absetzen von Medikamenten) <br>
    e. bestehende Einträge verworfen werden (als „irrtümlich erfasst“ kennzeichnen) <br>
    f. bestehende Einträge pausiert werden <br>
2. GDA definiert die Reihenfolge der Medikationsplaneinträge 
3. GDA bestätigt die Verträglichkeit der neu hinzugefügten/geänderten Medikation mit dem bestehenden Medikationsplan und speichert diesen ab 


#### Alternativabläufe 

##### Alternativablauf 01: einzelne Medikationsplaneinträge löschen

1. ELGA-Teilnehmer:in ruft den zuletzt erfassten Medikationsplan auf  
2. ELGA-Teilnehmer:in löscht einzelne Medikationsplaneinträge aus dem Medikationsplan unwiderruflich 
3. ELGA-Teilnehmer:in speichert den neuen Medikationsplan ab 

##### Alternativablauf 02: Medikationsplanversionen löschen 

1. ELGA-Teilnehmer:in ruft eine bestehende Medikationsplanversion auf (eine beliebige Vorversion oder die zuletzt erfasste Version) 
2. ELGA-Teilnehmer:in löscht die aufgerufene Medikationsplanversion unwiderruflich 

### Hinweise 

#### H01: Medikationsplan bearbeiten 

Ein Medikationsplan besteht aus ein oder mehreren Medikationsplaneinträgen (oder ist initial bzw. nach einem vollständigen Absetzen der gesamten Medikation leer). Jeder Medikationsplaneintrag beinhaltet ein verordnetes Medikament samt Einnahmeinformation, das von der:dem ELGA-Teilnehmer:in aktuell eingenommen werden soll. Zudem enthält der Medikationsplaneintrag die Information, welche:r Ärztin:Arzt diesen medizinisch verantwortet. 

Ein Medikationsplaneintrag beinhaltet u.a. folgende Informationen: 

* Präparat (PZN/Wirkstoff, Dosierung) 

    * durch die Fachanwendung wird geprüft, ob der angegebene PZN-Code mit dem bereitgestellten Anzeigename des Präparats übereinstimmt (Abgleich ASP-Liste)
* Gebrauchsanweisung (Signatur)
* Einnahmezeitraum (befristet, unbefristet) 
* Verordner:in 
* Hinweise 
* Fremdmedikation/Eigenmedikation 


ℹ️
##### Interaktionen zur Bearbeitung des Medikationsplans im jeweiligen Clientsystem
Die zuletzt erfasste Medikationsplanversion wird als Basis für die Bearbeitung des Medikationsplans und die daraus resultierende Erzeugung einer neuen Medikationsplanversion durch GDA im Clientsystem verwendet: 

###### Neue Medikationsplaneinträge hinzufügen 
* Manuelles Erfassen neuer Einträge mittels Angabe aller erforderlichen Informationen 
* Als Eingabe-Unterstützung für Benutzer:innen: Übernahme der Daten einer durchgeführten Abgabe ohne zugehörige geplante Abgabe; vor der Speicherung des neuen Medikationsplaneintrages können diese nochmals vom GDA verändert werden (UC_eMed_07 Geplante und durchgeführte Abgaben lesen) 

###### Bestehende Medikationsplaneinträge unverändert beibehalten / zur Kenntnis nehmen 
* Beibehalten / zur Kenntnisnahme von bestehenden Medikationsplaneinträgen der zuletzt erfassten Medikationsplanversion 
* es können nur Medikationsplaneinträge mit gültigem Einnahmezeitraum übernommen werden 
* es findet keine Verantwortungsübernahme durch den bearbeitenden GDA für unverändert beibehaltene Medikationsplaneinträge statt 

ℹ️ Benutzer:innen erhalten einen Hinweis darüber, dass befristete Medikationsplaneinträge mit abgelaufenem Einnahmezeitraum nicht in die neue Version übernommen werden (sofern abgelaufene Medikationsplaneinträge in der zuletzt erfassten Medikationsplanversion enthalten sind) 

###### Bestehende Medikationsplaneinträge verändern (fachliche Änderung) 
* bestehende Medikationsplaneinträge der zuletzt erfassten Medikationsplanversion werden vor der Speicherung der neuen Medikationsplanversion nochmals verändert 
* bestehende Medikationsplaneinträge können von jedem GDA überarbeitet werden (auch wenn diese initial nicht von dem bearbeitenden GDA erfasst wurden) 
* es können alle Datenfelder eines bestehenden Medikationsplaneintrages verändert werden 

ℹ️ Benutzer:innen erhalten einen Hinweis darüber, dass bei fehlender fachlicher Kontinuität der Bearbeitung eines Medikationsplaneintrages (z.B. Änderung PZN; Blutdruckmittel auf Antibiotikum) ein neuer Medikationsplaneintrag zu erfassen ist und kein bestehender Eintrag weiterverwendet werden soll 

###### Bestehende Medikationsplaneinträge entfernen (Absetzen von Medikamenten) 
* ein GDA kann bestehende Medikationsplaneinträge entfernen und damit die betreffenden Medikamente absetzen vgl. H03 
    * beim Absetzen von Medikamenten muss der Absetzungsgrund dokumentiert werden 
    * Medikation vollständig absetzen: es werden alle bestehenden Medikationsplaneinträge entfernt und ein leerer Medikationsplan gespeichert 

* befristete Medikationsplaneinträge mit abgelaufenen Einnahmezeitraum werden einem GDA als solche angezeigt, um diese beim Erfassen einer neuen Medikationsplanversion als beendet kennzeichnen zu können (sofern die betreffenden Medikamente nicht weiterverordnet werden, werden diese nicht mehr in die neue Medikationsplanversion übernommen) <br><br>

ODER 

* befristete Medikationsplaneinträge werden nach Ablauf des Einnahmezeitraums durch die Fachanwendung aus dem Medikationsplan herausgefiltert und stehen für das Erfassen einer neuen Medikationsplanversion nicht mehr zur Verfügung <br><br>

ODER 

* befristete Medikationsplaneinträge mit abgelaufenen Einnahmezeitraum verbleiben im Medikationsplan und können für die Anzeige im Clientsystem entsprechend gekennzeichnet oder gefiltert werden <br><br>

###### Bestehende Medikationsplaneinträge verwerfen (als „irrtümlich erfasst“ kennzeichnen) 

= stornieren laut IG-Statuschart 
* zur Bereinigung fehlerhaften Angaben in einem Medikationsplaneintrag kann dieser wieder verworfen (bzw. als „irrtümlich erfasst“ gekennzeichnet) werden 
* verworfene Einträge werden nicht mehr im Medikationsplan angezeigt, können aber über die Versionshistorie aufgerufen werden und werden darin als „irrtümlich erfasst“ ausgewiesen 
* eine Richtigstellung der fehlerhaften Angabe erfolgt in einem neuen Medikationsplaneintrag (sofern notwendig) 

ℹ️ Benutzer:innen erhalten einen Hinweis, sofern bereits geplante Abgaben existieren, die auf den verworfenen Medikationsplaneintrag referenzieren. Es soll eine einfache Möglichkeit geschaffen werden, in diesem Zuge auch die zugehörigen Abgaben zu verwerfen (vgl. UC_eMed_08 Geplante Abgabe schreiben) 

###### Bestehende Medikationsplaneinträge pausieren oder reaktivieren 

* sofern die Therapie mit einem im Medikationsplan enthaltenen Medikament vorübergehend unterbrochen werden soll und die Wiederaufnahme zu einem späteren Zeitpunkt vorgesehen ist, kann der bestehende Medikationsplaneintrag unbefristet (oder für einen definierten Zeitraum) pausiert werden 
* bereits pausierte Medikationsplaneinträge können zur Wiederaufnahme der Therapie reaktiviert werden (ggf. werden in diesem Zuge noch weitere Änderungen am Medikationsplaneintrag vorgenommen; vgl. „fachliche Änderung“ oben) 

ℹ️ Benutzer:innen erhalten einen visuellen Hinweis zu pausierten Einträgen im Medikationsplan, um diese von der aktiven Medikation unterscheiden zu können 

###### Reihenfolge der Medikationsplaneinträge im Medikationsplan festlegen 

* die Reihenfolge der Medikationsplan-Einträge kann definiert/geändert werden 
    * dies impliziert keine medizinische Verantwortungsübernahme für den jeweiligen umsortierten Eintrag selbst 
* bei jeder Umsortierung und Speicherung der neuen Reihenfolge wird eine neue Medikationsplanversion erzeugt 
* die durch die Fachanwendung gelieferte Reihenfolge der Medikationsplaneinträge kann im Clientsystem wiedergegeben werden und bei Bedarf kann eine eigene Reihung vorgenommen werden 


#### H02: Löschen von Einträgen im Medikationsplan bzw. einer Medikationsplan-Version 

ELGA-Teilnehmer:innen können folgende Löschungen durchführen: 
* Unwiderrufliches Löschen einzelner Medikationsplaneinträge der zuletzt erfassten Medikationsplanversion 
    * durch das Löschen einzelner Medikationsplaneinträge wird eine neue Medikationsplanversion erfasst, die nur noch die beibehaltenen Medikationsplaneinträge enthält 
    * das Löschen aller Einträge eines Medikationsplans führt zu einem leeren Medikationsplan (im Rahmen der Selbstbestimmung zulässig) 
    * Unwiderrufliches Löschen vollständiger Medikationsplanversionen 

Autor der Löschung (und damit der neuen/unvollständigen bzw. leeren Medikationsplanversion) ist der:die ELGA-Teilnehmer:in. Die Verantwortung über den gesamten Medikationsplan inkl. der gelöschten Einträge trägt von diesem Zeitpunkt an nicht mehr der Verfasser des Medikationsplans (GDA), sondern der:die ELGA-Teilnehmer:in selbst. 

##### ℹ️ Hinweis für ELGA-Teilnehmer:in zum Eingang medizinischen Risiken im Clientsystem anzeigen 

Beim Löschen von relevanten Medikationsdaten wird eigenverantwortlich ein Risiko einer Schlechtbehandlung durch den GDA eingegangen, das aufgrund der Informationsverknappung entsteht. <br><br>
 
##### ℹ️ Stapelverarbeitung betroffener Medikationsplanversionen im Clientsystem 
Um ein „rückstandsloses“ Löschen von ausgewählten Medikamenten aus der Medikationsplanhistorie zu ermöglichen, kann basierend auf einem Suchergebnis (alle Versionen, die bspw. eine bestimmte PZN/Wirkstoff oder Medikationsplaneintrags-ID enthalten) eine Stapelverarbeitung zum Löschen der betroffenen Medikationsplanversionen durchgeführt werden. Zusätzlich soll auch auf zugehörige geplante und durchgeführte Abgaben hingewiesen werden.  

#### H03: Absetzen von Medikamenten 

Um Medikamente aus dem Medikationsplan abzusetzen, entfernt ein GDA die entsprechenden Medikationsplaneinträge und erzeugt damit eine neue Medikationsplanversion. In diesem Zuge muss der Grund des Absetzens für jeden abgesetzten Medikationsplaneintrag dokumentiert werden. In der Historie des Medikationsplans sind die Informationen über abgesetzte Medikamente einsehbar. Über entsprechende Suchparameter können alle abgesetzten Medikamente aus der Historie zurückverfolgt werden. 

Soll der neue Medikationsplan keine Medikationsplaneinträge mehr enthalten – sprich der:die ELGA-Teilnehmer:in soll derzeit keine Medikation mehr einnehmen – muss ein leerer Medikationsplan gespeichert werden. Das bedeutet, dass alle bestehenden Medikamente aus dem Medikationsplan als beendet gekennzeichnet und entfernt werden. 

Sobald der Einnahmezeitraum für befristete Medikationsplaneinträge abgelaufen ist, können die entsprechenden Medikamente nicht in die neue Medikationsplanversion übernommen werden (Einnahmeende darf nicht in der Vergangenheit liegen). Der erfassende GDA kann in diesem Fall die befristeten Medikamente nochmals weiterverordnen oder diese als beendet kennzeichnen und damit aus dem Medikationsplan entfernen. 

#### Erfassen von Fremdmedikation 

Ein GDA kann Medikamente, die nicht im Medikationsplan enthalten sind, aber von dem:der ELGA-Teilnehmer:in eingenommen werden, als Fremdmedikation erfassen (entsprechende Kennzeichnung ist notwendig). Dadurch wird die Vollständigkeit des Medikationsplans erhöht. Der erfassende GDA übernimmt dabei allerdings nicht die medizinische Verantwortung für den ergänzten Medikationsplaneintrag, sondern gilt nur als erfassende Person. 

##### ℹ️ Befüllung der medizinisch verantwortlichen Person im Clientsystem

Die medizinisch verantwortliche Person bzw. der:die Verordner:in kann im Regelfall durch das Clientsystem anhand des:der eingeloggten Benutzer:in automatisch ermittelt bzw. vorbefüllt werden. 

Beim Erfassen von Fremdmedikation entspricht der:die eingeloggte Benutzer:in allerdings nicht der medizinisch verantwortlichen, sondern nur der erfassenden Person und es muss hierfür eine Ausnahmelogik implementiert werden. 

<!-- #### Ablauf des Einnahmezeitraums eines Medikaments  -->

<!-- Zu ergänzen: Mechanismus beim Ablauf des Einnahmezeitraums  -->
<!-- * Automatisches Entfernen abgelaufener Medikamente (aber: Nachvollziehbarkeit?) ODER  -->
<!-- * Bestätigung durch GDA bei nächster Bearbeitung des Medikationsplan (aber: Zusatzaufwand bzw. fachliche Relevanz?) ODER  -->
<!-- * Beibehalten abgelaufener Medikationsplaneinträge und Ausblenden im Clientsystem  -->

##### ℹ️ Kennzeichnung abgelaufener Medikamente im Clientsystem 

Sobald der Einnahmezeitraum eines befristeten Medikationsplaneintrages abgelaufen ist, soll dieses entsprechend für ELGA-Teilnehmer:innen und GDA im Medikationsplan ersichtlich sein. Ggf. kann es sinnvoll sein, abgelaufene Medikamente aus der Medikationsplanansicht herauszufiltern. 

#### H06: Gesetzliche Speicherfristen 

Medikationspläne werden nach Ablauf der gesetzlichen Speicherfrist gelöscht: 
* 120 Jahre nach Geburt 
* 30 Jahre nach Sterbedatum 

### Abgrenzungen 

Keine.