Am Beispiel einer fiktiven Patient Journey wird veranschaulicht, wie sich der Medikationsplan eines Patienten mit den zugehörigen **Geplanten Abgaben** und den **Durchgeführten Abgaben** verändern kann.
<!-- 
**### 27.2.2026: Arztbesuch**

Dr. Musterärztin möchte für ihren Patienten Max Mustermann den aktuellen Medikationsplan abrufen, um einen Überblick über seine bestehende Medikation zu erhalten [^1].

[^1]: [Sub_UC_eMed_01_01 - Medikationsplan lesen - Plan-Read](Sub_UC_eMed_01.html#plan-read)

Da für Herrn Mustermann noch nie ein Medikationsplan abgerufen wurde, erstellt die Fachanwendung automatisch einen leeren Medikationsplan. Darin enthalten sind die Informationen zum [Patienten](Patient-At-Emed-Example-Patient-01.html), die erstellende e-Medikation-Fachanwendung ([Device](Device-At-Emed-Example-Device-01.html)), das Datum der Erstellung und die Information, dass der Medikationsplan noch nicht gestartet wurde (*EmptyReason = notstarted*).

* ****Leerer Medikationsplan:****

  * [Collection Bundle](Bundle-At-Emed-Journey-01-Bundle-Medikationsplan.html)

Bei Herrn Mustermann besteht eine leichte arterielle Hypertonie, die mit **Ramipril 5 mg Tabletten** behandelt wird. Dr. Musterärztin ergänzt das Dauermedikament in den Medikationsplan. Herr Mustermann soll morgens eine Tablette einnehmen.

Weiters verschreibt sie ihm aufgrund einer akuten, schmerzhaften Entzündung **Metamizol-Tropfen**. Herr Mustermann soll zunächst dreimal täglich 30 Tropfen einnehmen. Die Einnahme ist nur für die Dauer der akuten Beschwerden vorgesehen.

Zusätzlich verordnet sie **Ibuprofen 400 mg Tabletten**, die Herr Mustermann bei Bedarf gegen stärkere Schmerzen einnehmen kann. Auch diese Medikation ist nur für einen begrenzten Zeitraum vorgesehen.

Für die anschließende Behandlung einer gereizten Hautstelle verschreibt Dr. Musterärztin außerdem eine **magistrale Dexpanthenol-5-%-Salbe**. Herr Mustermann soll die Salbe für eine Woche zweimal täglich dünn auf die betroffene Stelle auftragen.

Sie speichert den neuen Medikationsplan.

* ****Medikationsplaneinträge hinzufügen:****

  * [Transaction Bundle](Bundle-At-Emed-Journey-02-Bundle-Tx-Medikationsplan.html)

Im neu erstellten Medikationsplan sind die neuen Planeinträge sowie das Datum der Bearbeitung und als verantwortliche Ärztin Dr. Musterärztin ([Practitioner 1](Practitioner-At-Emed-Example-Practitioner-01.html)) ersichtlich.

Für die Medikamente, die über eine Apotheke abgegeben werden sollen, erstellt Dr. Musterärztin die entsprechenden *Geplanten Abgaben*.

* ****Geplante Abgaben erstellen:****

  * Beispiel [MedicationRequest](MedicationRequest-At-Emed-Journey-03-Mr-Geplante-Abgabe.html)

**### 3.3.2026: Akute Blinddarmoperation**

Wenige Tage später muss Herr Mustermann aufgrund einer akuten Blinddarmentzündung kurzfristig operiert werden.

Vor der Operation wird festgestellt, dass Herr Mustermann Ramipril als Dauermedikation einnimmt. Das Medikament wird im Zusammenhang mit der Operation vorübergehend pausiert.

Nach der Operation werden die akuten Schmerzen mit Metamizol-Tropfen und Ibuprofen-Tabletten behandelt. Die Medikamente sind nur für die postoperative Schmerztherapie vorgesehen.

Die vorübergehende Pause des Ramiprils sowie die postoperative Medikation werden im Medikationsplan berücksichtigt.

**### 4.3.2026: Entlassung aus dem Krankenhaus**

Nach unkompliziertem Verlauf wird Herr Mustermann aus dem Krankenhaus entlassen.

Der behandelnde Krankenhausarzt, Dr. Beispielarzt ([Practitioner 2](Practitioner-At-Emed-Example-Practitioner-02.html)), ruft den aktuellen Medikationsplan ab.

Er stellt fest, dass die Schmerzen bereits deutlich zurückgegangen sind. Daher passt er die Dosierung der Metamizol-Tropfen an. Herr Mustermann soll nun nur noch **dreimal täglich 20 Tropfen** einnehmen.

Das Ramipril soll nach der Operation wieder wie gewohnt **morgens 5 mg** eingenommen werden.

Dr. Beispielarzt speichert die Änderungen im Medikationsplan.

* ****Medikationsplaneinträge ändern:****

  * Beispiel [Transaction Bundle](Bundle-At-Emed-Journey-04-Bundle-Tx-Medikationsplan.html)

Im neuen Medikationsplan ist nun Dr. Beispielarzt als verantwortlicher Arzt der Änderung ersichtlich.

**### 5.3.2026: Abgabe in der Apotheke**

Herr Mustermann sucht eine [Apotheke](Organization-At-Emed-Example-Organization-Apo-01.html) auf, um die verordneten Medikamente abzuholen.

Die Apotheke identifiziert den Patienten und ruft die geplanten Abgaben ab.

Da die Medikamente verfügbar sind, erstellt der Apotheker die entsprechenden **Durchgeführten Abgaben** und händigt Herrn Mustermann die Medikamente aus.

Für die magistrale Dexpanthenol-Salbe wird zunächst eine **Durchgeführte Abgabe** mit *MedicationDispense.type = FFP (First Fill – Part Fill)* und *MedicationDispense.quantity = 0* erstellt, da die Zubereitung erst hergestellt werden muss.

* ****Durchgeführte Abgaben:****

  * Beispiel [MedicationDispense](MedicationDispense-At-Emed-Journey-05-MedicationDispense.html)

**### 6.3.2026: Abholung der magistralen Zubereitung**

Herr Mustermann sucht die Apotheke erneut auf.

Die magistrale Dexpanthenol-Salbe wurde inzwischen hergestellt. Der Apotheker erstellt eine weitere **Durchgeführte Abgabe**, dokumentiert die tatsächlich abgegebene Menge und kennzeichnet diese mit *MedicationDispense.type = RFC (Refill – Complete)*.

Die Salbe wird Herrn Mustermann ausgehändigt.

**### 12.3.2026: Kontrolltermin**

Herr Mustermann erscheint zur Kontrolle bei Dr. Musterärztin. Sie ruft den aktuellen Medikationsplan ab.

Die postoperative Schmerztherapie ist nicht mehr erforderlich. Dr. Musterärztin beendet daher die Einträge für Metamizol-Tropfen und Ibuprofen-Tabletten.

Das Ramipril wird weiterhin als Dauermedikation mit **5 mg morgens** fortgeführt.

Die magistrale Dexpanthenol-Salbe wurde wie vorgesehen eine Woche lang angewendet und wird ebenfalls beendet.

Dr. Musterärztin nimmt die entsprechenden Änderungen in den Medikationsplaneinträgen vor und speichert den neuen Medikationsplan.

* ****Medikationsplaneinträge ändern:****

  * Beispiel [Transaction Bundle](Bundle-At-Emed-Journey-06-Bundle-Tx-Medikationsplan.html)

**### 15.3.2026: Abruf des Medikationsplans durch den Patienten**

Einige Tage später möchte Herr Mustermann überprüfen, welches Medikament er weiterhin regelmäßig einnehmen soll. Er ruft in seiner ELGA seinen aktuellen Medikationsplan auf.

Der aktuelle Medikationsplan enthält nun nur noch das **Dauermedikament Ramipril 5 mg**, während die zeitlich begrenzten Medikamente für die postoperative Behandlung bereits beendet wurden.

* ****Aktuellen Medikationsplan anzeigen:****

  * Beispiel [Collection Bundle](Bundle-At-Emed-Journey-07-Bundle-Medikationsplan.html) -->

<br>

<div>{% include_relative plantuml/patient_journey.svg %}</div>

<br>
