Profile: AtElgaEmedTiming
Parent: Timing
Id: at-elga-emed-timing
Title: "AT ELGA e-Medikation Timing"
Description: "AT ELGA e-Medikation Timing"

* event 0..* MS
* event ^short = "Zeitpunkt der Einnahme." //TODO: Mapping /effectiveTime[1]/@value"
//TODO suche Definition -> Event im Alltag des Patienten auf das sich die Dosierung bezieht z.b. OP-Termin
* repeat 0..1 MS
* repeat ^short = "Wiederholungsangaben zur Einnahme"

* repeat.extension contains TimingDayOfMonth named TimingDayOfMonth 0..1 MS

* repeat.boundsPeriod.start ^short = "Zeitraum der Einnahme: Start." // TODO:Mapping /effectiveTime[1]/low"
* repeat.boundsPeriod.end ^short = "Zeitraum der Einnahme: Ende." // TODO:Mapping /effectiveTime[1]/high"

* repeat.frequency ^short = "Häufigkeit der Einnahme, z.B. 3 mal täglich." 
//TODO:Periodic Frequency /effectiveTime[operator=\"A\" and xsi:type=\"PIVL_TS\"] …/@institutionSpecified …/period/@value …/period/@unit"
* repeat.period 0..1 MS
* repeat.period ^short = "Intervall der Einnahme, z.B. alle 4 Stunden."

* repeat.periodUnit from $vs-medikationfrequenz (required)
* repeat.periodUnit ^short = "Einheit des Intervalls der Einnahme, z.B. h für Stunden, d für Tage."

* repeat.when MS
//* repeat.when from $vs-einnahmezeitpunkte (required) // morgens, abends
// das verlinkte ValueSet enthält derzeit nur die codes für vor den Mahlzeiten
* repeat.offset MS
