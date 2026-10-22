{% include styleheader.md %}

Die Ressource **`MedicationRequest`** mit der Kategorie "Geplante Abgabe" bildet eine *Geplante Abgabe* ab. 

Sie repräsentiert den Auftrag zur Abgabe eines Arzneimittels sowie die entsprechende Autorisierung durch den Verfasser.

Sie enthält genau das im zugehörigen Planeintrag verordnete Arzneimittel mit dessen Dosierung und dient somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation. Werden mehrere Arzneimittel gemeinsam verordnet (und sind demselben e-Rezept zugeordnet), wird für jedes Arzneimittel eine *Geplante Abgabe* mit demselben *e-Med GroupIdentifier* erstellt. 

Der aktuelle Status einer Geplanten Abgabe wird im *status*-Element dokumentiert (siehe [Status der Geplanten Abgabe (MedicationRequest)](workflowmanagement.html#status-der-geplanten-abgabe-medicationrequest)).

Relevante Use Cases:
 - [Sub_UC_eMed_04_01 - Geplante Abgabe erstellen (Prescription-Write)](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write)
