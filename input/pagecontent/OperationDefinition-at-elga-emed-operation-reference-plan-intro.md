{% include schreibende-operations-allgemein.md %}

### Operation spezifische Business Logik
- Die angegebene *planentry-reference* wird zur neuen Referenz auf einen Planeintrag. War dieses Feld bereits vor der Ausführung der Operation befüllt so wird die Referenz ersetzt durch die in der Operation angegebene.
- Wird *remove-reference* mit `true` übergeben so wird die Referenz auf den Planeintrag aus der durchgeführten Abgabe entfernt.
- Es kann immer nur einer der beiden IN Parameter befüllt sein aber nicht beide gleichzeitig.

<div class="note-to-balloters" markdown="1">
Dieser Teil der Spezifikation wird noch erarbeitet und im nächsten Ballot zur Verfügung gestellt.
</div>