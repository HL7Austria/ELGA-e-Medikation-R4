{% include styleheader.md %}

Die Ressource **`MedicationDispense`** bildet eine *Durchgeführte Abgabe* ab. 

Sie enthält das abgegebe Arzneimittel mit dessen Dosierung und dient somit der Nachvollziehbarkeit der rezeptierten Arzneimittel in der e-Medikation. Eine *Durchgeführte Abgabe* kann sich auf einen Planeintrag und/oder eine *Geplante Abgabe* beziehen und trägt dann denselben *e-Med GroupIdentifier*. Sie kann hinsichtlich des tatsächlich abgegebenen Arzneimittels und dessen Dosierung von Planeintrag und *Geplanter Abgabe* abweichen.

Der aktuelle Status einer *Durchgeführten Abgabe* wird mittels *status*- und *type*-Element dokumentiert (siehe [Status des MedicationDispense in der Durchgeführten Abgabe](workflowmanagement.html#status-des-medicationdispense-in-der-durchgeführten-abgabe)). 

Relevante Use Cases:
 - [Sub_UC_eMed_05_01 - Durchgeführte Abgabe erstellen](Sub_UC_eMed_05.html#sub_uc_emed_05_01---durchgeführte-abgabe-erstellen)