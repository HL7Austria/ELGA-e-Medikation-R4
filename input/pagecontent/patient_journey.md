{% include styleheader.md %}

Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der **Medikationsplan** eines Patienten mit den zugehörigen **Geplanten Abgaben** und den **Durchgeführten Abgaben** verändern kann.

### Übersicht Patient Journey

<!-- TODO: nicht-sunshine-cases: patient ohne ecard in apotheke, 
Einträge durch patient löschen, stornieren, rezept wieder öffnen, wenn teilabgabe storniert -->


<!-- <div>{ include_relative plantuml/patient_journey.svg }</div> -->

<br>
[![overview](plantuml/patient_journey_overview.svg){: .mx-auto style="width:100%;"}](plantuml/patient_journey_overview.svg)
<br> 



### Journey-01: 27.2.2026 - Erster Arztbesuch

Herr Mustermann kommt wegen Kopfschmerzen und Schwindelgefühl zu seiner Hausärztin. Außerdem hat er einen leichten Hautausschlag bemerkt.

Dr. Hausärztin stellt eine leichte arterielle Hypertonie fest und ruft die e-Medikation (den aktuellen *Medikationsplan*,  *Geplante Abgaben* und *Durchgeführte Abgaben*) des Patienten  ab, um einen Überblick über seine aktuelle Medikation zu erhalten. 

Da für Herrn Mustermann noch nie ein Medikationsplan abgerufen wurde, erstellt die Fachanwendung automatisch einen leeren Medikationsplan. Darin enthalten sind die Informationen zum Patienten, die erstellende e-Medikation-Fachanwendung, das Datum der Erstellung und die Information, dass der Medikationsplan noch nicht gestartet wurde (*EmptyReason = notstarted*). 

#### Journey-01-01
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-01-01" name="tab-group-patient-journey-01-01" checked="true">
    <label for="tab-beispiele-01-01">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Leerer Medikationsplan:</strong>(EmptyReason = notstarted) 
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-01-01-Bundle-Medikationsplan.html">Medikationsplan-Bundle</a>
            </li>
            <li>
              <a href="Patient-At-Emed-Example-Patient-01.html">Patient</a>
            </li>
            <li>
              <a href="Device-At-Emed-Example-Device-01.html">Device</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-01-01" name="tab-group-patient-journey-01-01">
    <label for="tab-usecases-01-01">Use Cases</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_01---geplante-abgaben-lesen-prescription-search">Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_02---durchgeführte-abgaben-lesen-dispense-search">Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_03---initial-erstellter-medikationsplan">Sub_UC_eMed_01_03 - Initial erstellter Medikationsplan</a>
        </li>
      </ul>
    </div>
  </div>
</div>

<!-- Request-Response-Box 
Plan-Read
prescription-search
dispense-search
 -->

Dr. Hausärztin erstellt zwei Medikationsplaneinträge und klärt den Patienten über die Anwendung auf: gegen die arterielle Hypertonie **Ramipril 5 mg Tabletten**, 1 x täglich morgens (Dauermedikation) und gegen den Hautausschlag **Dexpanthenol-5-%-Salbe**, 2 × täglich für 3 Wochen, dünn aufzutragen.<br>
Sie speichert den neuen Medikationsplan.

#### Journey-01-02
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-01-02" name="tab-group-patient-journey-01-02" checked="true">
    <label for="tab-beispiele-01-02">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Planeinträge erstellen:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-01-02-Mr-Planeintrag-01.html">Planeintrag 1: Ramipril 5 mg Tabletten, 1 x täglich morgens (Dauermedikation)</a>
            </li>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-01-02-Mr-Planeintrag-02.html">Planeintrag 2: Dexpanthenol-5-%-Salbe, 2 × täglich für 3 Wochen, dünn auftragen</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Medikationsplan aktualisieren:</strong>
          <ul>
            <li>
              <a href="List-At-Emed-Journey-01-02-List-Medikationsplan.html">Medikationsplan ergänzt mit 2 Planeinträgen</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-01-02-Bundle-Medikationsplan-Tx.html">Transaction Bundle</a>
            </li>
            <li>
              <a href="Practitioner-At-Emed-Example-Practitioner-01.html">Dr. Hausärztin</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-01-02" name="tab-group-patient-journey-01-02">
    <label for="tab-usecases-01-02">Use Cases</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write">Sub_UC_eMed_02_01 - Medikationsplan schreiben (Plan-Write)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen">Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen</a>
        </li>
      </ul>
    </div>
  </div>
</div>

<!-- Request-Response-Box 
Plan-Read
prescription-search
dispense-search
 -->

Im aktualisierten Medikationsplan sind die neuen Planeinträge sowie das Datum der Bearbeitung und als verantwortliche Ärztin Dr. Hausärztin ersichtlich.

Dr. Hausärztin erstellt für beide Medikamente ein Kassenrezept (Papier oder e-Rezept) und dokumentiert den Rezeptiervorgang in einer *Geplante Abgabe* in der e-Medikation. Herr Mustermann kann nun mit dem Rezept die Medikamente in der Apotheke abholen. 

#### Journey-01-03
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-01-03" name="tab-group-patient-journey-01-03" checked="true">
    <label for="tab-beispiele-01-03">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Geplante Abgaben erstellen:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-01-03-Mr-Geplante-Abgabe-01.html">Geplante Abgabe zu Planeintrag 1 (Ramipril)</a>
            </li>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-01-03-Mr-Geplante-Abgabe-02.html">Geplante Abgabe zu Planeintrag 2 (Dexpanthenol-Salbe)</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
            <a href="Bundle-At-Emed-Journey-01-03-Bundle-Geplante-Abgaben-Tx.html">Transaction Bundle mit Geplante Abgaben</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-01-03" name="tab-group-patient-journey-01-03">
    <label for="tab-usecases-01-03">Use Cases</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <a href="Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write">Sub_UC_eMed_04_01 - Geplante Abgabe erstellen (Prescription-Write)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_04.html#variante-a-vorab-ermittlung-des-e-med-groupidentifiers-groupidentifier-create">Sub_UC_eMed_04_02 - e-Med GroupIdentifier beziehen (Variante A)</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Ablauf Erstbesuch
<br>
[![overview](plantuml/patient_journey_01.svg){: .mx-auto style="width:60%;"}](plantuml/patient_journey_01.svg)
<br> 

### Journey-02: 28.2.2026 - Abgabe in der Apotheke (Teil 1)

Herr Mustermann sucht eine Apotheke auf, um die verordneten Medikamente abzuholen und legt dazu seine e-card vor, wodurch die Apotheke Zugriff auf seine ELGA e-Medikation erhält.

Die Apothekerin prüft das Rezept (Papierrezept oder ruft e-Rezept ab), ruft offenen *Geplante Abgaben*, sowie *Durchgeführte Abgaben* und den *Medikationsplan* ab und prüft die Medikation hinsichtlich Wechselwirkungen. 

Sie händigt das Medikament Ramipril aus, erklärt die Einnahme und erstellt eine *Durchgeführte Abgabe* (**Vollständige Abgabe**).

Die Dexpanthenol-Salbe muss noch hergestellt werden. Die Apothekerin erstellt eine Durchgeführte Abgabe mit dem *Type = "First Fill – Part Fill"* und der abgegebenen Menge (*quantity*) Null. 

Die Dexpanthenol-Salbe muss noch hergestellt werden. Die Apothekerin erstellt eine *Durchgeführte Abgabe* und dokumentiert darin entsprechend dem **Besorgerprozess** *type = First Fill – Part Fill* und *MedicationDispense.quantity = 0*.

Anschließend speichert sie die neuen *Durchgeführte Abgaben* in der e-Medikation. Da für Ramipril keine weitere Einlösung möglich ist (Kassenrezept), wird die zugehörige *Geplante Abgabe* automatisch abgeschlossen (*completed*).

#### Journey-02
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-02-01" name="tab-group-patient-journey-02-01" checked="true">
    <label for="tab-beispiele-02-01">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Durchgeführte Abgaben erstellen:</strong>
          <ul>
            <li>
              <a href="MedicationDispense-At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-01.html">Durchgeführte Abgabe (Ramipril)</a> (Vollständige Einzelabgabe)
            </li>
            <li>
              <a href="MedicationDispense-At-Emed-Journey-02-01-Md-Durchgefuehrte-Abgabe-02.html">Durchgeführte Abgabe (Dexpanthenol-Salbe)</a> (Besorgerprozess)
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-02-01-Bundle-Durchgefuehrte-Abgaben-Tx.html">Durchgeführte-Abgaben-Transaction-Bundle</a>
            </li>
            <li>
              <a href="Organization-At-Emed-Example-Organization-Apo-01.html">Apotheke (Organization)</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-02-01" name="tab-group-patient-journey-02-01">
    <label for="tab-usecases-02-01">Use Cases</label>
    <div class="content-in-tab">
      <ul>
      <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_01---geplante-abgaben-lesen-prescription-search">Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_02---durchgeführte-abgaben-lesen-dispense-search">Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_05.html#zugriffsvariante-a-durchgeführte-abgabe-mit-kontakt-schreiben">Sub_UC_eMed_05_01 - Durchgeführte Abgabe schreiben (Dispense-Write)(Variante A: Zugriff mit Kontakt)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_05.html#sub_uc_emed_05_01_01---vollständige-einzelabgabe-erfassen">Sub_UC_eMed_05_01_01 - Vollständige Einzelabgabe erfassen</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_05.html#sub_uc_emed_05_01_03---besorgerprozess">Sub_UC_eMed_05_01_03 - Besorgerprozess</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Ablauf Abgabe in der Apotheke (Teil 1)

<br>
[![overview](plantuml/patient_journey_02.svg){: .mx-auto style="width:60%;"}](plantuml/patient_journey_02.svg)
<br> 

### Journey-03: 1.3.2026 - Abgabe in der Apotheke (Teil 2)

Herr Mustermann möchte in der Apotheke die Dexpanthenol-Salbe abholen und steckt dort seine e-card.

Die Apothekerin ruft die e-Medikation erneut ab. 
Sie erhält den *Medikationsplan*, die offene *Geplante Abgabe* für die Dexpanthenol-Salbe und die zugehörige *Durchgeführte Abgabe*, mit der der Besorgerprozess dokumentiert wurde.
Sie übergibt dem Patienten die fertiggestellte Dexpanthenol-Salbe und schließt den Besorgerprozess ab, indem sie eine weitere *Durchgeführte Abgabe* erstellt. Sie dokumentiert darin die tatsächlich abgegebene Menge und kennzeichnet diese mit *MedicationDispense.type = RFC (Refill – Complete)*.

Anschließend speichert sie die neue *Durchgeführte Abgabe* in der e-Medikation. Da für die Dexpanthenol-Salbe keine weitere Einlösung möglich ist (Kassenrezept), wird die zugehörige *Geplante Abgabe* automatisch abgeschlossen (*completed*).

#### Journey-03

<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-03-01" name="tab-group-patient-journey-03-01" checked="true">
    <label for="tab-beispiele-03-01">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Durchgeführte Abgaben erstellen:</strong>
          <ul>
            <li>
              <a href="MedicationDispense-At-Emed-Journey-03-01-Md-Durchgefuehrte-Abgabe-02.html">Durchgeführte Abgabe (Dexpanthenol-Salbe)</a> (Besorgerprozess beenden) 
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-03-01-Bundle-Durchgefuehrte-Abgaben-Tx.html">Transaction Bundle mit Durchgeführter Abgabe</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-03-01" name="tab-group-patient-journey-03-01">
    <label for="tab-usecases-03-01">Use Cases</label>
    <div class="content-in-tab">
      <ul>
      <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_01---geplante-abgaben-lesen-prescription-search">Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_02---durchgeführte-abgaben-lesen-dispense-search">Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_05.html#zugriffsvariante-a-durchgeführte-abgabe-mit-kontakt-schreiben">Sub_UC_eMed_05_01 - Durchgeführte Abgabe schreiben (Dispense-Write)(Variante A: Zugriff mit Kontakt)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_05.html#sub_uc_emed_05_01_03---besorgerprozess">Sub_UC_eMed_05_01_03 - Besorgerprozess</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Ablauf Abgabe in der Apotheke (Teil 2)

<br>
[![overview](plantuml/patient_journey_03.svg){: .mx-auto style="width:60%;"}](plantuml/patient_journey_03.svg)
<br> 

### Journey-04: 7.3.2026 - Patient ruft Medikationsplan ab

Herr Mustermann erinnert sich nicht, wie lange er die Dexpanthenol-Salbe anwenden soll. Er ruft im Zugangsportal seine e-Medikation auf und erhält Einsicht auf seinen aktuellen *Medikationsplan* mit den Planeinträgen zur Dauermedikation Ramipril und der Dexpanthenol-Salbe. Dem Planeintrag der Dexpanthenol-Salbe kann er entnehmen, dass die Salbe für 3 Wochen anzuwenden ist.
Er kann auch sehen, dass er keine offenen *Geplanten Abgaben* hat und sieht in den *Durchgeführten Abgaben*, wann er die Arzneimittel abgeholt hat


#### Journey-04

<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-04-01" name="tab-group-patient-journey-04-01" checked="true">
    <label for="tab-beispiele-04-01">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>aktueller Medikationsplan:</strong>
          <ul>
            <li>Bundle in Arbeit. 
            </li>
          </ul>
        </li>
        <li>
          <strong>Gepante Abgaben:</strong>
          <ul>
            <li>Bundle in Arbeit.
            </li>
          </ul>
        </li>
        <li>
          <strong>Durchgeführte Abgaben:</strong>
          <ul>
            <li>Bundle in Arbeit.
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-04-01" name="tab-group-patient-journey-04-01">
    <label for="tab-usecases-04-01">Use Cases</label>
    <div class="content-in-tab">
      <ul>
      <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_01---geplante-abgaben-lesen-prescription-search">Sub_UC_eMed_03_01 - Geplante Abgaben lesen (Prescription-Search)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_03.html#sub_uc_emed_07_02---durchgeführte-abgaben-lesen-dispense-search">Sub_UC_eMed_03_02 - Durchgeführte Abgaben lesen (Dispense-Search)</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Ablauf Patient ruft Medikationsplan ab

<br>
[![overview](plantuml/patient_journey_04.svg){: .mx-auto style="width:50%;"}](plantuml/patient_journey_04.svg)
<br> 


### Journey-05: 14.3.2026 - Präoperativer Hausarzttermin

Bei Herrn Mustermann steht eine geplante Leistenbruchoperation an, welche für den 24.3.2026 vorgesehen ist.

Vor der Operation bespricht er die bestehende Medikation mit seiner Hausärztin, welche seine aktuelle e-Medikation abruft.

Die geplante Leistenbruchoperation ist für den 24.3.2026 vorgesehen.
 
Dr. Hausärztin weist Herrn Mustermann an, Ramipril vor der Operation vorübergehend abzusetzen und pausiert den Planeintrag.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Möglichkeit prüfen, wie der Usecase: "Medikament soll in 2 Wochen für 1 Woche pausiert werden", umgesetzt werden kann. Ein zukünftiger, zeitgesteuerter Statuswechsel auf on-hold ist nicht möglich.
</p>
</div>

* **Medikationsplan mit pausiertem Planeintrag aktualisieren:** in Arbeit.
<!-- TODO -->
<!-- 20.3.: Salbe stopped setzen und dragon box: welches datum ist ausschlaggebend? planeintrag oder durchgeführte abgabe (medikament kann auch später abgeholt worden sein, einnahme wurde daher später begonnen, als im planeintrag vorgesehen) -->

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





