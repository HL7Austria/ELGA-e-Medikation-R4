{% include styleheader.md %}

Die Ressource **`MedicationRequest`** bildet einen Planeintrag des Medikationsplans ab. 

Ein Planeintrag ist eine autorisierte ärztliche Anordnung und stellt eine verbindliche Einnahmeanweisung für den Patienten dar.

Er enthält genau ein Arzneimittel mit dessen Dosierung, wobei das Arzneimittel entweder verpflichtend mit einer contained Medication-Ressource oder einer Conditional Reference über PZN und Displayname dokumentiert wird.
Der Planeintrag kann in weiterer Folge als Grundlage für die Erstellung einer \"Geplanten Abgabe\" dienen.

Relevante Use Cases:
 - [Technische Use Cases für Medikationsplan schreiben (UC_eMed_02)](Sub_UC_eMed_02.html)