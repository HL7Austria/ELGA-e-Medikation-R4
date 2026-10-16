{% include styleheader.md %}

Die Ressource **`MedicationRequest`** mit Kategorie "Geplante Abgabe" bildet eine *Geplante Abgabe* ab. 

Sie enthält genau das im zugehörigen Planeintrag verordnete Arzneimittel mit dessen Dosierung und dient somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation. Werden mehrere Arzneimittel gleichzeitig verordnet (und sind demselben e-Rezept zugeordnet), wird für jedes Arzneimittel eine *Geplante Abgabe* mit demselben *e-Med GroupIdentifier* erstellt. 

Der aktuelle Status einer geplanten Abgabe wird im *status*-Element dokumentiert (siehe [Status des MedicationRequests in der geplanten Abgabe](workflowmanagement.html#status-des-medicationrequests-in-der-geplanten-abgabe)).

Relevante Use Cases:
 - [Sub_UC_eMed_04_01 - Geplante Abgabe erstellen (Prescription-Write)](Sub_UC_eMed_04.html#sub_uc_emed_04_01---geplante-abgabe-erstellen-prescription-write)