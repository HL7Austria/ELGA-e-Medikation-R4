
Beim Ausliefern des Collection Bundles werden folgende List-Flags vom Server automatisch geändert:

* von new zu unchangened
* von changed zu unchangened
* (unchanged bleib gleich)

Diese Collection wird nicht als neue Listenversion persistiert, sondern nur als Ergebnis der Operation zurückgeliefert.

Entries die vor dem Aufruf das Flag removed haben, werden aus der Liste entfernt.