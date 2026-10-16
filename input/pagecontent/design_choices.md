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
<!-- 
Das Löschen von Medikationsplänen und Planeinträgen soll ausschließlich auf Veranlassung von ELGA-Teilnehmer:innen bzw. deren berechtigten Vertretungen möglich sein. Die konkreten Berechtigungen und Abläufe werden im Rahmen der Konzeption der **Teilnehmerrechte** festgelegt.

Für das Löschen sind zwei unterschiedliche Konzepte zu unterscheiden: das **horizontale Löschen von Medikationsplaneinträgen** und das **vertikale Löschen von Medikationsplänen**.

**Horizontales Löschen**

Beim horizontalen Löschen wird ein Medikationsplaneintrag einschließlich sämtlicher Versionen der zugehörigen `MedicationRequest`-Ressource gelöscht. Der Medikationsplaneintrag scheint daher nicht mehr in den darauf referenzierenden Medikationsplanversionen (historische oder die aktuelle) auf. Die Löschung erfolgt unabhängig davon, ob es sich um einen aktuellen oder einen historischen Medikationsplaneintrag handelt.

Da durch die Löschung die ursprüngliche Dokumentation der Planeinträge nicht mehr vollständig nachvollziehbar ist, wird das `PatientModified`-Flag in den entsprechenden Medikationsplanversionen auf `true` gesetzt. Dieses kennzeichnet, dass die Integrität dieser Medikationsplanversionen aufgrund einer nachträglichen Änderung durch den Patienten bzw. dessen Vertretung nicht mehr gewährleistet ist.

Die übrigen Planeinträge und deren Versionshistorie bleiben von der Löschung unberührt. Dadurch bleibt deren Verlauf weiterhin nachvollziehbar.

**Vertikales Löschen**

Beim vertikalen Löschen werden einzelne Medikationsplanversionen (Versionen der `List`-Ressource) gelöscht. Die referenzierten Medikationsplaneinträge werden dabei nur dann ebenfalls gelöscht, wenn sie in keiner verbleibenden Medikationsplanversion mehr referenziert werden. Dadurch werden tote Referenzen vermieden und die Integrität der verbleibenden Medikationsplanversionen erhalten.

Das vertikale Löschen ermöglicht es, Medikationsplanversionen aus der Historie zu entfernen, ohne zwangsläufig die darin enthaltenen Planeinträge und deren Versionshistorie zu löschen. Die verbleibenden Medikationsplanversionen bleiben unverändert.

Aus der Löschung einer Medikationsplanversion allein lässt sich nicht ableiten, dass ein bestimmter Besuch in einer Einrichtung verschleiert werden kann. Insbesondere bleiben Planeinträge erhalten, sofern sie in anderen Medikationsplanversionen weiterhin referenziert werden, beispielsweise aufgrund einer späteren Version mit einem anderen Autor.

Wird der aktuelle Medikationsplan gelöscht, muss weiterhin ein aktueller Medikationsplan verfügbar sein. Dieser wird als leere `List`-Ressource mit dem Patienten als Autor repräsentiert.

Für die Löschung von Planeinträgen gelten somit folgende Regeln:

- **Keine weitere Referenz:** Ein Medikationsplaneintrag, der in keiner verbleibenden Medikationsplanversion mehr vorkommt, wird einschließlich sämtlicher Versionen gelöscht (z. B. Szenario 1_2).
- **Weitere Referenz vorhanden:** Ein Medikationsplaneintrag, der in mindestens einer verbleibenden Medikationsplanversion weiterhin referenziert wird, bleibt erhalten. Dadurch werden tote Referenzen vermieden (z. B. Szenario 3_1).

#### Begründung der Löschkonzepte

Bei der Konzeption des Löschverhaltens sind insbesondere die Nachvollziehbarkeit der Medikationshistorie, die Integrität der Medikationsplanversionen und die Möglichkeit zu berücksichtigen, einzelne Medikationsplaneinträge zu löschen, ohne den Verlauf der übrigen Einträge zu beeinträchtigen.

**Horizontales Löschen** ermöglicht die vollständige Entfernung eines Medikationsplaneintrags aus der aktuellen und historischen Dokumentation. Dadurch wird sichergestellt, dass der betreffende Eintrag nicht mehr sichtbar ist. Gleichzeitig bleibt der Verlauf der übrigen Planeinträge erhalten. Der Nachteil besteht darin, dass die ursprüngliche Verordnungshistorie nicht mehr vollständig nachvollzogen werden kann und die Integrität der betroffenen Medikationspläne nicht mehr gewährleistet ist. Das `PatientModified`-Flag macht diesen Umstand kenntlich.

**Vertikales Löschen** entfernt hingegen Medikationsplanversionen als Ganzes. Planeinträge und deren Historie bleiben erhalten, sofern sie noch von anderen Medikationsplanversionen referenziert werden. Dadurch bleibt die Integrität der verbleibenden Medikationsplanversionen gewahrt. Gleichzeitig können nicht mehr benötigte Medikationsplanversionen aus der Historie entfernt werden, ohne die Historie der weiterhin verwendeten Planeinträge zu beeinträchtigen.

Beide Konzepte verfolgen somit unterschiedliche Ziele: Während das horizontale Löschen auf die vollständige Entfernung einzelner Planeinträge abzielt, ermöglicht das vertikale Löschen die Entfernung einzelner Medikationsplanversionen unter Erhaltung weiterhin benötigter Planeinträge.


#### Alternative 1: Medikationsplaneinträge durch Überschreiben unkenntlich machen („Tip-Ex“)

Bei diesem Ansatz wird ein Medikationsplaneintrag nicht physisch gelöscht, sondern durch Überschreiben seiner Inhalte, beispielsweise mit leeren Werten oder einer Kennzeichnung als gelöscht, unkenntlich gemacht.

Die ursprünglichen Medikationsplanversionen bleiben erhalten. Es ist weiterhin ersichtlich, welche Medikationspläne von der Änderung betroffen sind und wie viele Medikationsplaneinträge darin gelöscht wurden. Die Integrität der betroffenen Medikationspläne ist jedoch nicht mehr gegeben, da die ursprünglich dokumentierten Inhalte nicht mehr vollständig verfügbar sind.

Die übrigen Planeinträge und deren Verlauf bleiben erhalten. Das Löschverhalten wäre für aktuelle und historische Planeinträge identisch.

Da die Integrität der Medikationspläne nicht mehr gewährleistet ist, müsste ein GDA bei entsprechendem Klärungsbedarf nachvollziehen, welche Informationen fehlen. Dieser Ansatz würde die Nachvollziehbarkeit der von der Änderung betroffenen Medikationspläne verbessern, die ursprünglichen Planeinträge jedoch nicht unverändert erhalten.

#### Alternative 2: Medikationspläne einschließlich nicht mehr benötigter Einträge aus der Historie löschen

Bei diesem Ansatz wird eine Medikationsplanversion einschließlich der darin enthaltenen Medikationsplaneinträge aus der Historie entfernt. Medikationsplaneinträge werden jedoch nur dann gelöscht, wenn sie in keiner anderen verbleibenden Medikationsplanversion mehr vorkommen.

Dadurch verschwinden die betroffenen Medikationsplanversionen und gegebenenfalls ausschließlich darin enthaltene Planeinträge vollständig aus der aktuellen und historischen Dokumentation. Die verbleibenden Medikationsplanversionen behalten ihre Integrität, da weiterhin referenzierte Planeinträge erhalten bleiben.

Die Historie entspricht damit den vom GDA dokumentierten Medikationsplanversionen, abzüglich der gelöschten Planversionen und der ausschließlich darin enthaltenen Einträge. Das Löschverhalten wäre für aktuelle und historische Medikationsplanversionen identisch.

Der Vorteil dieses Ansatzes liegt darin, dass ganze Medikationsplanversionen entfernt werden können, ohne die Integrität der verbleibenden Medikationsplanversionen zu beeinträchtigen. Gleichzeitig geht die Dokumentation der gelöschten Planversionen verloren.

#### Alternative 3: Medikationsplaneinträge einschließlich ihrer gesamten Versionshistorie löschen

Bei diesem Ansatz werden Planeinträge einschließlich sämtlicher Versionen ihrer `MedicationRequest`-Ressourcen gelöscht. Der betreffende Eintrag verschwindet dadurch vollständig aus den aktuellen und historischen Medikationsplänen.

Die ursprüngliche Verordnungshistorie kann für den gelöschten Medikationsplaneintrag nicht mehr nachvollzogen werden. Die Integrität der betroffenen Medikationsplanversionen ist daher nicht mehr gewährleistet. Um diesen Umstand kenntlich zu machen, könnte der Autor der betroffenen Medikationsplanversionen auf den Patienten geändert werden.

Die übrigen Planeinträge und deren Verlauf bleiben erhalten. Das Löschverhalten wäre für aktuelle und historische Planeinträge identisch.

Der Vorteil dieses Ansatzes besteht in der vollständigen Entfernung eines Medikationsplaneintrags bei gleichzeitiger Erhaltung der Historie der übrigen Einträge. Der Nachteil liegt im Verlust der ursprünglichen Dokumentation und der eingeschränkten Nachvollziehbarkeit der betroffenen Medikationsplanversionen. -->
