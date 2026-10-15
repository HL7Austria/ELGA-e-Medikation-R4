{% include styleheader.md %}

Die Ressource **`MedicationRequest`** bildet einen Planeintrag des Medikationsplans ab. 

Sie enthält genau ein Arzneimittel mit dessen Dosierung, wobei das Arzneimittel entweder verpflichtend mit einer contained Medication-Ressource oder einer Conditional Reference über PZN und Displayname dokumentiert wird.
Der Planeintrag kann in weiterer Folge als Grundlage für die Erstellung einer \"Geplanten Abgabe\" dienen.

Relevante Use Cases:
 - [Technische Use Cases für Medikationsplan schreiben (UC_eMed_02)](Sub_UC_eMed_02.html#%E2%80%8Btechnische-use-cases-für-medikationsplan-schreiben-uc_emed_02)