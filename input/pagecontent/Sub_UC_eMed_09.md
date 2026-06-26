{% include styleheader.md %}

<!-- Technische Use Cases für Durchgeführte Abgabe schreiben (UC_eMed_09) -->

### Sub_UC_eMed_09_01 - Durchgeführte Abgabe schreiben

In Arbeit: Zugriffsarten.

<!-- #### Variante A: Zugriff mittels e-card

<br>

[![overview](plantuml/UC_eMed_09_01_a.svg){: .mx-auto style="width:80%;"}](plantuml/UC_eMed_09_01_a.svg)

<br>


#### Variante B: Zugriff mittels e-Rezept

<br>

[![overview](plantuml/UC_eMed_09_01_a.svg){: .mx-auto style="width:80%;"}](plantuml/UC_eMed_09_01_b.svg)

<br> -->

<!-- Erfolgt die Arzneimittelabgabe in der Apotheke nach Identifikation des ELGA-Teilnehmers mittels e-card, erhält der Apotheker lesenden Zugriff auf alle offenen Geplanten Abgaben und kann entsprechende Abgaben durchführen und dokumentieren. Zusätzlich kann der Apotheker evtl. Wechselwirkungen mit Hilfe des Medikationsplan des ELGA Teilnehmers prüfen und er kann weitere durchgeführten Abgaben (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern.
Zusätzlich kann der Apotheker den Medikationsplan des ELGA-Teilnehmers abrufen, um evtl. Wechselwirkungen zu prüfen und weitere *Durchgeführte Abgaben* (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern. -->

<!-- ohne ecard: Der GDA erhält in diesem Fall keinen Zugriff auf weitere offene *Geplante Abgaben*, kann den *Medikationsplan* des ELGA-Teilnehmers zwecks Wechselwirkungsprüfung nicht einsehen und kann auch keine weiteren *Durchgeführten Abgaben* (z.B. OTC oder Notabgaben) in der e-Medikation des ELGA-Teilnehmers speichern. -->

### Ablauf Durchgeführte Abgabe schreiben

Ein berechtigter GDA (siehe [Rollen und Berechtigungen](actors.html#rollen-und-berechtigungen)) dokumentiert die Abgabe eines Arzneimittels für einen ELGA-Teilnehmer in einer [Durchgeführten Abgabe](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html):
* Wenn eine zugehörige [Geplante Abgabe](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html) vorliegt, **MUSS** diese im Element *MedicationDispense.authorizingPrescription\[geplanteAbgabe\]* referenziert werden. Der zugehörige [Planeintrag](StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html) **MUSS** über *MedicationDispense.authorizingPrescription\[planeintrag\]* referenziert werden.
<!-- TODO: ist kommt die Referenz auf den Planeintrag zustande? Automatisch durch die Fachanwendung oder durch den GDA? -> ergänzen in Relevante Elmente -->
    * Die maximale Anzahl an *Durchgeführten Abgaben* wird durch die Anzahl der zulässigen Einlösungen der zugehörigen *Geplanten Abgabe* bestimmt.

* Der Status einer *Durchgeführten Abgabe* wird durch *MedicationDispense.status* (siehe [Status des MedicationDispense in der Durchgeführten Abgabe](workflowmanagement.html#status-des-medicationdispense-in-der-durchgeführten-abgabe)) und *MedicationDispense.type* bestimmt und kann Auswirkungen auf den Status der zugehörigen *Geplanten Abgabe* haben (siehe [Abhängigkeiten der Geplanten Abgabe und der Durchgeführten Abgaben](workflowmanagement.html#abhängigkeiten-der-geplanten-abgabe-und-der-durchgeführten-abgaben)):
    * Über *MedicationDispense.type* werden Einzelabgabe, Teilabgaben/Besorgerprozess und Leerabgabe unterschieden (siehe [Durchgeführte Abgabe - Varianten der (Teil-)Abgabe](workflowmanagement.html#varianten-der-teil-abgabe)). Für Teilabgaben, Besorgerprozesse und Leerabgaben **MUSS** die jeweils vorgegebene Sequenz der zulässigen *MedicationDispense.type*-Werte eingehalten werden.
* Die tatsächlich abgegebene Packungsmenge **MUSS** in *MedicationDispense.quantity* angegeben werden. Die Fachanwendung prüft diese Menge jedoch nicht im Kontext einer gegebenenfalls zugrunde liegenden *Geplanten Abgabe*. 
Eine Einlösung gilt als vollständig, wenn für *MedicationDispense.type* den Wert *FFC (First Fill – Complete)* oder *PFC (Part Fill - Complete)* enthält. Die Anzahl der abgegebenen Packungen ist hierfür nicht maßgeblich.

<!-- Übermittlung in einem Transaction Bundle ? -->

Die unterschiedlichen Arten der Abgabe und deren Abfolge sind dargestellt unter [Durchgeführte Abgabe - Varianten der (Teil-)Abgabe](workflowmanagement.html#varianten-der-teil-abgabe)).


#### Sub_UC_eMed_09_01_01 - Vollständige Einzelabgabe erfassen 

Eine vollständige Einzelabgabe liegt vor, wenn die in der *Geplanten Abgabe* verordneten Arzneimenge vollständig abgegeben wird (existiert keine zugehörige *Geplante Abgabe* gilt [Sub_UC_eMed_09_01_05 - Durchgeführte Abgabe ohne Bezug zu einer Geplanten Abgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01_05---durchgeführte-abgabe-ohne-bezug-zu-einer-geplanten-abgabe-erfassen)).

Bei einer vollständigen Einzelabgabe **MUSS** eine *Durchgeführte Abgabe* wie folgt erstellt werden:
* *MedicationDispense.type = FFC (First Fill – Complete)* und *MedicationDispense.status = completed* 

Existiert eine zugehörige *Geplante Abgabe* prüft die Fachanwendung anhand *MedicationRequest.numberOfRepeatsAllowed* ob weitere Einlösungen erlaubt sind (z.B. bei einem Privatrezept). Ist nur eine **einmalige Einlösung** möglich (z.B. Kassenrezept), setzt die Fachanwendung die *Geplanten Abgabe* auf den Status *completed*.

Ermöglicht die *Geplante Abgabe* **mehrere Einlösungen** (*MedicationRequest.numberOfRepeatsAllowed* > 0),
wird je Einlösung eine *Durchgeführte Abgabe* erstellt. Der Status der *Geplanten Abgabe* bleibt solange *active*, bis die letztmögliche Einlösung erfolgt ist (siehe[Sub_UC_eMed_08_02 - Geplante Abgabe beenden (durch Fachanwendung)](Sub_UC_eMed_08.html#sub_uc_emed_08_02---geplante-abgabe-beenden-durch-fachanwendung)).



#### Relevante Elemente (MedicationDispense)

```JSON
AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
    recorded: Datum der Erstellung der Durchgeführten Abgabe
    status: completed    
    medicationReference.reference: Tatsächlich abgegebenes Medikament // Contained Medication
    subject: Patient
    performer: veranwortlicher GDA (Apotheke) für die Durchgeführte Abgabe 
    authorizingPrescription[geplanteabgabe]: Verpflichtende Referenz auf zugehörige Geplante Abgabe
    authorizingPrescription[planeintrag]: Verpflichtende Referenz auf Planeintrag
    type: FFC (First Fill - Complete)  // Art der Abgabe
    quantity: Abgegebene Packungen      // Packungen je Einlösung
    whenHandedOver: Zeitpunkt der Arzneimittelaushändigung
    dosageInstruction: optional Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft)  // angepasst an abgegebene Medikation
```

#### Sub_UC_eMed_09_01_02 - Teilabgaben erfassen

Eine Teilabgabe liegt vor, wenn die in der *Geplanten Abgabe* verordneten Arzneimenge nicht vollständig abgegeben wird, weil nur ein Teil der verordneten Arzneimenge eingelöst werden soll oder kann.

Sonderfälle von Teilabgaben sind Besorgerprozess (siehe [Sub_UC_eMed_09_01_03 - Besorgerprozess](sub_uc_emed_09_01_03---besorgerprozess)) und Leerabgabe (siehe [Sub_UC_eMed_09_01_05 Leerabgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01_05-leerabgabe-erfassen)).

Für jede Teilabgabe **MUSS** eine *Durchgeführte Abgabe* erstellt werden. Dabei gelten folgende Regeln:
* *MedicationDispense.type* **MUSS**
    * bei der ersten Teilabgabe den Wert *FFP (First Fill – Part Fill)*,
    * bei jeder weiteren Teilabgabe den Wert *RFP (Refill – Part Fill)* und
    * bei der letzten Teilabgabe, d.h. sobald die in der *Geplanten Abgabe* verordnete Arzneimenge (für eine Einlösung) vollständig abgegeben wurde, den Wert *RFC (Refill – Complete)*
  enthalten.
* *MedicationDispense.status* **MUSS** den Wert *completed* enthalten.
* *MedicationDispense.quantity* **MUSS** die **Anzahl der tatsächlich abgegebenen Packungen** enthalten. 

Die Gültigkeit einer *Geplanten Abgabe* verlängert sich im Zuge von Teilabgaben (siehe [Gültigkeit von Geplanten Abgaben basierend auf der Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart)). 

Sobald eine Teilabgabe durchgeführt wurde (*Part Fill*), ist die Einlösung einer weiteren Teilabgabe in einer anderen Apotheke nicht mehr möglich, d.h. die Apotheke **MUSS** die Teilabgaben mit einem *complete* abschließen.

Vor dem Speichern einer neuen *Durchgeführten Abgabe* **MUSS** die Fachanwendung prüfen,
* ob ein zulässiger Wert für *MedicationDispense.typ* verwendet wird, und
* ob die Anzahl der *Durchgeführten Abgaben* mit *MedicationDispense.type = FFC (First Fill – Complete)* bzw. *MedicationDispense.type = RFC (Refill – Complete)* die gemäß *MedicationRequest.numberOfRepeatsAllowed* zulässige Anzahl zusätzlicher Einlösungen nicht überschreitet.

Der Status der *Geplanten Abgabe* bleibt *active*, solange weitere Einlösungen zulässig sind. Sind keine weiteren Einlösungen mehr möglich, setzt die Fachanwendung den Status der *Geplanten Abgabe* auf *completed*.

Um die durch *MedicationDispense.type* definierte Sequenz *FFP → RFP → RFC* konsistent zu halten, darf immer nur die zuletzt gespeicherte *Durchgeführte Abgabe* verworfen werden. Mehrere *Durchgeführte Abgaben* können nur sequenziell in umgekehrter Reihenfolge ihrer Erstellung verworfen werden.

<!-- TODO: Prüfen ob hier nicht Storno gemeint ist: nur eigene stornierbar -->


#### Relevante Elemente (MedicationDispense)

```JSON
AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
    recorded: Datum der Erstellung der Durchgeführten Abgabe
    status: completed    
    medicationReference.reference: Tatsächlich abgegebenes Medikament // Contained Medication
    subject: Patient
    performer: veranwortlicher GDA (Apotheke) für die Durchgeführte Abgabe 
    authorizingPrescription[geplanteabgabe]: Verpflichtende Referenz auf zugehörige Geplante Abgabe
    authorizingPrescription[planeintrag]: Verpflichtende Referenz auf Planeintrag
    type: FFC (First Fill - Complete) | (Refill - Part Fill) // 1. Teilabgabe, weitere Teilabgabe bestellen
    quantity: Abgegebene Packungen  // je Teilabgabe       
    whenHandedOver: Der Zeitpunkt, zu dem das abgegebene Produkt ausgehändigt wurde
    dosageInstruction: optional Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft)  // angepasst an abgegebene Medikation
```

#### Sub_UC_eMed_09_01_03 - Besorgerprozess

Ein Besorgerprozess liegt vor, wenn das in der *Geplanten Abgabe* verordnete Arzneimittel **bestellt oder zubereitet** werden muss (es findet noch **keine Abgabe** statt). Die *Geplanten Abgabe* kann daraufhin nicht mehr in einer anderen Apotheke eingelöst werden.

Entsprechend den Regeln für Teilabgaben **MUSS** eine *Durchgeführte Abgabe* wie folgt erstellt werden: 
* *MedicationDispense.type* **MUSS** enthalten:
    * zu Beginn des Besorgerprozesses: *MedicationDispense.type = FFP (First Fill – Part Fill)*,
    * nach bereits erfolgten Teilabgaben: *MedicationDispense.type = FFP (Refill – Part Fill)*
* *MedicationDispense.status* **MUSS** den Wert *completed* enthalten.
* Die abgegebenen Packungen **MÜSSEN** mit *MedicationDispense.quantity* = **0** dokumentiert werden. 

Wird das bestellte/zubereitete Arzneimittel ausgehändigt, wird dies in Form einer Teilabgabe mit der abgegebenen Menge dokumentiert, siehe [Sub_UC_eMed_09_01_02 - Teilabgaben erfassen](). 
Die *MedicationDispense.type*-Sequenz *FFP → RFP → RFC* muss dabei konsistent gehalten werden.

Im Fall einer Bestellung mit gleichzeitiger Teilabgabe wird nur die Teilabgabe dokumentert.

Der Status der *Geplanten Abgabe* bleibt während des Besorgerprozesses *active*.


#### Sub_UC_eMed_09_01_04 Leerabgabe erfassen

Mit einer *Leerabgabe* dokumentiert der GDA (Apotheker bzw. Arzt mit Hausapotheke), dass der Patient ein Arzneimittel einer *Geplanten Abgabe* nicht benötigt. Hierfür erstellt er eine [Durchgeführte Abgabe](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html) wie folgt:

* *MedicationDispense.type* **MUSS** 
    * im Fall einer Beendigung einer Einzelabgabe: *MedicationDispense.type = FFC (First Fill Complete)*, 
    * im Fall einer Beendigung einer Teilabgabe: *MedicationDispense.type = RFC (Refill - Complete)*
* *MedicationDispense.status* **MUSS** den Wert *cancelled* enthalten.
* Die abgegebenen Packungen **MÜSSEN** mit *MedicationDispense.quantity* = **0** dokumentiert werden. 
Dieser Einlösevorgang ist damit beendet.

<!-- TODO zu prüfen: -->
Die Anzahl der möglichen Einlösungen einer *Geplanten Abgabe* reduziert sich nach einer Leerabgabe, d.h. sie bleibt weiterhin *active* bis die restlichen möglichen Einlösungen erfolgt sind oder sie zeitlich abläuft. Nur wenn alle möglichen Einlösungen mit *cancelled* gespeichert wurden, wird die zugehörige *Geplante Abgabe* automatisch auf *cancelled* gesetzt, sonst auf *completed*.

<!-- Kann wieder rückgängig gemacht werden (durch Storno). (S31. v2 Absetzdatum + GDA relevant (statusChanged R6)  -->


#### Sub_UC_eMed_09_01_05 - Durchgeführte Abgabe ohne Bezug zu einer Geplanten Abgabe erfassen

In folgenden Fällen liegt bei der Erfassung einer *Durchgeführten Abgabe* keine zugehörige *Geplante Abgabe* vor:
* Abgabe von nicht verordneten Arzneimitteln (Abgabe von wechselwirkungsrelevanten OTC)
* wenn ein e-Rezept-Eintrag oder ein Papierrezept vorhanden ist, aber keine zugehörige *Geplante Abgabe* in e-Medikation existiert.

Analog zu [Sub_UC_eMed_09_01_01 - Vollständige Einzelabgabe erfassen](Sub_UC_eMed_09.html#sub_uc_emed_09_01_01---vollständige-einzelabgabe-erfassen) gilt bei der Erstellung der *Durchgeführten Abgabe*:
* *MedicationDispense.type = FFC (First Fill – Complete)* und *MedicationDispense.status = completed*  

Sofern für die *Durchgeführten Abgabe* im nachhinein ein *Planeintrag* erstellt wird, **KANN** mit $reference-plan der *Planeintrag* (in *MedicationDispense.authorizingPrescription\[planeintrag\]*) referenziert werden. 


#### Sub_UC_eMed_09_01_06 - Durchgeführte Abgabe nacherfassen

Bei der Nacherfassung bereits abgegebener Arzneimittel (z.B. wenn eine Speicherung zum Zeitpunkt der Abgabe aus technischen Gründen nicht möglich war oder bei Arzneimittelbezug aus dem Ausland), wird als Erfassungsdatum der Zeitpunkt der Nacherfassung gesetzt, während als Abgabedatum das tatsächliche Datum der Abgabe in der Vergangenheit eingetragen wird.

Alle weiteren Elemente sind entsprechend der Abgabeart zu befüllen.


#### Relevante Elemente (MedicationDispense)

```JSON
AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
    recorded: Datum der Nacherfassung
    whenHandedOver: Der Zeitpunkt, zu dem das abgegebene Produkt ausgehändigt wurde
```

#### Sub_UC_eMed_09_01_07 Substitution eines Arzneimittels erfassen

Eine Substitution eines Arzneimittels ist nur implizit ersichtich, durch die Referenz auf die zugehörige *Geplante Abgabe* bzw. den *Planeintrag*.

<!-- Begrüdung verpflichtend? -->

### Sub_UC_eMed_09_02 - Durchgeführte Abgabe verwerfen

Ein GDA (Apotheke) kann von ihm erstellte [Durchgeführte Abgaben](design_choices.html#durchgeführte-abgabe-AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe-medicationdispense), die sich im Status *completed* oder *cancelled* befinden, aufgrund eines Fehlers verwerfen. 

Um eine *Durchgeführte Abgabe* zu verwerfen, ruft der GDA diese mittels GET MedicationDispense ab und bearbeitet diese wie folgt:
- Der Status wird auf *entered-in-error* gesetzt,
- der verantwortliche GDA (*requester*) und das Datum in *recorded* werden entsprechend aktualisiert.

Eine verworfene *Durchgeführte Abgabe* kann nicht mehr bearbeitet werden und ist nur noch aber über die Historie einsehbar.
Wenn eine verworfene *Durchgeführte Abgabe* Teil eines e-Rezepts mit weiteren *Geplanten Abgaben* ist (gleicher *e-Med GroupIdentifier*), wirkt sich dies nicht auf den Status der anderen Geplanten Abgaben aus.
<!-- TODO prüfen -->

<!-- TODO: Suchparameter nach stornierten Durchgeführten Abgaben? -->
<!-- TODO: Wenn stornierte *Durchgeführte Abgabe* Teil eines e-Rezepts mit weiteren geplanten Abgaben ist: Auswirkungen? keene -->

### Sub_UC_eMed_09_03 - Durchgeführte Abgabe löschen (durch ELGA-Teilnehmer)

Der ELGA-Teilnehmer kann eine *Durchgeführte Abgabe* endgültig löschen. 

Die Löschung der *Durchgeführten Abgabe* umfasst:

- die fachliche Entfernung der betreffenden *MedicationDispense-Ressource* sowie
- die Entfernung aller zugehörigen historischen Ressourcenversionen (*_history*).

Zum Löschen einer *Durchgeführte Abgabe* ruft der ELGA-Teilnehmer die betreffende *Durchgeführte Abgabe* im ELGA-Portal auf. Dieses führt zunächst eine Leseoperation auf die betreffende MedicationDispense-Ressource aus (GET MedicationDispense/[id]) und löscht anschließend die betreffende Geplante Abgabe mittels DELETE (DELETE [base]/MedicationDispense/[id]).

Die Ressource einschließlich aller historischen Versionen darf nach erfolgreicher Löschung weder über reguläre FHIR-Interaktionen noch über administrative Schnittstellen abrufbar sein.
<!-- Todo: Auswirkunung auf bestehende Geplante Abgaben? Darf nicht wieder active werden -->

<!-- #### Beispiel

#### Technische Hinweise

#### Relevante Profile

#### Relevante Invarianten

#### Mögliche Notifications -->