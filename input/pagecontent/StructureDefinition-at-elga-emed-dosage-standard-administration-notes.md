{% include styleheader.md %}
<style>
 #segment-content .inner-wrapper div[markdown="1"][style*="display:inline-block"] {
  display: block !important;
  width: auto !important;
  box-sizing: border-box;
}
</style>


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
  Bei einer Wiederholung pro Tag (täglich)
  (<code>timing.repeat.periodUnit = d</code>) muss
  <code>timing.repeat.frequency</code> der Anzahl der angegebenen
  Tageszeiten entsprechen.
</p>

<p><strong>Beispiel: 1 Stück morgens und 1 Stück nachts</strong></p>

<ul>
<li>Textdarstellung: <code>1-0-0-1 täglich | Täglich 1 Stück morgens und 1 Stück nachts</code></li>
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

<p>Beispiel: 4 mal pro Woche - morgens und nachts, jeweils montags und freitags.</p>

<ul>
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
  <code>timing.repeat.periodUnit</code> den Wert <code>m</code> haben.
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
    <code>1-0-0-1</code> täglich:
    <code>frequency = 2</code>, <code>period = 1</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>.
  </li>
  <li>
    <code>1-0-0-1</code> alle zwei Tage:
    <code>frequency = 2</code>, <code>period = 2</code>,
    <code>periodUnit = d</code>, <code>when = [MORN, NIGHT]</code>.
  </li>
  <li>
    <code>1-0-0-1</code> montags und freitags:
    <code>frequency = 4</code>, <code>period = 1</code>,
    <code>periodUnit = wk</code>, <code>dayOfWeek = [mon, fri]</code>,
    <code>when = [MORN, NIGHT]</code>.
  </li>
  <li>
    <code>1-0-0-1</code> alle zwei Wochen:
    <code>frequency = 2</code>, <code>period = 2</code>,
    <code>periodUnit = wk</code>, <code>when = [MORN, NIGHT]</code>.
  </li>
  <li>
    Bedarfsmedikation mit Tageszeiten, beispielsweise
    <code>1-0-0-1 täglich bei Bedarf</code>
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
</ul>


<h3 class="no-number">Bildung der Textdarstellung</h3>

<p>
Die Textdarstellung wird je Einnahmeregel gebildet. Alle <code>Dosage</code>-Einträge
mit derselben <code>sequence</code> und derselben Dosierungskategorie gehören zu
derselben Einnahmeregel. Unterschiedliche Sequenznummern ergeben getrennte
Einnahmeregeln.
</p>

<p>
Die Darstellung besteht, sofern möglich, aus Kurz- und Langform. Beide Teile werden
durch <code> | </code> getrennt.
</p>

<h4 class="no-number">Grundsatz</h4>

<p>
Die Langform verwendet ausschließlich Werte, die unmittelbar in den jeweiligen
<code>Dosage</code>-Einträgen vorhanden sind. Insbesondere werden keine
Gesamtmengen berechnet: Weder werden <code>frequency</code> und
<code>doseQuantity.value</code> miteinander multipliziert, noch werden Mengen aus
mehreren Dosage-Einträgen zu einer Gesamtmenge addiert.
</p>

<p>
Die Mengenangabe vor einem Einnahmezeitpunkt entspricht deshalb immer direkt
<code>doseAndRate.doseQuantity.value</code> und
<code>doseAndRate.doseQuantity.unit</code> des betreffenden Dosage-Eintrags.
</p>

<h4 class="no-number">Kurzform</h4>

<p>
Die Kurzform verwendet vier feste Positionen in der Reihenfolge
<strong>morgens – mittags – abends – nachts</strong>:
<code>MORN-NOON-EVE-NIGHT</code>. Jede Position enthält die an dieser Tageszeit
einzunehmende Menge; nicht belegte Positionen werden als <code>0</code> dargestellt.
</p>

<p>
Dosage-Einträge derselben Einnahmeregel werden für die Kurzform anhand ihrer
Tageszeit zusammengeführt. Beispielsweise ergibt ein Eintrag mit
<code>when = [MORN]</code> und <code>doseQuantity.value = 1</code> sowie ein
Eintrag mit <code>when = [EVE]</code> und <code>doseQuantity.value = 2</code>
die Kurzform <code>1-0-2-0</code>.
</p>

<ul>
<li><code>MORN</code> entspricht der ersten Position, zum Beispiel <code>1-0-0-0</code>.</li>
<li><code>NOON</code> entspricht der zweiten Position, zum Beispiel <code>0-1-0-0</code>.</li>
<li><code>EVE</code> entspricht der dritten Position, zum Beispiel <code>0-0-1-0</code>.</li>
<li><code>NIGHT</code> entspricht der vierten Position, zum Beispiel <code>0-0-0-1</code>.</li>
<li>Bei einer täglichen Regel wird <code>täglich</code> angefügt, beispielsweise <code>1-0-0-1 täglich</code>.</li>
<li>Bei einem täglichen Intervall wird die Periode angefügt, beispielsweise <code>1-0-0-1 alle 2 Tage</code>.</li>
<li>Bei ausgewählten Wochentagen werden die strukturierten Wochentagscodes angefügt, beispielsweise <code>1-0-0-1 mon, fri wöchentlich</code>.</li>
<li>Bei ausgewählten Kalendertagen werden diese angefügt, beispielsweise <code>1-0-0-0 am 1. des Monats monatlich</code>.</li>
</ul>

<h4 class="no-number">Langform</h4>

<p>
Die Langform nennt die Mengen je Einnahmezeitpunkt. Die Einnahmezeitpunkte werden
in der Reihenfolge <strong>morgens – mittags – abends – nachts</strong> dargestellt.
Anschließend folgen gegebenenfalls Wochentage oder Kalendertage.
</p>

<h5 class="no-number">Tägliche Dosierung</h5>

<p>
Für eine tägliche Dosierung mit <code>period = 1</code> wird die gemeinsame
Wiederholung einmal als <code>täglich</code> ausgegeben. Alle Dosage-Einträge
derselben Einnahmeregel werden anschließend in einer Zeile dargestellt. Dabei wird
keine Gesamtmenge und keine Gesamtfrequenz berechnet.
</p>

<pre><code>Täglich {Menge} {Einheit} morgens und {Menge} {Einheit} nachts</code></pre>

<p>
Beispiel mit einer Dosierung:
<code>1-0-0-1 täglich | Täglich 1 Stück morgens und 1 Stück nachts</code>.
</p>

<p>
Beispiel mit unterschiedlichen Mengen in mehreren Dosage-Einträgen derselben
Sequenz:
<code>2-0-1-2 täglich | Täglich 2 Stück morgens, 1 Stück abends und 2 Stück nachts</code>.
</p>

<h5 class="no-number">Wöchentliche Dosierung</h5>

<p>
Für eine wöchentliche Dosierung mit <code>period = 1</code> wird die Wiederholung
einmal als <code>Wöchentlich</code> ausgegeben. Die Wochentage stehen vor den
zugehörigen Einnahmezeitpunkten.
</p>

<pre><code>Wöchentlich montags {Menge} {Einheit} morgens und {Menge} {Einheit} nachts</code></pre>
<code> Mo: 1-0-0-1 | Wöchentlich montags 1 Stück morgens und 1 Stück nachts</code>.
<p>
Beispiel für einen wöchentlichen Dosage-Eintrag and mehreren Wochentagen:
<code> Mo: 1-0-0-1, Fr: 1-0-0-1 wöchentlich | Wöchentlich montags und freitags 1 Stück morgens und 1 Stück nachts</code>.
</p>

<p>
Beispiel für zwei wöchentliche Dosage-Einträge derselben Sequenz:
<code>Mo: 1-0-0-1 , Fr: 1-0-0-0  wöchentlich | Wöchentlich montags 1 Stück morgens und 1 Stück nachts und freitags 1 Stück morgens</code>.
</p>

<h5 class="no-number">Monatliche Dosierung</h5>

<p>
Für eine monatliche Dosierung mit <code>period = 1</code> wird die Wiederholung
einmal als <code>Monatlich</code> ausgegeben. Der Kalendertag steht vor den
zugehörigen Einnahmezeitpunkten.
</p>

<pre><code>Monatlich am {dayOfMonth}. des Monats {Menge} {Einheit} morgens</code></pre>

<p>
Beispiel für zwei monatliche Dosage-Einträge derselben Sequenz:
<code>1-0-0-0 am 1. des Monats monatlich; 1-0-0-0 am 15. des Monats monatlich | Monatlich am 1. des Monats 1 Stück morgens und am 15. des Monats 1 Stück morgens</code>.
</p>

<h5 class="no-number">Intervalle</h5>

<p>
Ist <code>period</code> größer als <code>1</code>, wird das Intervall anstelle der
einfachen Wiederholung ausgegeben, beispielsweise <code>Alle 2 Tage</code>,
<code>Alle 2 Wochen</code> oder <code>Alle 2 Monate</code>.
</p>

<p>
Beispiel:
<code>1-0-0-1 alle 2 Tage | Alle 2 Tage 1 Stück morgens und 1 Stück nachts</code>.
</p>