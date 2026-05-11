Profile: AtElgaEmedTimingZeiten
Parent: Timing
Id: at-elga-emed-timing-zeiten
Title: "AT ELGA e-Medikation Timing Zeiten"
Description: "AT ELGA e-Medikation Timing Zeiten"

* event 0..* MS
* event ^short = "Zeitpunkt der Einnahme." //TODO: Mapping /effectiveTime[1]/@value"

* repeat 0..1 MS
* repeat ^short = "Wiederholungsangaben zur Einnahme"

* repeat.boundsPeriod.start ^short = "Zeitraum der Einnahme: Start." // TODO:Mapping /effectiveTime[1]/low"
* repeat.boundsPeriod.end ^short = "Zeitraum der Einnahme: Ende." // TODO:Mapping /effectiveTime[1]/high"

* repeat.frequency ^short = "Häufigkeit der Einnahme, z.B. 3 mal täglich." 
//TODO:Periodic Frequency /effectiveTime[operator=\"A\" and xsi:type=\"PIVL_TS\"] …/@institutionSpecified …/period/@value …/period/@unit"
* repeat.period 0..1 MS
* repeat.period ^short = "Intervall der Einnahme, z.B. alle 4 Stunden."

* repeat.periodUnit from $vs-medikationfrequenz (required)
* repeat.periodUnit ^short = "Einheit des Intervalls der Einnahme, z.B. h für Stunden, d für Tage."

* repeat.when MS
* repeat.when from $vs-einnahmezeitpunkte (required) // morgens, abends
* repeat.offset MS
