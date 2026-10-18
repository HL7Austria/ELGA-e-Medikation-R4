Profile: AtElgaEmedDosageFreeTextAdministration
Parent: AtElgaEmedDosageDosierung
Id: at-elga-emed-dosage-freetext-administration
Title: "AT ELGA e-Medikation Freitext-Dosierschema"
Description: "Profil für das Freitext-Dosierschema"

* extension[DosageCategory].valueCodeableConcept.coding.code = #freitext 
* text 1..1 MS
* timing.repeat.period 0..0
* timing.repeat.periodUnit 0..0
* timing.repeat.periodMax 0..0
* timing.repeat.dayOfWeek 0..0
* timing.repeat.when 0..0
* timing.repeat.duration 0..0
* timing.repeat.durationMax 0..0
* timing.repeat.durationUnit 0..0
* timing.repeat.frequency 0..0
* timing.repeat.frequencyMax 0..0
* timing.repeat.timeOfDay 0..0
* timing.repeat.extension[dayOfMonth] 0..0
* asNeeded[x] 0..0
