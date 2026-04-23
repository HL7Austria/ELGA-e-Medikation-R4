{% include styleheader.md %}
Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der Medikationsplan eines Patienten mit den zugehörigen geplanten Abgaben und den durchgeführten Abgaben verändern kann.

<!-- * Ärztin Hermine Fremdmedikation: [Practitioner 2](Practitioner-At-Emed-Example-Practitioner-02.html) -->

### 27.2.2026: Arztbesuch

Dr. Musterärztin möchte ihrem Patienten Max Mustermann mehrere Medikamente verschreiben. Daher ruft sie seinen Medikationsplan ab, um eine Übersicht über seine gesamte, aktuell von ihm einzunehmende Medikation zu erhalten. 

Da für Herrn Mustermann noch nie ein Medikationsplan abgerufen wurde, erstellt die Fachanwendung automatisch einen leeren Medikationsplan. Darin enthalten sind die Informationen zum [Patienten](Patient-At-Emed-Example-Patient-01.html), die erstellende e-Medikation-Fachwanwendung ([Device](Device-At-Emed-Example-Device-01.html)), das Datum der Erstellung und der Grund, warum der Plan noch leer ist (EmptyReason *notstarted*).

   * **Leerer Medikationsplan:**
     * [Collection Bundle](Bundle-At-Emed-Journey-01-Bundle-Medikationsplan.html) 
        
Dr. Musterärztin ergänzt das Medikament Ebetrexat (10 mg, Tabletten) und erklärt dem Patienten, dass er morgens und abends je eine Tablette einnehmen soll und worauf er bei der Einnahme zu achten hat. Sie dokumentiert dies in seinem Medikationsplan. <br>
Weiters verschreibt sie ihrem Patienten eine magistrale Zubereitung einer Cortison-Salbe, die er eine Woche lang abends auftragen soll.<br>
Sie speichert den neuen Medikationsplan.

   * **Medikationsplaneinträge hinzufügen:**
     * [Transaction Bundle](Bundle-At-Emed-Journey-02-Bundle-Tx-Medikationsplan.html)

Im neu erstellen Medikationsplan sind die neuen Planeinträge sowie das Datum der Bearbeitung und als verantwortliche Ärztin Dr. Musterärztin ([Practitioner 1](Practitioner-At-Emed-Example-Practitioner-01.html)) ersichtlich.

Dr. Musterärztin erstellt für beide Medikamente eine geplante Abgabe (Rezeptierung), sodass Herr Mustermann die Medikamente in der Apotheke abholen kann.

   * **Geplante Abgaben erstellen:**
     * Beispiel [Medication Request](MedicationRequest-At-Emed-Journey-03-Mr-Geplante-Abgabe.html)
  

### 28.2.2026: Abgabe in der Apotheke, Teil 1

Herr Mustermann sucht eine ([Apotheke](Organization-At-Emed-Example-Organization-Apo-01.html)) auf, um sich die Medikamente abzuholen.<br>
Der Apotheke identifiziert den Patienten, sieht die geplanten Abgaben in der e-Medikation und kontrolliert, ob im Medikationsplan eventuell wechselwirkungsrelevante Medikation existiert. 
Da er das Medikament Ebetrexat verfügbar hat, erstellt er eine durchgeführte Abgabe 
<!-- stellt den Status der zugehörigen geplanten Abgabe auf completed  -->
und händigt dem Patienten das Medikament aus.<br>
Für die Herstellung der magistralen Zubereitung benötigt der Apotheker Zeit, er erstellt eine durchgeführte Abgabe und kennzeichnet sie entsprechend, 
<!-- (TODO: on-hold?)  -->
sodass dies in der e-Medikation ersichtlich ist. 

  * Durchgeführte Abgabe (zu erstellen) 
  <!-- * Geplante Abgabe Ebetrexat auf completed setzen: TODO -->
  <!-- * Geplante Abgabe Cortinson-Salbe auf on-hold setzen: TODO -->

<!-- TODO: Abholung beenden. -->

### 1.3.2026: Abgabe in der Apotheke, Teil 2

Herr Mustermann sucht erneut die Apotheke auf, um die magistrale Zubereitung abzuholen. Der Apotheker kennzeichnet die bereits vorhandene durchgeführte Abgabe als abgeschlossen und übergibt dem Patienten das Medikament.


### 5.3.2026: Abruf Medikationsplan durch Patienten

Ein paar Tage später, ist sich Herr Mustermann nicht mehr sicher, welches Medikament er wie einnehmen soll und ruft in seiner ELGA seinen Medikationsplan auf. 

   * Medikationsplan mit 2 Medikationsplaneinträgen anzeigen:
     * Beispiel: [Collection Bundle](Bundle-At-Emed-Journey-02-Bundle-Medikationsplan.html)


### 10.3.2026: Kontrolltermin

Der Patient erscheint zur Kontrolle bei Dr. Musterärztin, die den aktuellen Medikationsplan abruft.

Das Medikament EBETREXAT soll der Patient noch bis zum 17.3. einnehmen, aber in geringerer Dosis (nur noch 1 Stück morgens).
Die Cortisonsalbe ist nicht mehr nötig, daher soll der Patient diese absetzen. Frau Dr. Musterärztin nimmt die entsprechenden Änderungen in den beiden Medikationsplaneinträge vor und speichert den neuen Medikationsplan.

   * Medikationsplaneinträge ändern:
     * Beispiel: [Transaction Bundle](Bundle-At-Emed-Journey-05-b-Bundle-Tx-Medikationsplan.html)
  
   <!-- * Medikationsplan (Variante ohne Filter: abgelaufenen Einträge anzeigen): -->
     <!-- * Beispiel: [Collection Bundle](Bundle-At-Emed-Journey-05-b-Bundle-Medikationsplan.html) -->
     

<!-- Weil er es für sinnvoll hält, ändert er die Reihenfolge der Planeinträge. Die Medikationsplaneinträge ändern sich inhaltlich dadurch nicht. -->

   <!-- * Medikationsplan mit geänderter Reihenfolge anzeigen: -->
  <!-- * Beispiel: [Collection Bundle](Bundle-At-Emed-Journey-05-a-Bundle-Medikationsplan.html) -->


<br>
<div>{% include_relative plantuml/diagram_journey.svg %}</div>
<br>