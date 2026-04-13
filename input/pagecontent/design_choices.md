{% include styleheader.md %}

### Relevante Profile

#### AtEmedListMedikationsplan (*List*)

Der Medikationsplan eines ELGA-Teilnehmers bzw. einer ELGA-Teilnehmerin wird durch eine *List*-Ressource abgebildet. Diese enthält 0..* Einträge (*List.entry*), wobei jedes Entry genau eine Referenz (*Reference*) auf einen Medikationsplaneintrag (*MedicationRequest*) in *List.entry.item* beinhaltet.

Die Reihenfolge der Einträge kann durch den GDA oder den Patienten festgelegt werden. Jeder Listeneintrag enthält im Element *List.entry.flag* den Änderungsstatus des jeweiligen Medikationsplaneintrags (siehe [Status der List.entry.flag (Medikationsplan)](workflowmanagement.html#status-der-list-entry-flag-medikationsplan)).


#### AtEmedMRPlaneintrag (*MedicationRequest*)

Der Medikationsplaneintrag (*MedicationRequest*-Ressource) im Medikationsplan eines ELGA-Teilnehmers/einer ELGA-Teilnehmerin bildet genau ein Arzneimittel und dessen Dosierung ab und bildet in weiterer Folge die Grundlage zur Erstellung einer geplanten Abgabe (siehe *UC_08 Geplante Abgabe Schreiben*).

Der aktuelle Status eines Medikationsplaneintrags wird im *status*-Element dokumentiert (siehe [Status des MedicationRequests im Medikationsplaneintrag](workflowmanagement.html#status-des-medicationrequests-im-medikationsplaneintrag)).  

Abhängig vom List.entry.flag kann der Medikationsplaneintrag nur eingeschränkte Status einnehmen (siehe [Konsistenzregeln zwischen List.entry.flag und MedicationRequest-Status](workflowmanagement.html#konsistenzregeln-zwischen-list-entry-flag-und-medicationrequest-status)).