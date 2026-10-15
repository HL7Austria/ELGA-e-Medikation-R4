{% include styleheader.md %}

Das Medikationsplan-Bundle vom Typ `transaction` dient dem schreibenden Zugriff auf den Medikationsplan (Aktualisierung aller enthaltenen Ressourcen) und enthält: 
- Medikationsplan (List): Liste mit Referenzen auf Medikationsplaneinträge und zur Abbildung von Reihenfolge und Änderungsstatus 
- keinen oder mehrere Medikationsplaneinträge (MedicationRequests)

Alle neuen bzw. geänderten und zu entfernenden Medikationsplaneinträge müssen inline im Bundle enthalten sein, alle unveränderten Ressourcen werden referenziert.

Details zur `$plan-write`-Operation siehe [Sub_UC_eMed_02_01 - Medikationsplan schreiben (Plan-Write)](Sub_UC_eMed_02.html#sub_uc_emed_02_01---medikationsplan-schreiben-plan-write).