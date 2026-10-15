{% include styleheader.md %}

Die **`List`**-Ressource bildet den Medikationsplan ab und enthält keinen oder mehrere Einträge (`List.entry`):
- Jeder Eintrag referenziert über `List.entry.item` genau einen Medikationsplaneintrag (`MedicationRequest`).
- Die Reihenfolge der `List.entry`-Elemente bestimmt die Reihenfolge der Planeinträge im Medikationsplan.
- Das Element `List.entry.flag` kennzeichnet den Änderungsstatus des jeweiligen Medikationsplaneintrags.
- Ein leerer Medikationsplan muss mit einem `emtptyReason` gekennzeichnet sein.

Relevante Use Cases:
 - [Technische Use Cases für Medikationsplan schreiben (UC_eMed_02)](Sub_UC_eMed_02.html#%E2%80%8Btechnische-use-cases-für-medikationsplan-schreiben-uc_emed_02)