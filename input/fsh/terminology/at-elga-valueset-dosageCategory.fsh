CodeSystem: AtElgaEmedCodeSystemDosageCategory
Title: "ELGA Dosage Category Status CodeSystem"
Description: "Zulässige Ausprägungen der Kategorie einer Dosierung in ELGA."
* ^status = #active
* ^experimental = true
* #timed "Timed Administration"
* #frequency "Frequency Administration"
* #other "Other" //Temporary for testing purposes
* #freitext
* #standard "Standard Administration"


ValueSet: AtElgaEmedValueSetDosageCategory
Title: "ELGA Dosage Category Status ValueSet"
Description: "Zulässige Ausprägungen der Kategorie einer Dosierung in ELGA."
* ^status = #active
* ^experimental = true
* include codes from system AtElgaEmedCodeSystemDosageCategory


