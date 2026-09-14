{% include styleheader.md %}

Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der **Medikationsplan** eines Patienten mit den zugehörigen **Geplanten Abgaben** und den **Durchgeführten Abgaben** verändern kann.

<!-- TODO: nicht-sunshine-cases: patient ohne ecard in apotheke, 
Einträge durch patient löschen, stornieren, rezept wieder öffnen, wenn teilabgabe storniert -->


**27.2.2026: Arztbesuch**

Herr Mustermann kommt wegen Kopfschmerzen und Schwindelgefühl zu seiner Hausärztin. Außerdem hat er einen leichten Hautausschlag bemerkt.

Dr. Hausärztin stellt eine leichte arterielle Hypertonie fest und ruft die e-Medikation (den aktuellen *Medikationsplan*,  *Geplante Abgaben* und *Durchgeführte Abgaben*) des Patienten  ab, um einen Überblick über seine aktuelle Medikation zu erhalten. 

Da für Herrn Mustermann noch nie ein Medikationsplan abgerufen wurde, erstellt die Fachanwendung automatisch einen leeren Medikationsplan. Darin enthalten sind die Informationen zum Patienten, die erstellende e-Medikation-Fachanwendung, das Datum der Erstellung und die Information, dass der Medikationsplan noch nicht gestartet wurde (*EmptyReason = notstarted*).


<div class="tabs">
<!-- Beispiel-Ressourcen-Tab -->
<div class="tab">
<input type="radio" id="tab-beispiele-1" name="tab-group-patient-journey-1" checked="true" />
<label for="tab-beispiele-1">Beispiele</label>
<div class="content-in-tab">
<ul>
<li><strong>Leerer Medikationsplan:</strong> (EmptyReason = notstarted)<ul>
<li><a href="Bundle-At-Emed-Journey-01-Bundle-Medikationsplan.html">Medikationsplan-Searchset-Bundle</a></li>
<li><a href="Patient-At-Emed-Example-Patient-01.html">Patient</a></li>
<li><a href="Device-At-Emed-Example-Device-01.html">Device</a></li>
</ul>
</li>
</ul>
</div>
</div>
<!-- Usecases-Tab -->
<div class="tab">
<input type="radio" id="tab-usecases-1" name="tab-group-patient-journey-1" />
<label for="tab-usecases-1">Use Cases</label>
<div class="content-in-tab">
<ul>
<li><a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a></li>
<li><a href="Sub_UC_eMed_03.html#sub_uc_emed_07_01---geplante-abgaben-lesen-prescription-search">Sub_UC_eMed_03 - Geplante Abgaben lesen (Prescription-Search)</a></li>
<li><a href="Sub_UC_eMed_03.html#sub_uc_emed_07_02---durchgeführte-abgaben-lesen-dispense-search">Sub_UC_eMed_03 - Durchgeführte Abgaben lesen (Dispense-Search)</a></li>
<li><a href="Sub_UC_eMed_01.html#sub_uc_emed_01_03---initial-erstellter-medikationsplan">Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan</a></li>
</ul>
</div>
</div>
</div>

<!-- Request-Response-Box Plan-Read
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-request-1-plan-read" name="tab-group-request-1-plan-read" checked="true" />
    <label for="tab-request-1-plan-read">Request</label>
    <div class="request-panel"> 
      <div class="request-code">
          <span class="request-method-post">POST</span>
          <code class="request-url">[base]/$plan-read</code>
      </div>
      <div class="request-meta">
        <strong>Headers:</strong>
        <code class="request-header">Content-Type: application/fhir+json</code>
      </div>
    </div> 
  </div>
    <div class="tab">
    <input type="radio" id="tab-response-1-plan-read" name="tab-group-request-1-plan-read" />
    <label for="tab-response-1-plan-read">Response</label>
    <div class="content-in-tab">
    TODO Beispielressource einfügen
    </div>
  </div>
</div> -->


Dr. Hausärztin erstellt zwei Medikationsplaneinträge und klärt den Patienten über die Anwendung auf: gegen die arterielle Hypertonie **Ramipril 5 mg Tabletten**, 1 x täglich morgens (Dauermedikation) und gegen den Hautausschlag **Dexpanthenol-5-%-Salbe**, 2 × täglich für 3 Wochen, dünn aufzutragen.<br>
Sie speichert den neuen Medikationsplan.

<div class="tabs">
<!-- Beispiel-Ressourcen-Tab -->
<div class="tab">
<input type="radio" id="tab-beispiele-2" name="tab-group-patient-journey-2" checked="true" />
<label for="tab-beispiele-2">Beispiele</label>
<div class="content-in-tab">
<ul>
<li><strong>Planeinträge erstellen:</strong> <ul>
<li><a href="MedicationRequest-At-Emed-Journey-02-Mr-Planeintrag-01.html">Planeintrag 1: Ramipril 5 mg Tabletten, 1 x täglich morgens (Dauermedikation)</a></li>
<li><a href="MedicationRequest-At-Emed-Journey-02-Mr-Planeintrag-02.html">Planeintrag 2: Dexpanthenol-5-%-Salbe, 2 × täglich für 3 Wochen, dünn auftragen</a></li>
</ul>
</li>
<li><strong>Medikationsplan aktualisieren:</strong><ul>
<li><a href="List-At-Emed-Journey-02-List-Medikationsplan.html">Medikationsplan ergänzt mit 2 Planeinträgen</a></li>
</ul>
</li>
<li><strong>Transaction Bundle:</strong><ul>
<li><a href="Bundle-At-Emed-Journey-02-Bundle-Tx-Medikationsplan.html">Transaction Bundle</a></li>
</ul>
</li>
</ul>
</div>
</div>
<!-- Usecases-Tab -->
<div class="tab">
<input type="radio" id="tab-usecases-2" name="tab-group-patient-journey-2" />
<label for="tab-usecases-2">Use Cases</label>
<div class="content-in-tab">
<ul>
<li><a href="Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen">Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen</a></li>
<li><a href="Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write">Sub_UC_eMed_02_01 - Medikationsplan schreiben (Plan-Write)</a>
</li>
</ul>
</div>
</div>
</div>

<!-- * **Planeinträge erstellen:** 
  * [Planeintrag 1: Ramipril 5 mg Tabletten, 1 x täglich morgens (Dauermedikation)](MedicationRequest-At-Emed-Journey-02-Mr-Planeintrag-01.html)
  * [Planeintrag 2: Dexpanthenol-5-%-Salbe, 2 × täglich für 3 Wochen, dünn auftragen](MedicationRequest-At-Emed-Journey-02-Mr-Planeintrag-02.html)
* **Medikationsplan aktualisieren:**
  * [Medikationsplan ergänzt mit 2 Planeinträgen](List-At-Emed-Journey-02-List-Medikationsplan.html)
* **Transaction Bundle:**
  * [Transaction Bundle](Bundle-At-Emed-Journey-02-Bundle-Tx-Medikationsplan.html) -->

<br>
Im aktualisierten Medikationsplan sind die neuen Planeinträge sowie das Datum der Bearbeitung und als verantwortliche Ärztin ([Dr. Hausärztin](Practitioner-At-Emed-Example-Practitioner-01.html)) ersichtlich.

Dr. Hausärztin erstellt für beide Medikamente eine *Geplante Abgabe* (Rezeptierung), sodass Herr Mustermann die Medikamente in der Apotheke abholen kann.




* **Geplante Abgaben erstellen:**
  * Beispiel [Geplante Abgabe zu Planeintrag 1 (Ramipril)](MedicationRequest-At-Emed-Journey-03-Mr-Geplante-Abgabe-01.html)
  <!-- * Beispiel [Geplante Abgabe zu Planeintrag 2 (...)](MedicationRequest-At-Emed-Journey-03-Mr-Geplante-Abgabe-02.html) -->

<br>
[![overview](plantuml/patient_journey_01.svg){: .mx-auto style="width:50%;"}](plantuml/patient_journey.svg)
<br> 

**28.2.2026: Abgabe in der Apotheke (Besorgerprozess)**

Herr Mustermann sucht eine [Apotheke](Organization-At-Emed-Example-Organization-Apo-01.html) auf, um die verordneten Medikamente abzuholen und authentifiziert sich mit seiner e-card.

Die Apothekerin ruft *Geplante, Durchgeführte Abgaben* und den *Medikationsplan* ab, und prüft die Medikation hinsichtlich Wechselwirkungen.

Sie händigt das Medikament Ramipril aus, erklärt die Einnahme und erstellt eine *Durchgeführte Abgabe*.

Die Dexpanthenol-Salbe muss noch hergestellt werden. Die Apothekerin erstellt eine *Durchgeführte Abgabe* und kennzeichnet sie entsprechend dem Besorgerprozess mit *MedicationDispense.type = FFP (First Fill – Part Fill)* und *MedicationDispense.quantity = 0*.

Anschließend speichert sie die neuen *Durchgeführte Abgaben* in der e-Medikation.

* **Durchgeführte Abgaben erstellen (Vollständige Abgabe, Besorgerprozess):**

  * Beispiel [MedicationDispense](MedicationDispense-At-Emed-Journey-05-MedicationDispense.html)

**1.3.2026: Abgabe in der Apotheke (Besorgerprozess abschließen)**

Herr Mustermann möchte in der Apotheke die Dexpanthenol-Salbe abholen und steckt seine e-card.

Die Apothekerin ruft die e-Medikation erneut. Sie übergibt dem Patienten die hergestellte Dexpanthenol-Salbe und schließt den Besorgerprozess ab, indem sie eine weitere *Durchgeführte Abgabe* erstellt. Sie dokumentiert darin die tatsächlich abgegebene Menge und kennzeichnet diese mit *MedicationDispense.type = RFC (Refill – Complete)*.

Anschließend speichert sie die neue *Durchgeführte Abgabe* in der e-Medikation.

* **Durchgeführte Abgaben erstellen (Besorgerprozess abschließen):** in Arbeit.

**2.3.2026: Patient ruft Medikationsplan ab**

Herr Mustermann erinnert sich nicht, welches Medikament er wie einnehmen soll und ruft im Zugangsportal seinen Medikationsplan auf.

<!-- Der aktuelle Medikationsplan enthält nun nur noch das **Dauermedikament Ramipril 5 mg**, während die zeitlich begrenzten Medikamente für die postoperative Behandlung bereits beendet wurden. -->

* **Aktuellen Medikationsplan anzeigen:**

  * Beispiel [Medikationsplan-Searchset-Bundle](Bundle-At-Emed-Journey-07-Bundle-Medikationsplan.html) 

**3.3.2026: Präoperativer Hausarzttermin**

Bei Herrn Mustermann steht eine geplante Leistenbruchoperation an. Vor der Operation bespricht er
die bestehende Medikation mit seiner Hausärztin.

Die geplante Leistenbruchoperation ist für den 5.3.2026 vorgesehen.
 
Dr. Hausärztin weist Herrn Mustermann an, Ramipril vor der Operation vorübergehend abzusetzen.

* **Medikationsplan mit pausiertem Planeintrag aktualisieren:** in Arbeit.
<!-- TODO -->

**5.3.2026: Geplante Leistenbruchoperation**

Herr Mustermann erscheint zur geplanten Leistenbruchoperation. Ramipril wurde entsprechend der ärztlichen Anweisung vorübergehend pausiert.

Die Leistenbruchoperation verläuft komplikationslos. Nach der Operation erhält Herr Mustermann von Dr. Krankenhaus Metamizol-Tropfen gegen die postoperativen Schmerzen.
Metamizol-Tropfen, 2 Fläschchen:
3 × täglich 30 Tropfen
für wenige Tage (nach Bedarf)

* **Medikationsplan mit neuem Planeintrag aktualisieren:** in Arbeit.

**7.3.2026: Teilabgabe in der Apotheke**

Herr Mustermann möchte in der Apotheke die Metamizol-Tropfen abholen und steckt seine e-card.

Es ist nur noch ein Fläschchen Metamizol verfügbar. Die Apothekerin händigt das Fläschchen aus und erstellt eine Durchgeführte Abgabe als Teilabgabe.
Die Patienten wird angewiesen, das zweite Fläschchen in der Apotheke abzuholen, sobald es verfügbar ist.

* **Durchgeführte Abgaben erstellen (Teilabgabe):** in Arbeit.


**9.3.2026: Teilabgabe in der Apotheke abschließen**

Herr Mustermann wurde von der Apotheke informiert, dass die Metamizol-Tropfen nun verfügbar sind. Er steckt in der Apotheke seine e-card.
Die Apothekerin ruft die e-Medikation erneut ab, schließt dann die Teilabgabe ab, indem sie eine weitere Durchgeführte Abgabe erstellt und übergibt dem Patienten die Metamizol-Tropfen.

* **Durchgeführte Abgaben erstellen (Teilabgabe abschließen):** in Arbeit.


**12.3.2026: Nachkontrolle bei der Urlaubsvertretung von Dr. Hausärztin**

Herr Mustermann hat die Medikamente in der Apotheke abgeholt und die Schmerzen sind deutlich zurückgegangen.
 
Eine Woche nach der Operation kommt er zur Nachkontrolle zur Urlaubsvertretung von Dr. Hausärztin.

Für die verbleibenden Schmerzen wird von Dr. Urlaubsvertretung die Metamizoldosis für einen begrenzten Zeitraum weiterverodnet, die Dosis aber reduziert. Metamizol-Tropfen: 2 × täglich 10 Tropfen, für 5 Tage.
 
Ramipril soll wieder eingenommen werden. 

Im neu erstellten Medikationsplan sind die neuen Planeinträge sowie das Datum der Bearbeitung und die verantwortliche Ärztin (Dr. Urlaubsvertretung) ersichtlich.

**20.3.2026: Kontrolltermin bei Dr. Hausärztin**

Herr Mustermann erscheint zur Wundkontrolle bei Dr. Hausärztin.

Die postoperative Schmerztherapie ist nicht mehr erforderlich. Der Planeintrag für Metamizol wird daher beendet.
Die Behandlung mit der Dexpanthenol-Salbe ist ebenfalls abgeschlossen.
Ramipril wird als Dauermedikation fortgeführt.

* **Planeinträge beenden und Medikationsplan aktualisieren:** in Arbeit.



<!-- <div>{ include_relative plantuml/patient_journey.svg }</div> -->

<br>
[![overview](plantuml/patient_journey.svg){: .mx-auto style="width:100%;"}](plantuml/patient_journey.svg)
<br> 



