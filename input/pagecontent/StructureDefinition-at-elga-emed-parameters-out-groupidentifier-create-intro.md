Die $groupidentifier-create Operation wird auf Systemebene aufgerufen. Dem Server wird dabei keine Ressource übermittelt.

* Bei Erfolg enthält die Antwort den neu erzeugten *e-Med GroupIdentifier* (*groupIdentifier*) sowie den DataMatrix-Code (*dataMatrixCode*), der diesen codiert. Der DataMatrix-Code darf nur gemeinsam mit dem *e-Med GroupIdentifier* enthalten sein.
* Im Fehlerfall enthält die Antwort ausschließlich einen OperationOutcome mit dem Fehler, der zur Ablehnung der Operation geführt hat.
