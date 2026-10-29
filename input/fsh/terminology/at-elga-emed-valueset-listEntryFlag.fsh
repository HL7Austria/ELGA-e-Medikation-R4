CodeSystem: ElgaListEntryFlagCS
Id: at-elga-emed-codesystem-listentryflag-cs
Title: "At ELGA e-Medikation List.entry.flag CodeSystem"
Description: "CodeSystem für zulässige Ausprägungen des Flags eines List.Entries in ELGA."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
 
* #new "Neuer Planeintrag"
* #unchanged "Planeintrag beibehalten"
* #changed "Planeintrag geändert"
* #removed "Planeintrag entfernt"


ValueSet: ElgaListEntryFlagVS
Id: at-elga-emed-valueset-listentryflag-vs
Title: "ELGA List.entry.flag ValueSet"
Description: "ValueSet für zulässige Ausprägungen Ausprägungen des Flags eines List.Entries in ELGA."
* ^experimental = true
* include codes from system ElgaListEntryFlagCS