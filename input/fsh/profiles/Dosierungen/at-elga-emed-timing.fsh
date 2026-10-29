Profile: AtElgaEmedTiming
Parent: Timing
Id: at-elga-emed-timing
Title: "AT ELGA e-Medikation Timing"
Description: "AT ELGA e-Medikation Timing"

* modifierExtension 0..0
* modifierExtension ^short = "Fachliche Begründung: Für den Medikationsplan sind keine zusätzlichen Erweiterungen vorgesehen, die die Bedeutung der Ressource oder ihrer Elemente verändern."

* event 0..* MS
* event ^short = "Event im Alltag des Patienten auf das sich das Timing bezieht z.b. OP-Termin"

* repeat 0..1 MS
* repeat ^short = "Wiederholungsangaben des Timings"

* repeat.extension contains TimingDayOfMonth named TimingDayOfMonth 0..1 MS
* repeat.extension MS

* repeat.bounds[x] MS
* repeat.boundsPeriod MS
* repeat.boundsPeriod.start MS
* repeat.boundsPeriod.end MS
* repeat.boundsPeriod.start ^short = "Start des Begrenzungszeitraums" // TODO:Mapping /effectiveTime[1]/low"
* repeat.boundsPeriod.end ^short = "Ende des Begrenzungszeitraums" // TODO:Mapping /effectiveTime[1]/high"

* repeat.boundsDuration MS
* repeat.boundsDuration.system 1..1 MS
* repeat.boundsDuration.unit 1..1 MS
* repeat.boundsDuration.code 1..1 MS
* repeat.boundsDuration.value 1..1 MS
* repeat.boundsDuration.comparator 0..0
* repeat.boundsDuration.comparator ^short = "Fachliche Begründung: TODO"

* repeat.boundsRange MS
* repeat.boundsRange.high MS
* repeat.boundsRange.high.system 1..1 MS
* repeat.boundsRange.high.unit 1..1 MS
* repeat.boundsRange.high.code 1..1 MS
* repeat.boundsRange.high.value 1..1 MS
* repeat.boundsRange.high.comparator 0..0
* repeat.boundsRange.high.comparator ^short = "Fachliche Begründung: TODO"
* repeat.boundsRange.low MS
* repeat.boundsRange.low.system 1..1 MS
* repeat.boundsRange.low.unit 1..1 MS
* repeat.boundsRange.low.code 1..1 MS
* repeat.boundsRange.low.value 1..1 MS
* repeat.boundsRange.low.comparator 0..0
* repeat.boundsRange.low.comparator ^short = "Fachliche Begründung: TODO"

* repeat.dayOfWeek MS
* repeat.duration MS
* repeat.durationMax MS
* repeat.durationUnit MS
* repeat.timeOfDay MS

* repeat.frequency ^short = "Häufigkeit der Einnahme, z.B. 3 mal täglich." 
* repeat.frequency MS
//TODO:Periodic Frequency /effectiveTime[operator=\"A\" and xsi:type=\"PIVL_TS\"] …/@institutionSpecified …/period/@value …/period/@unit"
* repeat.period 0..1 MS
* repeat.period ^short = "Intervall der Einnahme, z.B. alle 4 Stunden."

* repeat.periodUnit from $vs-medikationfrequenz (required)
* repeat.periodUnit ^short = "Einheit des Intervalls der Einnahme, z.B. h für Stunden, d für Tage."
* repeat.periodUnit MS

* repeat.periodMax MS
* repeat.count MS
* repeat.countMax MS
* repeat.when MS
//* repeat.when from $vs-einnahmezeitpunkte (required) // morgens, abends
// das verlinkte ValueSet enthält derzeit nur die codes für vor den Mahlzeiten
* repeat.offset MS
