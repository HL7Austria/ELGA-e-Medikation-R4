Profile: AtElgaEmedDosageStandardAdministration
Parent: AtElgaEmedDosageDosierung
Id: at-elga-emed-dosage-standard-administration

* extension[DosageCategory].valueCodeableConcept = AtElgaEmedCodeSystemDosageCategory#standard (exactly)
* timing.repeat.when 1..
* timing.repeat.when from ElgaTimingWhenStandardAdministrationVS

* timing.repeat.frequency 1..1 //TBD evaluate
* timing.repeat.period 1..1 
* timing.repeat.periodUnit 1..1 

* timing.repeat.frequencyMax 0..0 
* timing.repeat.periodMax 0..0

* timing.repeat.timeOfDay 0..0 // kann der Aussage von .when widersprechen
* timing.repeat.offset 0..0

* obeys frequencySameAsWhenCount
* obeys weekdaysRequireWeeklyPeriod
* obeys frequencyEqualsEventWeekdayProduct
* obeys noDuplicateWhen
* obeys noDuplicateDayOfWeek
* obeys allowedPeriodUnitsForStandardAdministration

Invariant: frequencySameAsWhenCount
Description: "wenn .when verwendet wird und periodUnit = d muss die frequency mit der Anzahl an entries in .when übereinstimmen"
Severity: #error
Expression: "(timing.repeat.when.exists() and timing.repeat.periodUnit = 'd') implies timing.repeat.when.distinct().count() = timing.repeat.frequency"

Invariant: weekdaysRequireWeeklyPeriod
Description: "DayOfWeek kann nur dann verwendet werden, wenn periodUnit 'wk' ist."
Severity: #error
Expression: "timing.repeat.dayOfWeek.exists() implies timing.repeat.periodUnit = 'wk'"

Invariant: dayOfMonthRequireMonthlyPeriod
Description: "Extension:TimingDayOfMont kann nur dann verwendet werden, wenn periodUnit 'm' ist."
Severity: #error
Expression: "timing.repeat.extension.where(url = 'http://hl7.org/fhir/StructureDefinition/timing-dayOfMonth').exists() implies timing.repeat.periodUnit = 'm'"

Invariant: frequencyEqualsEventWeekdayProduct
Description: "Wenn Wochentage angegeben sind dann entspricht die frequency dem Produkt aus Wochentagen und der Anzahl an ausgewählten Tageszeiten."
Severity: #error
Expression: "timing.repeat.when.exists() and timing.repeat.dayOfWeek.exists() implies timing.repeat.frequency = timing.repeat.when.distinct().count() * timing.repeat.dayOfWeek.distinct().count()"

Invariant: noDuplicateWhen
Description: "Tageszeiten können nicht mehrmals vorkommen."
Severity: #error
Expression: "timing.repeat.when.count() = timing.repeat.when.distinct().count()"

Invariant: noDuplicateDayOfWeek
Description: "Wochentage können nicht mehrmals vorkommen."
Severity: #error
Expression: "timing.repeat.dayOfWeek.count() = timing.repeat.dayOfWeek.distinct().count()"

Invariant: allowedPeriodUnitsForStandardAdministration
Description: "Für Standarddosierungen im Tageszeitenschema sind nur tägliche, wöchentliche oder monatliche Wiederholungen zulässig."
Severity: #error
Expression: "timing.repeat.periodUnit = 'd' or timing.repeat.periodUnit = 'wk' or timing.repeat.periodUnit = 'm'"

// day of the week (optional periodUnit w) xor day of the month (optional periodUnit m) xor periodUnit d

// wenn .dayOfWeek verwendet wird muss die frequency mit der Anzahl an entries in .dayOfWeek übereinstimmen
// wenn .dayOfWeek verwendet wird muss periodUnit w sein

// wenn .extension:TimingDayOfMonth verwendet wird muss die frequency mit der Anzahl an dayOfMonth extensions übereinstimmen

// wenn .when verwendet wird und periodUnit = d muss die frequency mit der Anzahl an entries in .when übereinstimmen

// wenn es mehrere Dosages mit der gleichen Sequenznummer gibt und die periodUnit 'd' ist darf es jede Tageszeit nur einmal geben

//optional: bounds
//optional? doseAndRate

//Beispiele:



/*
Dosage.text = 1-0-0-1 täglich | 2 Stück täglich, 1 Stück morgens und 1 Stück nachts
Kurzform: 1-0-0-1 täglich
Langform: 2 Stück täglich, 1 Stück morgens und 1 Stück nachts
Langform: {timing.repeat.frequency} {doseAndRate.unit} {timing.repeat.periodUnit}, {doseAndRate.value} {doseAndRate.unit} {timing.repeat.when[0]} und {doseAndRate.value} {doseAndRate.unit} {timing.repeat.when[1]}

:
1-0-0-1: 

*/



/*
+ möglich:
1-0-0-1 Mon, Fr wöchentlich (4x pro Woche)
1-0-0-1 Mon, 1-0-0-0 Fr wöchentlich (3x pro Woche) -> 2 Dosages
1-0-0-1 2x täglich
1-0-0-1 (2x) alle 2 Tage
1-0-0-0 am 1. des Monats (1x pro Monat)
1-0-0-0 alle 2 Wochen?
1-0-0-1 täglich bei Bedarf

ist die Kombination aus 1-0-0-1 mit einer Mahlzeit möglich?
??? 1-0-0-1 mit einer Mahlzeit (dann aber nicht validierbar, ob die beiden logisch zusammenpassen e.g. 1-0-0-0 mit dem Abendessen)
??? 1-0-0-1 mit dem Frühstück (dann aber nicht validierbar, ob die beiden logisch zusammenpassen e.g. 1-0-0-0 mit dem Abendessen)


- nicht möglich:
1-0-0-0 täglich um 17:00 (macht keinen Sinn)
1-0-0-0 täglich um 7:00 (nicht möglich weil nicht validierbar, ob die beiden logisch zusammenpassen)
1-0-0-1 2x pro Tag alle 2 Tage Mon, Fr
1-1-1-1 alle X Stunden
*/

