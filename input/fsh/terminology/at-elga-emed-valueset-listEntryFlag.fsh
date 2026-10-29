CodeSystem: ElgaListEntryFlagCS
Id: at-elga-emed-codesystem-listentryflag-cs
Title: "AT ELGA e-Medikation List.entry.flag CodeSystem"
Description: "CodeSystem für zulässige Ausprägungen des Flags eines List.Entries in ELGA."
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
 
* #new "Neuer Planeintrag"
* #unchanged "Planeintrag beibehalten"
* #changed "Planeintrag geändert"
* #removed "Planeintrag entfernt"


ValueSet: ElgaListEntryFlagVS
Id: at-elga-emed-valueset-listentryflag-vs
Title: "AT ELGA e-Medikation List.entry.flag ValueSet"
Description: "ValueSet für zulässige Ausprägungen Ausprägungen des Flags eines List.Entries in ELGA."
* ^experimental = false
* include codes from system ElgaListEntryFlagCS