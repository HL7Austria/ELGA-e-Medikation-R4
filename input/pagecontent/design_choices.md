{% include styleheader.md %}

### Übersicht

Die folgende Abbildung zeigt den Aufbau des Medikationsplans sowie das Zusammenwirken der dabei verwendeten FHIR-Ressourcen.

Zentrale Ressource ist der Medikationsplan (*List*), der die einzelnen Medikationsplaneinträge (*MedicationRequest*) referenziert. Basierend auf diesen Planeinträgen werden *Geplante Abgaben* (*MedicationRequest*) erstellt, auf deren Grundlage *Durchgeführte Abgaben* (*MedicationDispense*) dokumentiert werden können.

Die Fachanwendung persistiert ausschließlich die einzelnen FHIR-Ressourcen. Historische Zustände werden durch versionierte Ressourcen und versionierte Referenzen abgebildet <!--Todo: prüfen, ob zutreffend akl 12.10. -->. Medikationsplan-Bundles dienen ausschließlich der Auslieferung eines Medikationsplans und werden bei Bedarf aus den entsprechenden Ressourcenversionen erzeugt.

<br>
[![diagram](Uebersicht_e_Medikation_Ressourcen.drawio.svg){: style="width: 100%"}](Uebersicht_e_Medikation_Ressourcen.drawio.svg)

<!-- TODO Pfeile zu Patient und Practitioner? Umrandung Medikationsplan-Bundle strichliert -->

#### Relevante Profile

 
##### Medikationsplan: AtElgaEmedListMedikationsplan (*List*)

Der Medikationsplan eines ELGA-Teilnehmers wird durch eine [List](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource abgebildet, welche keinen oder mehrere Planeinträge referenziert. Jeder Planeintrag ist im *List.entry.flag* durch einen Status gekennzeichnet (siehe [Status der List.entry.flag (Medikationsplan)](workflowmanagement.html#status-der-list-entry-flag-medikationsplan)).

Die List-Ressource bildet gemeinsam mit den referenzierten Ressourcenversionen die Grundlage für den Aufbau des aktuellen bzw. eines historischen Medikationsplans.

<!-- TODO: Wiederverwendbarkeit der Liste für e-Diagnose und e-Behandlungsplan -->

##### Medikationsplaneintrag bzw. Planeintrag: AtElgaEmedMedicationRequestPlaneintrag (*MedicationRequest*)

Ein Planeintrag im Medikationsplan wird durch eine [MedicationRequest](StructureDefinition-at-elga-emed-list-medikationsplan.html)-Ressource der Kategorie "Planeintrag" abgebildet. Die Ressource enthält genau ein verordnetes Arzneimittel mit der zugehörigen Dosierung.

Der Planeintrag kann in weiterer Folge als Grundlage für die Erstellung einer *Geplanten Abgabe* dienen. 

In Abhängigkeit des zugehörigen List.entry.flags im Medikationsplan kann der Planeintrag unterschiedliche Status einnehmen (siehe [Status des MedicationRequests im Planeintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag)).  

Abhängig vom List.entry.flag kann der Planeintrag nur bestimmte Statuswerte annehmen (siehe [Konsistenzregeln zwischen List.entry.flags und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-listentryflags-und-medicationrequest-status)).


##### Medikationsplan-Bundle: AtElgaEmedBundleMedikationsplan (*Medikationsplan-Bundle*)

Das [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) dient ausschließlich der Auslieferung eines Medikationsplans in einem für die Bearbeitung durch den GDA aufbereiteten Zustand. Es wird von der Fachanwendung nach einer [$plan-read](OperationDefinition-AtElgaEmed.List.PlanRead.html)-Operation aus einer *List*-Ressource sowie den von dieser referenzierten Ressourcenversionen erzeugt und **nicht persistiert**.

<!-- TODO: Iste ein Medikationsplan-Bundle nur das Ergebnis von Plan-Read oder auch Teil des Ergebnis von Plan-History-Read (in einem Searchset-Bundle)? -->

<!-- #### Geplante Abgabe Transaction-Bundle: AtElgaEmedBundleGeplanteAbgabeTX (*Transaction Bundle*)

Ein Bundle vom Typ Transaction, das beim Speichern von [Geplanten Abgaben](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) mittels [Prescription-Write](interactions.html#prescription-write) auf den Medikationsplan an die Fachanwendung übermittelt wird. 

Die im Bundle enthaltenen *Geplanten Abgaben* müssen mit dem gleichen *e-Med GroupIdentifier* gekennzeichnet sein. Fehlt dieser bei allen *Geplanten Abgaben* im Transaction Bundle, wird er von der Fachanwendung ergänzt. 

Profil in Arbeit. -->

<!-- 
TODO: Erklärung Planreferenz in Durchgeführte Abgabe, damit ersichtlich, wenn Abgabe (Arznei/Dosierung) abweichend (/Substituion) -->


<!-- #### Medikationsplan-Transaction-Bundle: AtElgaEmedBundleMedikationsplanTx (*Transaction Bundle*)

Ein Bundle vom Typ Transaction, das beim [Plan-Write](interactions.html#plan-write) an die Fachanwendung übermittelt wird. 
Das Bundle enthält den [Medikationsplan](design_choices.html#medikationsplan-atelgaemedlistmedikationsplan-list) mit Referenzen auf die *Medikationsplaneinträge*. Alle neuen bzw. geänderten und zu entfernenden Medikationsplaneinträge müssen inline im Bundle enthalten sein, alle unveränderten Ressourcen werden referenziert.

Das Transaction Bundle dient der Aktualisierung aller enthaltenen Ressourcen und wird selbst nicht persisitert. -->


#### *Geplante Abgabe*: AtElgaEmedMedicationRequestGeplanteAbgabe (*MedicationRequest*)

Eine *Geplante Abgabe* eines Arzneimittels wird durch eine *MedicationRequest*-Ressource der Kategorie *Geplante Abgabe* abgebildet und dient der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation, siehe [Profil *Geplante Abgabe*](StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html).

#### *Durchgeführte Abgabe*: AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe (*MedicationDispense*)

Die Ausgabe eines Arzneimittels wird mit einer *Durchgeführte Abgaben* in einer *MedicationDispense*-Ressource dokumentiert und dient der Nachvollziehbarkeit der abgegebenen Arzneimittel in der e-Medikation, siehe [Profil Durchgeführte Abgabe](StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html).

<!-- 
- Must Support Profilierung 

Nur Elemente, die mit MS geflaggt sind, werden durch die zentrale Fachanwendung verarbeitet und in weiterer Folge zur Anzeige gebracht (Portal).
Modifier + ausgewählte Elemente werden mit fachlicher Begründung auf 0..0 gesetzt


- Versionierung

wann und warum versionierte Referenzen verwendet werden
und wann nicht

-->




### Fachliche Entscheidungen

#### Abhängigkeit Planeintrag und geplante Abgabe
<!-- welche Elemente gleich? soll die prüfung wirklich ablehnen bei abweichungen ect.?-->



### Technische Entscheidungen


#### Kennzeichnung der relevanten Elemente
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

##### Serverhalten bei Elementen ohne MS Markierung
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

#### Befüllung der Narrativen Teile

<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

#### Profile für die Abbildung von Operation In & Output
<!-- TX, write-Response und lesende Operations brauchen eigene Profile -> implementer Feedback erwünscht-->
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>


#### Informationen über GDA und Patienten

Stammdaten zu Gesundheitsdiensteanbietern (GDA) und Patienten werden ausschließlich von der e-Medikation-Fachanwendung, bzw. von den darüberliegenden zentralen Registern, verwaltet. Client-Anwendungen dürfen daher keine eigenen `Patient`-, `Practitioner`-, `PractitionerRole`- oder `Organization`-Ressourcen übermitteln. Es genügt, diese über ihren Identifier als logische Referenz (`Reference.identifier`) anzugeben:

- **GDA:** OID des GDA laut GDA-Index (GDA-I)
- **Patient:** bereichsspezifisches Personenkennzeichen Gesundheit (bPK-GH)

Die e-Medikation-Fachanwendung löst diese Identifier gegen den GDA-I bzw. den Zentralen Patientenindex (ZPI) auf. Bei Bedarf legt sie die zugehörigen Ressourcen an und ersetzt die logischen Referenzen durch Referenzen auf diese Ressourcen. Beim Abruf von Daten enthalten die Ressourcen daher die aufgelösten Referenzen; die referenzierten Ressourcen können über die Fachanwendung abgerufen werden.


#### ID-Management
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

#### Optimistisches Locking mit ETags
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>



#### Verwendung der FHIR History Funktion
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

##### Versionierte Referenzen
<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>

##### Löschen und Stornieren von versionierten Ressourcen
<!-- horizontales und vertikales löschen in FHIR -->
<!-- fachlich und technische Beschreibung-->
<div class="note-to-balloters" markdown="1">


##### Löschen von Medikationsplan und Medikationsplaneinträgen

Das Löschen von Medikationsplänen und Planeinträgen soll ausschließlich auf Veranlassung von ELGA-Teilnehmer:innen bzw. deren berechtigten Vertretungen möglich sein. Die konkreten Berechtigungen und Abläufe werden im Rahmen der Konzeption der **Teilnehmerrechte** festgelegt.

Für das Löschen sind zwei unterschiedliche Konzepte zu unterscheiden: das **horizontale Löschen von Medikationsplaneinträgen** und das **vertikale Löschen von Medikationsplänen**.

**Horizontales Löschen von Medikationsplaneinträgen**

Beim horizontalen Löschen wird ein Medikationsplaneintrag (`MedicationRequest`) einschließlich aller Versionen unwiderruflich gelöscht. Der Eintrag ist damit weder in aktuellen noch in historischen Medikationsplanversionen sichtbar.

Da die ursprüngliche Dokumentation des Medikationsplaneintrags nicht mehr vollständig nachvollziehbar ist, wird das *PatientModified*-Flag auf *true* gesetzt. Die übrigen Medikationsplaneinträge und deren Versionshistorie bleiben unberührt.

Die übrigen Planeinträge und deren Versionshistorie bleiben von der Löschung unberührt. 

<!-- **Alternative:** Medikationsplaneinträge überschreiben

Medikationsplaneinträge werden DataAbsentReason überschrieben, anstatt gelöscht zu werden.

Die betroffenen Medikationsplanversionen bleiben sichtbar, ihre ursprünglichen Inhalte sind jedoch nicht mehr vollständig nachvollziehbar. Es ist weiterhin erkennbar, welche Pläne betroffen sind und wie viele Einträge gelöscht wurden. Die übrigen Medikationsplaneinträge und deren Versionshistorie bleiben erhalten. -->

**Vertikales Löschen von Medikationsplänen**

Beim vertikalen Löschen werden einzelne Medikationsplanversionen (Versionen der `List`-Ressource) unwiderruflich gelöscht. Die darin referenzierten Planeinträge werden nur dann einschließlich ihrer gespeicherten Versionen gelöscht, wenn sie in keiner verbleibenden Medikationsplanversion mehr referenziert werden. Dadurch bleiben bestehende Referenzen auflösbar.

Die verbleibenden Medikationsplanversionen und Medikationsplaneinträge bleiben unverändert. Die entfernten Planversionen sind jedoch nicht mehr Teil der verfügbaren Historie. Wird der aktuelle Medikationsplan gelöscht, muss eine leere *List*-Ressource mit dem Patienten als Autor als aktueller Medikationsplan verfügbar sein.



