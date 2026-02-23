Profile: AtEmedTiming
Parent: Timing
Id: at-emed-timing
Title: "ELGA e-Med Timing"
Description: "**Beschreibung:** ELGA e-Med Timing"

* event 0..* MS
* event ^short = "Zeitpunkt der Einnahme: Mapping /effectiveTime[1]/@value"

* repeat 0..1 MS
* repeat ^short = "Wiederholungsangaben zur Einnahme"

* repeat.boundsPeriod.start ^short = "Zeitraum der Einnahme: Start. Mapping /effectiveTime[1]/low"
* repeat.boundsPeriod.end ^short = "Zeitraum der Einnahme: Ende. Mapping /effectiveTime[1]/high"

* repeat.frequency ^short = "Häufigkeit der Einnahme, z.B. 1 mal täglich.
Periodic Frequency /effectiveTime[operator=\"A\" and xsi:type=\"PIVL_TS\"] …/@institutionSpecified …/period/@value …/period/@unit"
* repeat.period 0..1 MS
* repeat.period ^short = "Intervall der Einnahme, z.B. alle 8 Stunden."

* repeat.periodUnit from $vs-medikationfrequenz (required)
* repeat.periodUnit ^short = "Einheit des Intervalls der Einnahme, z.B. h für Stunden, d für Tage."

* repeat.when MS
* repeat.when from $vs-einnahmezeitpunkte (required) // morgens, abends
* repeat.offset MS
