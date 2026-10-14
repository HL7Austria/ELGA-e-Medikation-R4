### Allgemeine Business-Logik aller schreibeneden Operations:
- Vor dem schreiben muss jede Ressource gegen das jeweilige Profil geprüft und validiert werden (inklusive Invarianten)
- Es muss geprüft werden, dass in allen Ressourcen der selbe Patient referenziert wird
- Wird eine Ressource am Server neu angelegt oder verändert meta.lastUpdated befüllt und mit einer neuen meta.versionId versehen werden.
- Es muss in allen Ressourcen .text laut den im IG definierten Regeln befüllt werden.
...

<div class="note-to-balloters" markdown="1">
In Arbeit.
</div>