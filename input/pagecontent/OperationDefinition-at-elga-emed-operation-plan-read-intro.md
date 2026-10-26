### Operation spezifische Business Logik
Die e-Medikation-Fachanwendung erzeugt aus der aktuellen Version
der List-Ressource sowie sämtlichen von ihr referenzierten Ressourcen
ein temporäres Medikationsplan-Bundle zur Auslieferung.

Vor der Auslieferung prüft die Fachanwendung den Zustand des Medikationsplans:

1. Existiert noch kein Medikationsplan, wird eine initiale List-Ressource
   mit List.emptyReason = notstarted erstellt und als erste Version
   persistiert. Für die Auslieferung erfolgt keine Transformation.

2. Existiert ein Medikationsplan mit Planeinträgen, werden für das
   Auslieferungs-Bundle folgende Transformationen durchgeführt:
   - Planeinträge mit List.entry.flag = new oder changed werden auf
     unchanged gesetzt.
   - Bereits mit List.entry.flag = removed gekennzeichnete Planeinträge
     werden aus dem ausgelieferten Medikationsplan entfernt.
   - Planeinträge mit abgelaufenem Behandlungszeitraum werden mit
     List.entry.flag = removed gekennzeichnet und weiterhin ausgeliefert,
     damit der GDA die Medikation weiterverordnen kann. Anderenfalls
     wird der Planeintrag mit dem nächsten Schreibvorgang entfernt.
   - Sind nach der Transformation keine Planeinträge mehr vorhanden,
     wird List.emptyReason = nilknown gesetzt.

3. Existiert ein leerer Medikationsplan mit List.emptyReason, erfolgt
   keine Transformation.

Die Transformationen für das temporäre Auslieferungs-Bundle verändern
die persistierten Ressourcen nicht. Davon ausgenommen ist die oben
beschriebene initiale Erstellung eines noch nicht vorhandenen
Medikationsplans.

Das zurückgelieferte Medikationsplan-Bundle enthält die gegebenenfalls transformierte List-Ressource sowie sämtliche direkt oder indirekt von ihr referenzierten Ressourcen. Dazu werden alle Referenzen rekursiv aufgelöst: Enthält eine referenzierte Ressource weitere Referenzen, werden auch die darüber verknüpften Ressourcen in das Bundle aufgenommen.

Auf diese Weise umfasst das Bundle beispielsweise auch die Autoren der MedicationRequest-Ressourcen, auf die die List-Ressource verweist.

Der HTTP-Response-Header ETag enthält den ETag der aktuellen persistierten
Version der List-Ressource. Dieser dient dem Optimistic Locking beim nachfolgenden Plan-Write.

Im Fehlerfall wird ein HTTP-Fehlerstatus mit einem OperationOutcome
zurückgegeben.