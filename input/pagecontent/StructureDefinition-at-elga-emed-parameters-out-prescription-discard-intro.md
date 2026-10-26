Die $prescription-discard Operation wird direkt auf Instanzebene aufgerufen. Dem Server wird dabei keine Ressource übermittelt, weshalb im Gegensatz zu $prescription-write weder ein Transaction-Response Bundle noch OperationOutcome(s) mit Hinweisen zu ignorierten Must-Support Elementen zurückgegeben werden. Die Antwort enthält daher immer genau einen Parameter:

* Bei Erfolg enthält die Antwort ausschließlich die stornierte Geplante Abgabe, so wie sie nach dem Ausführen der Operation am Server persistiert ist.
* Im Fehlerfall enthält die Antwort ausschließlich ein OperationOutcome mit dem Fehler, der zur Ablehnung der Operation geführt hat.
