{% include styleheader.md %}

Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der **Medikationsplan** eines Patienten mit den zugehörigen **Geplanten Abgaben** und den **Durchgeführten Abgaben** verändern kann.

Eine fachliche Übersicht mit reduziertem Detailgrad findet sich am Ende dieses Kapitels [Übersicht Patient Journey](patient_journey.html#übersicht-patient-journey).

<!-- TODO: nicht-sunshine-cases: patient ohne ecard in apotheke, 
Einträge durch patient löschen, stornieren, rezept wieder öffnen, wenn teilabgabe storniert -->


### Journey-01: 27.2.2026 - Erster Arztbesuch

Herr Mustermann kommt wegen Kopfschmerzen und Schwindelgefühl zu seiner Hausärztin. Außerdem hat er einen leichten Hautausschlag bemerkt.

#### Journey-01-01:

Dr. Hausärztin stellt eine leichte arterielle Hypertonie fest und ruft die e-Medikation (den aktuellen *Medikationsplan*,  *Geplante Abgaben* und *Durchgeführte Abgaben*) des Patienten ab, um einen Überblick über seine aktuelle Medikation zu erhalten. 

Da für Herrn Mustermann noch nie ein Medikationsplan abgerufen wurde, erstellt die Fachanwendung automatisch einen leeren Medikationsplan. Darin enthalten sind die Informationen zum Patienten, die erstellende e-Medikation-Fachanwendung, das Datum der Erstellung und die Information, dass der Medikationsplan noch nicht gestartet wurde (*EmptyReason = notstarted*). 

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

##### Journey-01-01: Request 01 - Medikationsplan abrufen
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-request-journey-01-01-01" name="tab-group-journey-01-01-01" checked="true" />
    <label for="tab-request-journey-01-01-01" class="request-tab">Request</label>
    <div class="content-in-tab">
      <div class="request-panel">
        <div class="request-code">
          <span class="request-method-post">POST</span>
          <code class="request-url">[base]/List/$plan-read</code>
        </div>
        <div class="request-meta">
          <strong>Headers:</strong>
          <code class="request-header">Content-Type: application/fhir+json</code>
        </div>
      </div>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-request-body-journey-01-01-01" name="tab-group-journey-01-01-01" />
    <label for="tab-request-body-journey-01-01-01">Request Body</label>
    <div class="content-in-tab">{% fragment Parameters/Journey-01-01-Request-Body-01 JSON %}</div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-response-journey-01-01-01" name="tab-group-journey-01-01-01" />
    <label for="tab-response-journey-01-01-01">Response Body</label>
    <div class="content-in-tab">{% fragment Bundle/At-Emed-Journey-01-01-01-Bundle-Medikationsplan JSON %}</div>
  </div>
</div>


##### Journey-01-01: Request 02 - geplante Abgaben Abrufen
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-request-journey-01-01-02" name="tab-group-journey-01-01-02" checked="true" />
    <label for="tab-request-journey-01-01-02" class="request-tab">Request</label>
    <div class="content-in-tab">
      <div class="request-panel">
        <div class="request-code">
          <span class="request-method-get">GET</span>
          <code class="request-url">[base]/MedicationRequest?category=https://fhir.hl7.at/elga/emed/r4/CodeSystem/MedicationRequestCategoryCS|2&amp;status=active</code>
        </div>
        <div class="request-meta">
          <strong>Headers:</strong>
          <code class="request-header">Content-Type: application/fhir+json</code>
        </div>
      </div>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-response-journey-01-01-02" name="tab-group-journey-01-01-02" />
    <label for="tab-response-journey-01-01-02">Response Body</label>
    <div class="content-in-tab">{% fragment Bundle/at-emed-journey-01-01-02-bundle-geplanteAbgaben JSON %}</div>
  </div>
</div>

##### Journey-01-01: Request 03 - durchgeführte Abgaben Abrufen

<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-request-journey-01-01-03" name="tab-group-journey-01-01-03" checked="true" />
    <label for="tab-request-journey-01-01-03" class="request-tab">Request</label>
    <div class="content-in-tab">
      <div class="request-panel">
        <div class="request-code">
          <span class="request-method-get">GET</span>
          <code class="request-url">[base]/MedicationDispense?recorded=lt2025-01-01</code>
        </div>
        <div class="request-meta">
          <strong>Headers:</strong>
          <code class="request-header">Content-Type: application/fhir+json</code>
        </div>
      </div>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-response-journey-01-01-03" name="tab-group-journey-01-01-03" />
    <label for="tab-response-journey-01-01-03">Response Body</label>
    <div class="content-in-tab">{% fragment Bundle/at-emed-journey-01-01-03-bundle-durchgefuehrte-abgaben JSON %}</div>
  </div>
</div>



#### Journey-01-02

Dr. Hausärztin erstellt zwei Medikationsplaneinträge und klärt den Patienten über die Anwendung auf: gegen die arterielle Hypertonie **Ramipril 5 mg Tabletten**, 1 x täglich morgens (Dauermedikation) und gegen den Hautausschlag **Dexpanthenol-5-%-Salbe**, 2 × täglich für 3 Wochen, dünn aufzutragen.<br>
Sie speichert den neuen Medikationsplan.

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
              <a href="Practitioner-At-Emed-Example-PractitionerRole-01.html">Dr. Hausärztin</a>
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

#### Journey-01-03

Dr. Hausärztin erstellt für beide Medikamente ein Kassenrezept (Papier oder e-Rezept) und dokumentiert den Rezeptiervorgang in einer *Geplante Abgabe* in der e-Medikation. Herr Mustermann kann nun mit dem Rezept die Medikamente in der Apotheke abholen. 

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

#### Journey-01: Ablauf - Erster Arztbesuch
<br>
[![overview](plantuml/patient_journey_01.svg){: .mx-auto style="width:50%;"}](plantuml/patient_journey_01.svg)
<br> 

### Journey-02: 28.2.2026 - Abgabe in der Apotheke (Teil 1)

Herr Mustermann sucht eine Apotheke auf, um die verordneten Medikamente abzuholen und legt dazu seine e-card vor, wodurch die Apotheke Zugriff auf seine ELGA e-Medikation erhält.

Die Apothekerin prüft das Rezept (Papierrezept oder ruft e-Rezept ab), ruft offenen *Geplante Abgaben*, sowie *Durchgeführte Abgaben* und den *Medikationsplan* ab und prüft die Medikation hinsichtlich Wechselwirkungen. 

Sie händigt das Medikament Ramipril aus, erklärt die Einnahme und erstellt eine *Durchgeführte Abgabe* (**Vollständige Abgabe**).

Die Dexpanthenol-Salbe muss noch hergestellt werden. Die Apothekerin erstellt eine *Durchgeführte Abgabe* und dokumentiert darin den **Besorgerprozess** *type = First Fill – Part Fill* und abgegebene Menge *quantity = 0*.

Anschließend speichert sie die neuen *Durchgeführte Abgaben* in der e-Medikation. Da für Ramipril keine weitere Einlösung möglich ist (Kassenrezept), wird die zugehörige *Geplante Abgabe* automatisch abgeschlossen (*completed*).

<!-- #### Journey-02 -->

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
              <a href="Organization-At-Emed-Example-Organization-02.html">Apotheke (Organization)</a>
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

#### Journey-02: Ablauf - Abgabe in der Apotheke (Teil 1)

<br>
[![overview](plantuml/patient_journey_02.svg){: .mx-auto style="width:60%;"}](plantuml/patient_journey_02.svg)
<br> 

### Journey-03: 1.3.2026 - Abgabe in der Apotheke (Teil 2)

Herr Mustermann möchte in der Apotheke die Dexpanthenol-Salbe abholen und steckt dort seine e-card.

Die Apothekerin ruft die e-Medikation erneut ab. 
Sie erhält den *Medikationsplan*, die offene *Geplante Abgabe* für die Dexpanthenol-Salbe und die zugehörige *Durchgeführte Abgabe*, mit der der Besorgerprozess dokumentiert wurde.
Sie übergibt dem Patienten die fertiggestellte Dexpanthenol-Salbe und schließt den Besorgerprozess ab, indem sie eine weitere *Durchgeführte Abgabe* erstellt. Sie dokumentiert darin die tatsächlich abgegebene Menge und kennzeichnet diese mit *MedicationDispense.type = RFC (Refill – Complete)*.

Anschließend speichert sie die neue *Durchgeführte Abgabe* in der e-Medikation. Da für die Dexpanthenol-Salbe keine weitere Einlösung möglich ist (Kassenrezept), wird die zugehörige *Geplante Abgabe* automatisch abgeschlossen (*completed*).

<!-- #### Journey-03 -->

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

#### Journey-03: Ablauf - Abgabe in der Apotheke (Teil 2)

<br>
[![overview](plantuml/patient_journey_03.svg){: .mx-auto style="width:60%;"}](plantuml/patient_journey_03.svg)
<br> 

### Journey-04: 7.3.2026 - Patient ruft Medikationsplan ab

Herr Mustermann erinnert sich nicht, wie lange er die Dexpanthenol-Salbe anwenden soll. Er ruft im Zugangsportal seine e-Medikation auf und erhält Einsicht auf seinen aktuellen *Medikationsplan* mit den Planeinträgen zur Dauermedikation Ramipril und der Dexpanthenol-Salbe. Dem Planeintrag mit der Dexpanthenol-Salbe kann er entnehmen, dass die Salbe für 3 Wochen anzuwenden ist.
Er kann auch sehen, dass er keine offenen *Geplanten Abgaben* hat und sieht in den *Durchgeführten Abgaben*, wann er die Arzneimittel abgeholt hat


<!-- #### Journey-04 -->

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
          <strong>Geplante Abgaben:</strong>
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

#### Journey-04: Ablauf - Patient ruft Medikationsplan ab

<br>
[![overview](plantuml/patient_journey_04.svg){: .mx-auto style="width:45%;"}](plantuml/patient_journey_04.svg)
<br> 


### Journey-05: 14.3.2026 - Präoperativer Arzttermin

Bei Herrn Mustermann steht am 24.3.2026 eine geplante Leistenbruchoperation an. Für die Operationsfreigabe geht er zu seiner Hausärztin. Diese überprüft dahingehend auch die bestehende Medikation und ruft seine aktuelle e-Medikation ab (für Abruf *Geplante Abgaben* und *Durchgeführte Abgaben*, siehe [Journey-04](patient_journey.html#journey-04-ablauf---patient-ruft-medikationsplan-ab)).
 
Dr. Hausärztin weist Herrn Mustermann an, Ramipril vor der Operation vorübergehend abzusetzen, um das Risiko einer intraoperativen Hypotonie zu reduzieren. Er pausiert den Planeintrag und dokumentiert als Begründung die geplante Operation (*statusReason = "surg"*).

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Möglichkeit prüfen, wie der Usecase: "Medikament soll in 2 Wochen für 1 Woche pausiert werden", umgesetzt werden kann. Ein zukünftiger, zeitgesteuerter Statuswechsel auf on-hold ist nicht möglich.
</p>
</div>


<!-- TODO Plan Read Bundle akl 21.9.2026 -->

<!-- 20.3.: Salbe stopped setzen und dragon box: welches datum ist ausschlaggebend? planeintrag oder durchgeführte abgabe (medikament kann auch später abgeholt worden sein, einnahme wurde daher später begonnen, als im planeintrag vorgesehen) -->


#### Journey-05-01
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-05-01" name="tab-group-patient-journey-05-01" checked="true">
    <label for="tab-beispiele-05-01">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Planeintrag pausieren:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-05-01-Mr-Planeintrag-01.html">Planeintrag 1: Ramipril (Dauermedikation) pausieren</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Medikationsplan aktualisieren:</strong>
          <ul>
            <li>
              <a href="List-At-Emed-Journey-05-01-List-Medikationsplan.html">Medikationsplan: 1 Planeintrag aktualisiert, 1 Planeintrag unverändert</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-05-01-Bundle-Medikationsplan-Tx.html">Transaction Bundle</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-05-01" name="tab-group-patient-journey-05-01">
    <label for="tab-usecases-05-01">Use Cases</label>
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
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_05---planeintrag-pausieren-oder-reaktivieren">Sub_UC_eMed_02_05 - Planeintrag pausieren oder reaktivieren</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_04---planeintrag-im-medikationsplan-beibehalten">Sub_UC_eMed_02_04 - Planeintrag im Medikationsplan beibehalten</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Journey-05: Ablauf - Präoperativer Arzttermin

<br>
[![overview](plantuml/patient_journey_05.svg){: .mx-auto style="width:45%;"}](plantuml/patient_journey_05.svg)
<br> 

### Journey-06: 17.3.2026 bis 21.3.2026 - Stationärer Krankenhausaufenthalt

#### Journey-06-01: 17.3.2026 - Geplante Operation

Herr Mustermann erscheint zur geplanten Leistenbruchoperation. Im Krankenhaus wird bei der OP-Besprechung sein Medikationsplan abgerufen und nachgefragt, ob der Patient gemäß Medikationsplan die Einnahme von Ramipril vorübergehend pausiert hat. Dieser bejaht das. 

Die Operation verläuft komplikationslos.

<!-- TODO Plan-Read Bundle  akl 21.9.2026 -->

#### Journey-06-02: 19.3.2026 - Entlassung

Zwei Tage nach der Operation kann Herr Mustermann entlassen werden. Gegen die postoperativen Schmerzen soll er weiterhin den **Wirkstoff** Metamizol einnehmen. Dr. Krankenhaus dokumentiert dies in einem neuen Planeintrag: Metamizol 1.000 mg, 4x täglich. <!-- > TODO: im Abstand von 6–8 Stunden -->

Zusätzlich wird die pausierte Ramipril Medikation wieder aufgenommen, aber in der Dosis erhöht (auf 1-0-1-0). 

<!-- TODO Plan-Read Bundle  akl 21.9.2026 -->


#### Journey-06-02
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-06-02" name="tab-group-patient-journey-06-02" checked="true">
    <label for="tab-beispiele-06-02">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Planeintrag hinzufügen:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-06-02-Mr-Planeintrag-03.html">Neuer Planeintrag 3: Wirstoff Metamizol (in Arbeit)</a>  <!-- TODO: Wirkstoffangabe sobald Profil verfügbar, akl 22.9.2026 -->
            </li>
          </ul>
        </li>
                <li>
          <strong>Planeintrag anpassen:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-06-02-Mr-Planeintrag-03.html">Neuer Planeintrag 1: Ramipril aktivieren + Dosierung ändern</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Medikationsplan aktualisieren:</strong>
          <ul>
            <li>
              <a href="List-At-Emed-Journey-06-02-List-Medikationsplan.html">Medikationsplan: 1 Planeintrag neu hinzugefügt, 2 Planeinträge unverändert</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-06-02-Bundle-Medikationsplan-Tx.html">Transaction Bundle</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-06-02" name="tab-group-patient-journey-06-02">
    <label for="tab-usecases-06-02">Use Cases</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_02_02 - Planeintrag in Medikationsplan hinzufügen">Sub_UC_eMed_02.html#sub_uc_emed_02_02---planeintrag-in-medikationsplan-hinzufügen</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern">Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern</a>
        </li>
        <li>
        Referenz auf Wirkstoffangabe im Medikationsplan: in Arbeit.  <!-- TODO Kapitel akl 21.9.2026 -->
        </li>
        <li>
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_04---planeintrag-im-medikationsplan-beibehalten">Sub_UC_eMed_02_04 - Planeintrag im Medikationsplan beibehalten</a>
        </li>
      </ul>
    </div>
  </div>
</div>

#### Journey-06: Ablauf - Stationärer Krankenhausaufenthalt

<br>
[![overview](plantuml/patient_journey_06.svg){: .mx-auto style="width:55%;"}](plantuml/patient_journey_06.svg)
<br> 



### Journey-07: 22.3.2026 - Termin bei Dr. Urlaubsvertretung

Nach der Entlassung sucht Herr Mustermann die Praxis seiner Hausärztin auf, um sich für das Schermzmittel ein Rezept ausstellen zu lassen.
Diese wird aktuell von Frau **Dr. Urlaubsvertretung** vertreten.
Dr. Urlaubsvertretung ruft die e-Medikation von Herrn Mustermann ab und ändert den Planeintrag mit der Wirkstoffangabe und Dosierung auf das entsprechende Arzneimttelprodukt mit passender Dosierung: Metagelan 500 mg/ml-Tropfen, 40 Tropfen 4-mal täglich.

Der Behandlungszeitraum für die Dexpanthenol-Salbe ist zwischenzeitlich **abgelaufen**. Dr. Urlaubsvertretung stellt fest, dass keine weitere Behandung nötig ist, der im Medikationsplan von der Fachanwendung zur Entfernung markierte Planeintrag wird durch die Aktualisierung des Medikationsplans bestätigt und wird beim nächsten Abruf nicht mehr aufscheinen.

Zuletzt erstellt Dr. Urlaubsvertretung eine *Geplante Abgabe* von die Metagelan-Tropfen.

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
Wie wird von der Fachanwendung festgestellt, ob ein Behandlungszeitraum abgelaufen ist? <br>
- extension[effectiveDosePeriod].valuePeriod.start + Dosierinformationen (für 3 Wochen) <br>
- überschrittenes Datum in extension[effectiveDosePeriod].valuePeriod.end <br>
-> bei beiden Varianten unklar, wann das Medikament abgeholt bzw. die Behandlung wirklich begonnen wurde (Abholdatum geht nur aus MediacationDispense hervor)
</p>
</div>

<!-- TODO: akl 22.09.2026 Geplante Abgabe erstellen -->


#### Journey-07-01
<div class="tabs">
  <div class="tab">
    <input type="radio" id="tab-beispiele-07-01" name="tab-group-patient-journey-07-01" checked="true">
    <label for="tab-beispiele-07-012">Beispiele</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <strong>Planeintrag anpassen:</strong>
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-07-01-Mr-Planeintrag-03.html">Neuer Planeintrag 3: passendes Arzneimittel zur Wirkstoffeangabe verodnen</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>abgelaufenen Planeintrag bestätigen:</strong> (keine Änderung erforderlich)
          <ul>
            <li>
              <a href="MedicationRequest-At-Emed-Journey-07-01-Mr-Planeintrag-02.html">Neuer Planeintrag 2: Statusänderung wurde bereits durch Fachanwendung vorgenommen</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Medikationsplan aktualisieren:</strong>
          <ul>
            <li>
              <a href="List-At-Emed-Journey-07-01-List-Medikationsplan.html">Medikationsplan: Planeintrag 1 unverändert, Planeintrag 2 abgelaufen, Planeintrag 3: Wirkstoffangabe mit Arzneimittel ersetzt</a>
            </li>
          </ul>
        </li>
        <li>
          <strong>Transaction Bundle:</strong>
          <ul>
            <li>
              <a href="Bundle-At-Emed-Journey-07-01-Bundle-Medikationsplan-Tx.html">Transaction Bundle</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="tab">
    <input type="radio" id="tab-usecases-07-01" name="tab-group-patient-journey-07-01">
    <label for="tab-usecases-07-01">Use Cases</label>
    <div class="content-in-tab">
      <ul>
        <li>
          <a href="Sub_UC_eMed_01.html#sub_uc_emed_01_01---aktuellen-medikationsplan-lesen-plan-read">Sub_UC_eMed_01_01 - Aktuellen Medikationsplan lesen (Plan-Read)</a>
        </li>
        <li>
          <a href="Sub_UC_eMed_02_03 - Planeintrag im Medikationsplan ändern">Sub_UC_eMed_02.html#sub_uc_emed_02_03---planeintrag-im-medikationsplan-ändern</a>
        </li>
        <li>
        Abgelaufener Planeintrag: zu verlinken.  <!-- TODO Kapitel akl 21.9.2026 -->
        </li>
        <li>
          <a href="Sub_UC_eMed_02.html#sub_uc_emed_02_04---planeintrag-im-medikationsplan-beibehalten">Sub_UC_eMed_02_04 - Planeintrag im Medikationsplan beibehalten</a>
        </li>
      </ul>
    </div>
  </div>
</div>




#### Journey-07: Ablauf - Termin bei Dr. Urlaubsvertretung

<br>
[![overview](plantuml/patient_journey_07.svg){: .mx-auto style="width:55%;"}](plantuml/patient_journey_07.svg)
<br> 

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


### Übersicht Patient Journey

<!-- TODO: nicht-sunshine-cases: patient ohne ecard in apotheke, 
Einträge durch patient löschen, stornieren, rezept wieder öffnen, wenn teilabgabe storniert -->


<!-- <div>{ include_relative plantuml/patient_journey.svg }</div> -->

<br>
[![overview](plantuml/patient_journey_overview.svg){: .mx-auto style="width:100%;"}](plantuml/patient_journey_overview.svg)
<br> 


