CodeSystem: AtElgaEmedCodeSystemDosageCategory
Id: at-elga-emed-codesystem-dosagecategory-cs
Title: "AT ELGA e-Medikation Dosage Category Status CodeSystem"
Description: "Zulässige Ausprägungen der Kategorie einer Dosierung in ELGA."
* ^status = #active
* ^experimental = true
* ^caseSensitive = false
* #timed "Timed Administration"
* #frequency "Frequency Administration"
* #other "Other" //Temporary for testing purposes
* #freitext
* #standard "Standard Administration"


ValueSet: AtElgaEmedValueSetDosageCategory
Id: at-elga-emed-valueset-dosagecategory-vs
Title: "AT ELGA e-Medikation Dosage Category Status ValueSet"
Description: "Zulässige Ausprägungen der Kategorie einer Dosierung in ELGA."
* ^status = #active
* ^experimental = true
* include codes from system AtElgaEmedCodeSystemDosageCategory


