{% include styleheader.md %}
<style>
 #segment-content .inner-wrapper div[markdown="1"][style*="display:inline-block"] {
  display: block !important;
  width: auto !important;
  box-sizing: border-box;
}
</style>

<div class="dragon">
<p class="note-to-balloters">
Offene Punkte:<br>
In Arbeit.
(doseAndRate in Textdarstellung,...)
</p>
</div>


<h3 class="no-number">Regeln für Standarddosierungen im Tageszeitenschema</h3>

<p>
  Dieses Profil repräsentiert strukturierte, wiederkehrende Dosierungen anhand
  von Tageszeiten. Die Dosierungskategorie ist immer
  <code>standard</code>.
</p>

<h4 class="no-number">Grundregeln</h4>

<ul>
  <li>
    <code>timing.repeat.when</code> ist verpflichtend und enthält mindestens
    eine zulässige Tageszeit aus
    <code>ElgaTimingWhenStandardAdministrationVS</code>.
  </li>
  <li>
    <code>timing.repeat.frequency</code>,
    <code>timing.repeat.period</code> und
    <code>timing.repeat.periodUnit</code> sind verpflichtend.
  </li>
  <li>
    <code>frequencyMax</code> und <code>periodMax</code> dürfen nicht verwendet
    werden. Eine Tageszeitendosierung beschreibt daher keine Häufigkeits- oder
    Intervallspanne.
  </li>
  <li>
    <code>timeOfDay</code> darf nicht verwendet werden. Exakte Uhrzeiten werden
    durch dieses Profil bewusst nicht unterstützt, da sie der Semantik einer
    Tageszeit widersprechen können.
  </li>
  <li>
    Eine Tageszeit darf innerhalb einer Dosierung nur einmal vorkommen.
  </li>
  <li>
    Ein Wochentag darf innerhalb einer Dosierung nur einmal vorkommen.
  </li>
</ul>

<h4 class="no-number">Regeln für tägliche Dosierungen</h4>

<p>
  Bei Dosierungen mit <code>timing.repeat.periodUnit = d</code> entspricht <code>timing.repeat.frequency</code> der Anzahl der angegebenen Tageszeiten.
  Bei <code>period = 1</code> wird die Dosierung als täglich dargestellt;
  bei <code>period &gt; 1</code> als Intervall in Tagen.
</p>

<p><strong>Beispiel: 1 Stück morgens und 1 Stück nachts</strong></p>

<ul>
<li>Textdarstellung: <code>1-0-0-1 | Täglich: 1-0-0-1</code></li>
<li><code>Dosage.timing.repeat.frequency / period / periodUnit</code> = <code>2 / 1 / d</code></li>
<li><code>Dosage.timing.repeat.when</code> = <code>[MORN, NIGHT]</code></li>
<li><code>doseQuantity.value</code> = <code>1</code>, <code>doseQuantity.unit</code> = <code>Stück</code></li>
</ul>

<div class="tabs">
    <div class="tab">
        <input type="radio" id="tab-structure-daily-administration-1" name="tab-group-daily-administration-1" checked="true" />
        <label for="tab-structure-daily-administration-1" class="request-tab">Structure</label>
        <div class="content-in-tab">
            
            <pre><code>Dosage
    timing
        repeat
        frequency: 2
        period: 1
        periodUnit: d
        when: MORN (morgens) | NIGHT (nachts)
        doseAndRate
        doseQuantity
        value: 1
        unit: Stück</code></pre>
  </div>
    </div>
    <div class="tab">
        <input type="radio" id="tab-json-daily-administration-1" name="tab-group-daily-administration-1" />
        <label for="tab-json-daily-administration-1">JSON</label>
        <div class="content-in-tab">
            <pre><code class="language-json">{
  "timing": {
    "repeat": {
      "frequency": 2,
      "period": 1,
      "periodUnit": "d",
      "when": ["MORN", "NIGHT"]
    }
  },
  "doseAndRate": [{
    "doseQuantity": {
      "value": 1,
      "unit": "Stück"
    }
  }]
}</code></pre>
        </div>
    </div>
</div>

<p>
  Das Muster entspricht der Darstellung <code>1-0-0-1</code>. Die
  <code>frequency</code> ist <code>2</code>, da zwei Tageszeiten angegeben
  sind.
</p>

<h4 class="no-number">Regeln für wöchentliche Dosierungen</h4>

<p>
  Werden Wochentage in <code>timing.repeat.dayOfWeek</code> angegeben, muss
  <code>timing.repeat.periodUnit</code> den Wert <code>wk</code> haben.
  Die <code>frequency</code> entspricht dann dem Produkt aus der Anzahl der
  Tageszeiten und der Anzahl der Wochentage.
</p>

<p><strong>Beispiel: montags und freitags jeweils 1-0-0-1</strong></p>

<ul>
  <li>
    Textdarstellung:
    <code>Mo 1-0-0-1, Fr 1-0-0-1 | Wöchentlich: 1-0-0-1 am Montag, 1-0-0-1 am Freitag</code>
  </li>
  <li><code>Dosage.timing.repeat.frequency / period / periodUnit</code> = <code>4 / 1 / wk</code></li>
  <li><code>Dosage.timing.repeat.dayOfWeek</code> = <code>mon</code> (Montag), <code>fri</code> (Freitag)</li>
  <li><code>Dosage.timing.repeat.when</code> = <code>MORN</code> (morgens), <code>NIGHT</code> (nachts)</li>
</ul>

<div class="tabs">
<div class="tab">
<input type="radio" id="tab-structure-weekly-administration-1" name="tab-group-weekly-administration-1" checked="true" />
<label for="tab-structure-weekly-administration-1" class="request-tab">Structure</label>
<div class="content-in-tab">

<pre><code>Dosage
timing
  repeat
    frequency: 4
    period: 1
    periodUnit: wk
    dayOfWeek: mon (Montag)
    dayOfWeek: fri (Freitag)
    when: MORN (morgens) | NIGHT (nachts)</code></pre>
</div>
</div>
<div class="tab">
<input type="radio" id="tab-json-weekly-administration-1" name="tab-group-weekly-administration-1" />
<label for="tab-json-weekly-administration-1">JSON</label>
<div class="content-in-tab">
<pre><code class="language-json">{
"timing": {
    "repeat": {
        "frequency": 4,
        "period": 1,
        "periodUnit": "wk",
        "dayOfWeek": ["mon", "fri"],
        "when": ["MORN", "NIGHT"]
    }
} }</code></pre>
</div>
</div>
</div>

<p>
  Die Dosierung erfolgt zweimal pro ausgewähltem Wochentag und damit insgesamt
  viermal pro Woche.
</p>


<h4 class="no-number">Regeln für monatliche Dosierungen</h4>

<p>
  Werden Kalendertage des Monats in <code>timing.repeat.extension:timing-dayOfMonth</code> angegeben, muss
  <code>timing.repeat.periodUnit</code> den Wert <code>mo</code> haben.
  Die <code>frequency</code> entspricht dann dem Produkt aus der Anzahl der
  dayOfMonth Extensions und der Anzahl der Tageszeiten.
</p>
 <p>Beispiel: <strong>1-0-0-0 am ersten Tag jedes Monats</strong>
</p>

<ul>
<li><code>Dosage.timing.repeat.frequency / period / periodUnit</code> = <code>1 / 1 / m</code></li>
<li><code>Dosage.timing.repeat.extension:timing-dayOfMonth.valuePositiveInt</code> = <code>1</code></li>
<li><code>Dosage.timing.repeat.when</code> = <code>MORN</code> (morgens)</li>
</ul>


<div class="tabs">
<div class="tab">
<input type="radio" id="tab-structure-monthly-administration-1" name="tab-group-monthly-administration-1" checked="true" />
<label for="tab-structure-monthly-administration-1" class="request-tab">Structure</label>
<div class="content-in-tab">
<pre><code>Dosage
timing
  repeat
    frequency: 1
    period: 1
    periodUnit: m
    extension: timing-dayOfMonth
      valuePositiveInt: 1
    when: MORN (morgens)</code></pre>
</div>
</div>
<div class="tab">
<input type="radio" id="tab-json-monthly-administration-1" name="tab-group-monthly-administration-1" />
<label for="tab-json-monthly-administration-1">JSON</label>
<div class="content-in-tab">
<pre><code class="language-json">{
  "timing": {
    "repeat": {
      "frequency": 1,
      "period": 1,
      "periodUnit": "m",
      "extension": [
        {
        "url": "http://hl7.org/fhir/StructureDefinition/timing-dayOfMonth",
        "valuePositiveInt": 1
        }
      ],
      "when": ["MORN"]
    }
  }
}</code></pre>
</div>
</div>
</div>


<h4 class="no-number">Unterschiedliche Dosierungen je Tageszeit</h4>

<p>
  Unterschiedliche Einnahmemuster zu unterschiedlichen Tageszeiten werden durch
  mehrere <code>Dosage</code>-Einträge mit der selben Sequenznummer ausgedrückt. Eine einzelne Dosierung kann
  nicht abbilden, dass zu unterschiedlichen Tageszeiten unterschiedliche Mengen gelten.
</p>

<p>
  Beispiel: <strong>2 Tabletten morgens und 1 Tablette nachts</strong>.
  Beide Dosierungsanweisungen gehören zur selben Einnahmeregel und erhalten daher
  dieselbe Sequenznummer.
</p>

<ul>
  <li>
    Erste <code>Dosage</code>: <code>sequence = 1</code>,
    <code>when = [MORN]</code>, <code>frequency = 1</code>,
    <code>period = 1</code>, <code>periodUnit = d</code>,
    <code>doseQuantity.value = 2</code> Tabletten.
  </li>
  <li>
    Zweite <code>Dosage</code>: <code>sequence = 1</code>,
    <code>when = [NIGHT]</code>, <code>frequency = 1</code>,
    <code>period = 1</code>, <code>periodUnit = d</code>,
    <code>doseQuantity.value = 1</code> Tablette.
  </li>
</ul>

<div class="tabs">
<div class="tab">
<input type="radio" id="tab-structure-different-times-1" name="tab-group-different-times-1" checked="true" />
<label for="tab-structure-different-times-1" class="request-tab">Structure</label>
<div class="content-in-tab">
<pre><code>Dosage [0]
  sequence: 1
  extension: DosageCategory
    valueCodeableConcept
      coding
        system: [canonical]/CodeSystem/at-elga-emed-dosage-category
        code: standard
  timing
    repeat
      frequency: 1
      period: 1
      periodUnit: d
      when: MORN (morgens)
  doseAndRate
    doseQuantity
      value: 2
      system: https://termgit.elga.gv.at/CodeSystem/ucum
      code: {Stueck}
      unit: Tablette

Dosage [1]
  sequence: 1
  extension: DosageCategory
    valueCodeableConcept
      coding
        system: [canonical]/CodeSystem/at-elga-emed-dosage-category
        code: standard
  timing
    repeat
      frequency: 1
      period: 1
      periodUnit: d
      when: NIGHT (nachts)
  doseAndRate
    doseQuantity
      value: 1
      system: https://termgit.elga.gv.at/CodeSystem/ucum
      code: {Stueck}
      unit: Tablette</code></pre>
</div>
</div>
<div class="tab">
<input type="radio" id="tab-json-different-times-1" name="tab-group-different-times-1" />
<label for="tab-json-different-times-1">JSON</label>
<div class="content-in-tab">
<pre><code class="language-json">[
  {
    "sequence": 1,
    "extension": [
      {
        "url": "[canonical]/StructureDefinition/at-elga-emed-dosage-category",
        "valueCodeableConcept": {
          "coding": [
            {
              "system": "[canonical]/CodeSystem/at-elga-emed-dosage-category",
              "code": "standard"
            }
          ]
        }
      }
    ],
    "timing": {
      "repeat": {
        "frequency": 1,
        "period": 1,
        "periodUnit": "d",
        "when": ["MORN"]
      }
    },
    "doseAndRate": [
      {
        "doseQuantity": {
          "value": 2,
          "system": "https://termgit.elga.gv.at/CodeSystem/ucum",
          "code": "{Stueck}",
          "unit": "Tablette"
        }
      }
    ]
  },
  {
    "sequence": 1,
    "extension": [
      {
        "url": "[canonical]/StructureDefinition/at-elga-emed-dosage-category",
        "valueCodeableConcept": {
          "coding": [
            {
              "system": "[canonical]/CodeSystem/at-elga-emed-dosage-category",
              "code": "standard"
            }
          ]
        }
      }
    ],
    "timing": {
      "repeat": {
        "frequency": 1,
        "period": 1,
        "periodUnit": "d",
        "when": ["NIGHT"]
      }
    },
    "doseAndRate": [
      {
        "doseQuantity": {
          "value": 1,
          "system": "https://termgit.elga.gv.at/CodeSystem/ucum",
          "code": "{Stueck}",
          "unit": "Tablette"
        }
      }
    ]
  }
]</code></pre>
</div>
</div>
</div>

<p>
  Die Darstellung <code>2-0-0-1</code> ist damit nicht eine einzelne
  <code>Dosage</code> mit zwei Tageszeiten, sondern besteht aus zwei
  <code>Dosage</code>-Einträgen: einer morgendlichen Dosis von zwei Tabletten
  und einer nächtlichen Dosis von einer Tablette.
</p>


<h4 class="no-number">Unterschiedliche Dosierungen je Wochentag</h4>

<p>
  Unterschiedliche Einnahmemuster an unterschiedlichen Wochentagen werden durch
  mehrere <code>Dosage</code>-Einträge mit der selben Sequenznummer ausgedrückt. Eine einzelne Dosierung kann
  nicht abbilden, dass an einem Wochentag andere Tageszeiten oder Mengen gelten
  als an einem anderen.
</p>

<p>Beispiel: montags morgens und nachts, freitags nur morgens.</p>

<ul>
  <li>
    Erste <code>Dosage</code>: Montag, <code>when = [MORN, NIGHT]</code>,
    <code>frequency = 2</code>, <code>periodUnit = wk</code>.
  </li>
  <li>
    Zweite <code>Dosage</code>: Freitag, <code>when = [MORN]</code>,
    <code>frequency = 1</code>, <code>periodUnit = wk</code>.
  </li>
</ul>


<h3 class="no-number">Beispiele</h3>

<h4 class="no-number">Zulässige Beispiele</h4>

<ul>
  <li>
    <b>1-0-0-1 | Täglich: 1-0-0-1</b>
    <code>frequency = 2</code>, <code>period = 1</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Alle 2 Tage: 1-0-0-1 | Alle 2 Tage: 1-0-0-1</b>
    <code>frequency = 2</code>, <code>period = 2</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>
  </li>
   <li>
    <b>Alle X Tage: 1-0-0-1 | Alle X Tage: 1-0-0-1</b>
    <code>frequency = 2</code>, <code>period = X</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Mo 1-0-0-1, Fr 1-0-0-1 | Wöchentlich: 1-0-0-1 am Montag, 1-0-0-1 am Freitag</b>
    <code>frequency = 4</code>, <code>period = 1</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon, fri]</code>,
    <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Mo 1-0-0-1, Fr 1-0-0-0 | Wöchentlich: 1-0-0-1 am Montag, 1-0-0-0 am Freitag</b>
    <br>
    Dosage 1:
    <br>
    <code>frequency = 2</code>, <code>period = 1</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon]</code>,
    <code>when = [MORN, NIGHT]</code>
    <br>
    Dosage 2:
    <br>
    <code>frequency = 1</code>, <code>period = 1</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [fri]</code>,
    <code>when = [MORN]</code>
  </li>
  <li>
    <b>Alle 2 Wochen: Mo 1-0-0-1 | Alle 2 Wochen: 1-0-0-1 am Montag</b>
    <code>frequency = 2</code>, <code>period = 2</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon]</code>,
    <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Alle 2 Wochen: Mo 1-0-0-1, Fr 1-0-0-1 | Alle 2 Wochen: 1-0-0-1 am Montag, 1-0-0-1 am Freitag</b>
    <code>frequency = 4</code>, <code>period = 2</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon, fri]</code>,
    <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Bei Bedarf: 1-0-0-1 | Bei Bedarf, täglich: 1-0-0-1</b>
    <code>asNeeded = true</code>,
    <code>frequency = 2</code>, <code>period = 1</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>
  </li>
    <li>
    <b>Bei Bedarf, alle 2 Tage: 1-0-0-1 | Bei Bedarf, alle 2 Tage: 1-0-0-1</b>
    <code>asNeeded = true</code>,
    <code>frequency = 2</code>, <code>period = 2</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>Alle 3 Wochen: Mo 1-0-0-1, Fr 1-0-0-1 | Alle 3 Wochen: 1-0-0-1 am Montag, 1-0-0-1 am Freitag</b>
    <code>frequency = 4</code>, <code>period = 3</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon, fri]</code>,
    <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>1-0-0-1 am 1. des Monats, 1-0-0-1 am 10. des Monats | Monatlich: 1-0-0-1 am 1., 1-0-0-1 am 10. des Monats</b>
    <code>frequency = 4</code>, <code>period = 1</code>,
    <code>periodUnit = mo</code>, <code>extension:DayOfMonth = 1 & 10</code>,
    <code>when = [MORN, NIGHT]</code>
  </li>
  <li>
    <b>1-0-0-1 am 1. des Monats, 0-1-0-0 am 15. des Monats | Monatlich: 1-0-0-1 am 1. und 0-1-0-0 am 15. des Monats</b>
    <br>
    Dosage 1:
    <br>
    <code>frequency = 2</code>, <code>period = 1</code>,
    <code>periodUnit = mo</code>, <code>extension:DayOfMonth = 1</code>,
    <code>when = [MORN, NIGHT]</code>
    <br>
    Dosage 2:
    <br>
    <code>frequency = 1</code>, <code>period = 1</code>,
    <code>periodUnit = mo</code>, <code>extension:DayOfMonth = 15</code>,
    <code>when = [NOON]</code>
  </li>
   <li>
    <b>Alle 3 Monate: 1-0-0-0 am 1. des Monats</b>
  </li>
  <li>
    <b>Alle 2 Monate: 1-0-0-0 am 1. des Monats, 1-0-0-0 am 15. des Monats</b>
  </li>
</ul>

<h4 class="no-number">Nicht zulässige Muster</h4>

<ul>
  <li>
    <code>1-0-0-0 täglich um 07:00</code> oder
    <code>1-0-0-0 täglich um 17:00</code>: Exakte Uhrzeiten dürfen in diesem Schema nicht über
    <code>timeOfDay</code> angegeben werden. Es kann ausschließlich eine
    zulässige Tageszeit, beispielsweise <code>MORN</code>, ausgedrückt werden. Für genau Uhrzeit muss das Uhrzeiten Dosierungsschema verwendet werden. TODO: Link einfügen.
  </li>
  <li>
    <code>1-0-0-1 zweimal täglich alle zwei Tage, montags und freitags</code>:
    nicht zulässig. Die Kombination aus <code>dayOfWeek</code> und einer
    täglichen Periodeneinheit ist nicht erlaubt, da sich die Aussagen widersprechen können.
  </li>
  <li>
    Eine Tageszeit mehrfach anzugeben, beispielsweise
    <code>when = [MORN, MORN]</code>: nicht zulässig.
  </li>
  <li>
    Einen Wochentag mehrfach anzugeben, beispielsweise
    <code>dayOfWeek = [mon, mon]</code>: nicht zulässig.
  </li>
  <li>
    <code>1-1-1-1 alle 2 Stunden</code>: Dieses Profil ist für
    Tageszeitenschemata vorgesehen und nicht für stündliche Intervalle. Dosierschemata mit Zeitintervallen sind in diesem Profil TBD LINK definiert.
  </li>
  <li>
    <code>Alle 2 Wochen: Mo 1-0-0-1, Fr 1-0-0-0</code> als einzelner
    <code>Dosage</code>-Eintrag mit <code>dayOfWeek = [mon, fri]</code> und
    <code>when = [MORN, NIGHT]</code>: nicht zulässig. Unterschiedliche
    Tageszeitenschemata je Wochentag erfordern getrennte
    <code>Dosage</code>-Einträge mit derselben <code>sequence</code>.
  </li>

  <li>
    <code>1-0-0-1 am 1. des Monats, 0-1-0-0 am 15. des Monats</code> als
    einzelner <code>Dosage</code>-Eintrag mit zwei Kalendertagen: nicht zulässig,
    wenn die Tageszeitenschemata unterschiedlich sind. In diesem Fall sind zwei
    <code>Dosage</code>-Einträge erforderlich.
  </li>
</ul>


<h3 class="no-number">Bildung der Textdarstellung</h3>

<p>
Die Textdarstellung wird je Einnahmeregel gebildet. Alle
<code>Dosage</code>-Einträge mit derselben <code>sequence</code> und derselben
Dosierungskategorie gehören zu derselben Einnahmeregel. Unterschiedliche
Sequenznummern ergeben getrennte Einnahmeregeln.
</p>

<p>
Die Darstellung besteht, sofern möglich, aus Kurz- und Langform. Beide Teile
werden durch <code> | </code> getrennt.
</p>

<h4 class="no-number">Grundsatz</h4>

<p>
Die Textdarstellung verwendet das Tageszeitenschema
<code>MORN-NOON-EVE-NIGHT</code>. Die vier Positionen stehen für morgens,
mittags, abends und nachts. Nicht belegte Tageszeiten werden mit
<code>0</code> dargestellt.
</p>

<p>
Die Menge in einer Position entspricht unmittelbar dem Wert von
<code>doseAndRate.doseQuantity.value</code> des zugehörigen
<code>Dosage</code>-Eintrags. Mengen werden nicht über mehrere
<code>Dosage</code>-Einträge hinweg addiert oder aus
<code>frequency</code>-Werten berechnet.
</p>

<h4 class="no-number">Kurzform</h4>

<p>
Die Kurzform gibt das Tageszeitenschema für jede zeitlich unterschiedliche
Ausprägung der Einnahmeregel an.
</p>

<ul>
  <li>
    Bei täglicher Dosierung wird nur das Tageszeitenschema ausgegeben,
    beispielsweise <code>1-0-0-1</code>.
  </li>
  <li>
    Bei einem Intervall in Tagen steht die Intervallangabe vor dem
    Tageszeitenschema, beispielsweise <code>Alle 2 Tage: 1-0-0-1</code>.
  </li>
  <li>
    Bei Wochentagen steht die Wochentagsabkürzung vor dem jeweiligen
    Tageszeitenschema, beispielsweise
    <code>Mo 1-0-0-1, Fr 1-0-0-1</code>.
  </li>
  <li>
    Bei Wochenintervallen steht die Intervallangabe vor den Wochentagen,
    beispielsweise <code>Alle 2 Wochen: Mo 1-0-0-1</code>.
  </li>
  <li>
    Bei Kalendertagen steht der Kalendertag nach dem jeweiligen
    Tageszeitenschema, beispielsweise
    <code>1-0-0-0 am 1. des Monats</code>.
  </li>
</ul>

<h4 class="no-number">Langform</h4>

<p>
Die Langform beginnt mit der Wiederholungsangabe. Anschließend wird das
Tageszeitenschema je Wochentag oder Kalendertag ausgegeben. Zwischen
Wiederholungsangabe und Dosierschema steht ein Doppelpunkt.
</p>

<h5 class="no-number">Tägliche Dosierung</h5>

<pre><code>Täglich: {MORN-NOON-EVE-NIGHT}</code></pre>

<p>
Beispiel:
<code>1-0-0-1 | Täglich: 1-0-0-1</code>.
</p>

<h5 class="no-number">Tagesintervall</h5>
Bei einer <code>period</code> >1:
<pre><code>Alle {period} Tage: {MORN-NOON-EVE-NIGHT}</code></pre>

<p>
Beispiel:
<code>Alle 2 Tage: 1-0-0-1 | Alle 2 Tage: 1-0-0-1</code>.
</p>

<h5 class="no-number">Wöchentliche Dosierung</h5>

<pre><code>Wöchentlich: {MORN-NOON-EVE-NIGHT} am {Wochentag}</code></pre>

<p>
Beispiel:
<code>Mo 1-0-0-1, Fr 1-0-0-1 | Wöchentlich: 1-0-0-1 am Montag, 1-0-0-1 am Freitag</code>.
</p>

<h5 class="no-number">Wochenintervall</h5>
Bei einer <code>period</code> >1:
<pre><code>Alle {period} Wochen: {MORN-NOON-EVE-NIGHT} am {Wochentag}</code></pre>

<p>
Beispiel:
<code>Alle 2 Wochen: Mo 1-0-0-1 | Alle 2 Wochen: 1-0-0-1 am Montag</code>.
</p>

<h5 class="no-number">Monatliche Dosierung</h5>

<pre><code>Monatlich: {MORN-NOON-EVE-NIGHT} am {extension:dayOfMonth}. des Monats</code></pre>

<p>
Beispiel:
<code>1-0-0-1 am 1. des Monats, 1-0-0-1 am 10. des Monats | Monatlich: 1-0-0-1 am 1. des Monats, 1-0-0-1 am 10. des Monats</code>.
</p>

<h5 class="no-number">Monatsintervall</h5>
Bei einer <code>period</code> >1:
<pre><code>Alle {period} Monate: {MORN-NOON-EVE-NIGHT} am {extension:dayOfMonth}. des Monats</code></pre>

<p>
Beispiel:
<code>Alle 3 Monate: 1-0-0-0 am 1. des Monats</code>.
</p>

<h5 class="no-number">Bedarfsdosierung</h5>

<p>
Bei einer Bedarfsdosierung mit <code>asNeeded = true</code> wird <code>Bei Bedarf</code> der jeweiligen Wiederholungsangabe vorangestellt.
</p>

<pre><code>Bei Bedarf, täglich: {MORN-NOON-EVE-NIGHT}</code></pre>

<p>
Beispiele:
<code>Bei Bedarf: 1-0-0-1 | Bei Bedarf, täglich: 1-0-0-1</code> und
<code>Bei Bedarf, alle 2 Tage: 1-0-0-1 | Bei Bedarf, alle 2 Tage: 1-0-0-1</code>.
</p>