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

Das [Medikationsplan-Bundle](StructureDefinition-at-elga-emed-bundle-medikationsplan.html) dient ausschließlich der Auslieferung eines Medikationsplans in einem für die Bearbeitung durch den GDA aufbereiteten Zustand. Es wird von der Fachanwendung nach einer [$plan-read](OperationDefinition-at-elga-emed-operation-plan-read.html)-Operation aus einer *List*-Ressource sowie den von dieser referenzierten Ressourcenversionen erzeugt und **nicht persistiert**.

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


### Fachliche Entscheidungen

#### Abhängigkeit von Planeintrag und Geplanter Abgabe

Gemäß Fachkonzept müssen Arzneimittel und Dosierung einer *Geplanten Abgabe* mit dem zugehörigen Planeintrag identisch sein (siehe [Sub_UC_eMed_04_01](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write)). Enthält der Planeintrag nur Wirkstoffe, werden diese unverändert in die *Geplante Abgabe* übernommen. Soll ein konkretes Präparat rezeptiert werden, muss der Planeintrag zuvor angepasst werden.

Die Übereinstimmung wird nur beim Erstellen der *Geplanten Abgabe* gefordert. Eine spätere Änderung des Planeintrags macht die *Geplante Abgabe* nicht automatisch ungültig. Da `basedOn` nicht versioniert ist, verweist sie immer auf die aktuelle Planeintrag-Version.

**Vergleichsumfang**

| Element | Vergleich |
|---|---|
| Arzneimittel (`medication`) | identisch |
| Dosierung (`dosageInstruction`) | identisch |
| Einnahmezeitraum (`effectiveDosePeriod`) | nicht identisch; Im Planeintrag kann der Beginn in der Vergangenheit liegen (z.B. bei Nacherfassung oder Dauermedikation seit Monaten). |
| Status, Kategorie, Ersteller, `dispenseRequest.*` | nicht vergleichbar |

**Abgrenzung der drei Ebenen**

| Beziehung | Fachliche Vorgabe |
|---|---|
| Planeintrag ↔ *Geplante Abgabe* | Arzneimittel und Dosierung identisch (bei Erstellung) |
| *Geplante Abgabe* ↔ *Durchgeführte Abgabe* | Abweichungen möglich, dokumentiert in der *Durchgeführten Abgabe* (z.B. Präparat statt Wirkstoff) |

**Designentscheidung: Darf die *Geplante Abgabe* vom Planeintrag abweichen?**

| Variante | Beschreibung |
|---|---|
| A: strikte Übereinstimmung  (aktuell) | Abweichung ist nicht zulässig. Für ein Präparat wird zuerst der Planeintrag angepasst. |
| B: Konkretisierung zulässig | Die *Geplante Abgabe* darf einen Wirkstoff aus dem Planeintrag zu einem Präparat konkretisieren. Wirkstoff, Stärke, Darreichungsform und Dosierung bleiben gleich, der Planeintrag bleibt unverändert. |

*Vorteile von A:* Medikationsplan und *Geplante Abgabe* sind widerspruchsfrei. Änderungen der vorgesehenen Medikation sind im Planeintrag nachvollziehbar. Die Prüfung ist einfach.
*Nachteile von A:* Der Planeintrag muss für jedes Präparat vorab angepasst werden. Eine Wirkstoff-Angabe im Medikationsplan geht dadurch verloren.

*Vorteile von B:* Der Planeintrag bleibt auf Wirkstoffebene stabil, und eine spätere Wirkstoffverschreibung wird leichter integrierbar.
*Nachteile von B:* Die Prüfregel wird komplexer (Wirkstoffabgleich über Codesysteme). Es gibt zwei Darstellungsebenen im Medikationsplan.

**Offene Punkte**
- Soll `$prescription-write` bei Abweichung ablehnen (serverseitige Prüfung, Fehlermeldung als OperationOutcome), oder liegt die Prüfung nur beim Client?
- Soll `basedOn` versioniert werden, um die geprüfte Planeintrag-Version nachvollziehen zu können?
- Wie bleibt der Medikationsplan verständlich, wenn das abgegebene Arzneimittel vom Wirkstoff oder Präparat im Planeintrag abweicht?


#### Automatische Statusänderungen der beim Plan-Read ausgelieferten Ressourcen

<!-- Welche Felde können/sollen von der Fachanwendung vorbefüllt werden (Datumfelder, GDA, Patient, status bei list.entry.flag removed + default-Begründung: abgelaufen usw.)
 -->

*Plan-Read* liefert den Medikationsplan in einem für die Bearbeitung aufbereiteten Zustand. Die Fachanwendung erzeugt dazu aus der aktuellen *List*-Version ein **temporäres** Bundle. Die persistierten Ressourcen bleiben unverändert:

- *List.entry.flag* *new* und *changed* werden als *unchanged* ausgeliefert.
- Einträge mit *removed* werden nicht ausgeliefert. Bleibt kein Eintrag übrig, wird *List.emptyReason = nilknown* gesetzt.
- Abgelaufene Planeinträge werden mit *removed* und *stopped* ausgeliefert (siehe UC_eMed_02_09).

*Plan-History-Search* liefert dagegen alle Inhalte, Status und Flags unverändert.

* **Zu klären:** Soll der GDA den aufbereiteten Zustand erhalten (Variante A, aktuell), bei dem er den Originalstatus der persistierten Ressourcen nicht sieht, oder den persistierten Originalzustand (Variante B)?**

**Variante A: aufbereiteter Zustand**

*Vorteile*
- Der GDA bearbeitet nur seine Änderungen, Unverändertes wird nur referenziert.
- Der Plan-Read ist rein lesend, Daten und Historie bleiben unverändert.
- Das Bundle zeigt die aktuelle Medikation. Abgelaufene Einträge erscheinen nicht als aktiv.
- Die Ablauflogik liegt zentral beim Server, die Zustandsübergänge werden serverseitig geprüft.
- Das Original bleibt über *Plan-History-Search* abrufbar.

*Nachteile*
- Bundle und Datenspeicher unterscheiden sich bei gleicher `id` und `versionId`. Der GDA sieht den Originalstatus nicht.
- Die Kenntnisnahme erfolgt implizit: Änderungen des Vorgängers sind schon *unchanged*, nur ein Versionsvergleich zeigt sie.
- Der aufbereitete Zustand ist zeitabhängig, der *ETag* erfasst ihn nicht. Läuft ein Eintrag zwischen Read und Write ab, wird der Write trotz gültigem *ETag* abgelehnt.
- Ein abgelaufener Planeintrag wird erst durch den nächsten schreibenden GDA auf *stopped* gesetzt und diesem als `requester` zugeschrieben. Bei der *Geplanten Abgabe* übernimmt das die Fachanwendung.
- Zwei Zustandsmodelle (persistiert und ausgeliefert) müssen in Profilen und Beispielen konsistent abgebildet werden.

**Variante B: persistierter Originalzustand**

*Vorteile*
- Es gibt keine Divergenz zwischen Bundle und Datenspeicher, das Modell ist einfacher.
- Die Kenntnisnahme erfolgt bewusst durch den GDA.

*Nachteile*
- Jedes GDA-System muss die Flags selbst zurücksetzen, entfernte Einträge herausfiltern und den Ablauf von Einträgen berechnen.
- Die Ablauflogik wird uneinheitlich umgesetzt, abgelaufene Einträge erscheinen als aktiv.
- Plan-Write wird fehleranfälliger.
- Zeitbasierte Statuswechsel (z.B. Ablauf) müssten von der Fachanwendung selbst gespeichert werden, etwa durch einen regelmäßig laufenden Batch-Job.

<!-- - Das Beispiel Journey-01-02 zeigt *unchanged* mit *stopped*, UC_eMed_01 verlangt *removed* mit *stopped*. -->

### Technische Entscheidungen


#### Kennzeichnung der relevanten Elemente

##### Must Support Profilierung 

<!-- Nur Elemente, die mit MS geflaggt sind, werden durch die zentrale Fachanwendung verarbeitet und in weiterer Folge zur Anzeige gebracht (Portal).
Modifier + ausgewählte Elemente werden mit fachlicher Begründung auf 0..0 gesetzt
(geschlossene Profile) → keine Ableitung -->

##### Serverhalten bei Elementen ohne MS Markierung


#### Profile für die Abbildung von Operation In & Output

<!-- TX, write-Response und lesende Operations brauchen eigene Profile -> implementer Feedback erwünscht-->


### Versionierung

##### Versionierte Referenzen
<!-- wann und warum versionierte Referenzen verwendet werden
und wann nicht

o	Referenzmanagement (Patient + Prakt. ohne Version), Geplante + Durchgef. Abg. ohne versionierte Referenzen

wie erkennt client aktuelle liste? (passt nirgends richtig dazu)
version nicht aufsteigend, mit etag (soll nicht version verraten), datum: timestamp dann relevant
man könnte liste retired setzen, snapshot ua? -->

#### Verwendung der FHIR History Funktion

<!-- noch aktuell? -->

#### ID-Management

<!-- o	id-Management (optional bei POST, verpflichtend bei PUT, bei Auslieferung von der Fachanwendung immer befüllt) -->

#### Optimistisches Locking mit ETags

Der ETag identifiziert die persistierte List-Version. Die Fachanwendung nutzt ihn beim Plan-Write, um zu erkennen, ob zwischen Plan-Read und Plan-Write jemand anderes den Plan geändert hat (Optimistic Locking). Ist die Version gleich geblieben, gilt das Write als konfliktfrei.

<!-- o	meta.versionid kann als etag verwendet werden; implementierungsabh.
o	Read-to-Write-Konzept: ETag zur Integritätsprüfung (Optimistic Locking) erwähnen
etag für list ausreichend? auch für planeinträge?
auch für nicht (wirklich) versionierte ressourcen wie geplante und durchgeführte? -->

#### Informationen über GDA und Patienten

Stammdaten zu Gesundheitsdiensteanbietern (GDA) und Patienten werden ausschließlich von der e-Medikation-Fachanwendung, bzw. von den darüberliegenden zentralen Registern, verwaltet. Client-Anwendungen dürfen daher keine eigenen `Patient`-, `Practitioner`-, `PractitionerRole`- oder `Organization`-Ressourcen übermitteln. Es genügt, diese über ihren Identifier als logische Referenz (`Reference.identifier`) anzugeben:

- **GDA:** OID des GDA laut GDA-Index (GDA-I)
- **Patient:** bereichsspezifisches Personenkennzeichen Gesundheit (bPK-GH)

Die e-Medikation-Fachanwendung löst diese Identifier gegen den GDA-I bzw. den Zentralen Patientenindex (ZPI) auf. Bei Bedarf legt sie die zugehörigen Ressourcen an und ersetzt die logischen Referenzen durch Referenzen auf diese Ressourcen. Beim Abruf von Daten enthalten die Ressourcen daher die aufgelösten Referenzen; die referenzierten Ressourcen können über die Fachanwendung abgerufen werden.

#### Befüllung der Narrativen Teile

<!-- * Regelwerk für text Generierung (durch Fachanw.) nötig
    * text beim Schreiben leer, beim lesen 1..1 -->

#### Löschen und Stornieren von versionierten Ressourcen
<!-- horizontales und vertikales löschen in FHIR -->
<!-- fachlich und technische Beschreibung-->

<!-- abgrenzung stornieren durch gda, bleibt nachvollziehbar, löschen durch teilnehmer rückstandslos -->

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



