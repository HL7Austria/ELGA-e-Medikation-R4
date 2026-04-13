CodeSystem: ElgaListEntryFlagCS
Title: "ELGA List.entry.flag CodeSystem"
Description: "CodeSystem für zulässige Ausprägungen des Flags eines List.Entries in ELGA."
* ^status = #active
* ^experimental = true
 
* #new "Neuer Planeintrag"
* #unchanged "Planeintrag beibehalten"
* #changed "Planeintrag geändert"
* #removed "Planeintrag entfernt"


ValueSet: ElgaListEntryFlagVS
Title: "ELGA List.entry.flag Value Set"
Description: "ValueSet für zulässige Ausprägungen Ausprägungen des Flags eines List.Entries in ELGA."
* ^experimental = true
* include codes from system ElgaListEntryFlagCS