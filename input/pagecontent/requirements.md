{% include styleheader.md %}


### Patient Journey

Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der Medikationsplan eines Patienten mit den zugehörigen geplanten Abgaben und den durchgeführten Abgaben verändern kann.

Anmerkung: Journey-01 ist für e-Medikation vorausgesetzt und wird nur zur Vollständigkeit dokumentiert.

#### Journey-01:
##### Initialisierung: Ressourcen anlegen:

   * Personen, Organisationen, Fachanwendung:
     * Patient Max Mustermann: [Patient](Patient-At-Emed-Journey-01-Patient-01.html)  
     * Ärztin Melanie Musterärztin: [Practitioner 1](Practitioner-At-Emed-Journey-01-Practitioner-01.html)
     * Ärztin Hermine Fremdmedikation: [Practitioner 2](Practitioner-At-Emed-Journey-01-Practitioner-02.html)
     * Amadeus Apotheke: [Organization](Organization-At-Emed-Journey-01-Organization-Apo.html)
     * Fachanwendung e-Medikation: [Device](Device-At-Emed-Journey-01-Device.html)
   * Leeren Medikationsplan für einen Patienten erzeugen (durch die e-Medikationr Fachanwendung): [Transaction Bundle](Bundle-At-Emed-Journey-01-Bundle-TX-Medikationsplan.html)

#### Journey-02:

Am 28.1.2026 möchte Dr. Musterärztin ihrem Patienten Max Mustermann mehrere Medikamente verschreiben verschreiben. Daher ruft sie seinen Medikationsplan ab, um eine Übersicht über seine gesamte, aktuell von ihm eingenommene Medikation zu erhalten. (Anmerkung: Beim Start von e-Medikation v4 erhalt jeder Patient per Default einen leeren Medikationsplan.)

   * Leeren Medikationsplan anzeigen:
     * Beispiel: [Collection Bundle](Bundle-At-Emed-Journey-Bundle-Medikationsplan-01.html)
        
Dr. Musterärztin ergänzt das Medikament Ebetrexat (10 mg, Tabletten) und erklärt dem Patienten worauf er bei der Einnahme zu achten hat. Sie dokumentiert dies in seinem Medikationsplan.
Weiters verschreibt sie ihrem Patienten eine Hydrocortison Salbe, die er einmal täglich auftragen soll.
Sie speichert den neuen Medikationsplan und erstellt für beide Medikamente eine geplante Abgabe, sodass Herr Mustermann diese in der Apotheke abholen kann.

   * Medikationsplaneinträge hinzufügen:
     * Beispiel [Transaction Bundle](Bundle-At-Emed-Journey-Bundle-Medikationsplan-Tx-02.html)
   * TODO: Abgaben erstellen.

##### Medikationsplan lesen:

   * Medikationsplan mit 2 Medikationsplaneinträgen anzeigen:
     * Beispiel: [Collection Bundle](Bundle-At-Emed-Journey-Bundle-Medikationsplan-02.html)




### Dosierungsbeispiele

Die Dosierung wir in der MedicationRequest Ressource dokumentiert. Folgende [Varianten][1] stehen zur Verfügung, deren Einhaltung technisch über Invarianten geprüft werden.
Alle Dosierungsbeispiele werden anhand des Medikationsplaneintrags gezeigt.

[1]: <https://ig.fhir.de/igs/medication/index.html> "Dosierschemata, abgeleitet von FHIR Dosierungen für den digital gestützten Medikationsprozess - Medication IG DE v1.0.3"

#### Freitext-Dosierung

Ist es nicht möglich, die Dosierung strukturiert anzugeben, kann diese als Freitext angegeben werden.
Hierfür wird nur dosageInstructions.text befüllt. dosageInstruction.timing und dosageInstruction.doseAndRate dürfen nicht befüllt werden.

* Beispiel: [Planeintrag mit Freitextdosierung](MedicationRequest-At-Emed-Example-Mr-Dosierung-Freitext.html)

#### Schema mit Tageszeiten-Bezug  

Das Schema gibt an, zu welchen Tageszeiten (morgens, mittags, abends, nachts) das Medikament angewandt werden soll. 
Das Tageszeitenschema wird häufig in Form einer vierstelligen Zahlenfolge dargestellt (z.B. 1-0-1-0).

##### Varianten

* Die Einnahmezeitpunkte sind täglich und bleiben über gesamte Behandlungsdauer gleich.  
  * Beispiel: [Planeintrag mit Tageszeitenschema Einnahme einmal morgens und abends](MedicationRequest-At-Emed-Example-Mr-Dosierung-1010.html)
* Die Einnahmezeitpunkte beziehen sich auf einzelne Tage.
* Die Behandlungsdauer kann auf ein Datum oder eine Anzahl von Tagen begrenzt werden.


#### Schema mit Uhrzeiten-Bezug

Das Schema gibt an, zu welcher Uhrzeit das Medikament angewandt werden soll (z.B. 8:00 Uhr).

##### Varianten

* Die Einnahmezeitpunkte bleiben täglich über den gesamten Behandlungszeitraum gleich:
  * [Planeintrag mit 1 Tablette täglich um 8 Uhr morgens](MedicationRequest-At-Emed-Example-Mr-Dosierung-Zeit-1tg.html)
* Die Einnahmedauer kann begrenzt werden (z.B Anzahl Tage):
  * Planeintrag mit 1 Tablette täglich um 8 Uhr morgens begrenzt auf 5 Tage
* Abhängig von der Uhrzeit wird eine unterschiedliche angewandt;
  * Planteintrag mit 8 Uhr: 2 Stück - 11 Uhr: 1 Stück - 14 Uhr: 1 Stück - 17 Uhr: 1 Stück - 20 Uhr: 1 Stück - 23 Uhr: 1 Stück

#### Schema mit Wochentags-Bezug



#### Schema für wiederkehrende Intervalle

#### Schema für Kombinationen von Zeitintervallen

#### Schema für Kombinationen von Wochentagen


