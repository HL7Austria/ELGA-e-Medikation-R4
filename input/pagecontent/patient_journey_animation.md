<style>
.pjm{
  --bg:#f3f5f9;
  --surface:#ffffff;
  --ink:#12182b;
  --ink-2:#4b556e;
  --ink-3:#7d869b;
  --line:#dbe0ea;
  --track:#e3e7ef;
  --blue:#3b62b5;
  --blue-soft:#e9eff9;
  --gold-field:#fdf4d6;
  --gold-line:#c9a227;
  --gold-ink:#7a5c05;
  --brick:#a33b32;
  --brick-soft:#f8e7e4;
  --grow:#2f7d4f;
  --grow-soft:#e3f2e9;
  --amber:#b45f06;
  --amber-soft:#fbeedd;
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]) .pjm{
    --bg:#0e1119;
    --surface:#161a24;
    --ink:#e9ecf3;
    --ink-2:#a7b0c3;
    --ink-3:#7f889c;
    --line:#2a3040;
    --track:#262c3a;
    --blue:#8badf0;
    --blue-soft:#1a2333;
    --gold-field:#2b2413;
    --gold-line:#a8842a;
    --gold-ink:#e6c76b;
    --brick:#e59187;
    --brick-soft:#2e1d1b;
    --grow:#71c496;
    --grow-soft:#16261d;
    --amber:#f0b46a;
    --amber-soft:#2d2215;
  }
}
:root[data-theme="dark"] .pjm{
  --bg:#0e1119;
  --surface:#161a24;
  --ink:#e9ecf3;
  --ink-2:#a7b0c3;
  --ink-3:#7f889c;
  --line:#2a3040;
  --track:#262c3a;
  --blue:#8badf0;
  --blue-soft:#1a2333;
  --gold-field:#2b2413;
  --gold-line:#a8842a;
  --gold-ink:#e6c76b;
  --brick:#e59187;
  --brick-soft:#2e1d1b;
  --grow:#71c496;
  --grow-soft:#16261d;
  --amber:#f0b46a;
  --amber-soft:#2d2215;
}

.pjm, .pjm *{box-sizing:border-box}
.pjm{
  position:relative;max-width:1080px;margin:0 auto 24px;padding:24px 22px 0;border-radius:12px;
  background:var(--bg);color:var(--ink);
  font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;
  font-size:15px;line-height:1.5
}
.pjm .sr{position:absolute;width:1px;height:1px;opacity:0;pointer-events:none}

.pjm .title{font-size:24px;font-weight:700;letter-spacing:-.015em;margin:0 0 14px;text-wrap:balance}

.pjm .legend{display:flex;flex-wrap:wrap;gap:6px 22px;margin:0 0 18px;font-size:13px;color:var(--ink-2)}
.pjm .legend span{display:inline-flex;align-items:center;gap:8px}
.pjm .sw{width:24px;height:14px;border-radius:4px}
.pjm .sw-g{border:1.5px dashed var(--blue)}
.pjm .sw-s{border:1.5px solid var(--gold-line);background:var(--gold-field)}
.pjm .sw-n{width:9px;height:9px;border-radius:50%;background:var(--grow)}
.pjm .sw-c{width:9px;height:9px;border-radius:50%;background:var(--amber)}
.pjm .sw-x{width:9px;height:9px;border-radius:50%;background:var(--brick)}

/* caption of the current step */
.pjm .caption{border-left:3px solid var(--blue);padding:2px 0 2px 14px;margin:0 0 26px;min-height:72px}
.pjm .caption p{margin:0;max-width:78ch;color:var(--ink-2)}
.pjm .caption b{color:var(--ink);font-weight:600}
.pjm .caption .d{font-variant-numeric:tabular-nums;color:var(--blue);font-weight:600;margin-right:6px}
.pjm .caption .who{display:block;font-size:12.5px;color:var(--ink-3);margin-top:4px}

/* three columns */
.pjm .cats{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:20px;align-items:stretch}
.pjm .cat{display:flex;flex-direction:column;min-width:0}
.pjm .cat-t{font-size:15px;font-weight:600;margin:0 0 2px}
.pjm .cat-s{font-size:11.5px;color:var(--ink-3);margin:0 0 12px}
.pjm .gesamt{
  position:relative;flex:1;border:1.5px dashed var(--blue);border-radius:12px;
  padding:22px 12px 12px;display:flex;flex-direction:column;gap:12px;min-height:190px
}
.pjm .gesamt::before{
  content:attr(data-label);position:absolute;top:-9px;left:12px;padding:0 6px;background:var(--bg);
  font-size:10px;font-weight:600;letter-spacing:.11em;text-transform:uppercase;color:var(--blue)
}
.pjm .field{background:var(--gold-field);border:1.5px solid var(--gold-line);border-radius:9px;padding:9px 10px 11px}
.pjm .field-t{display:block;font-size:11px;font-weight:700;letter-spacing:.09em;text-transform:uppercase;color:var(--gold-ink);margin-bottom:8px}
.pjm .empty{margin:0;font-size:12px;color:var(--gold-ink);opacity:.85}
.pjm .gesamt > .empty{color:var(--ink-3)}

/* entries */
.pjm .items{list-style:none;margin:0;padding:0;display:flex;flex-direction:column;gap:6px}
.pjm .item{
  position:relative;display:grid;grid-template-columns:auto 1fr auto;column-gap:8px;align-items:start;
  padding:6px 10px 7px 9px;border-radius:9px;background:var(--surface);border:1px solid var(--line);font-size:13px
}
.pjm .field .item{border-color:var(--gold-line)}
.pjm .item::before{content:"";width:8px;height:8px;margin-top:6px;border-radius:50%;background:var(--blue);opacity:.55}
.pjm .item .nm{font-weight:600;min-width:0}
.pjm .item .dz{grid-column:2 / 4;font-size:12px;color:var(--ink-2)}
.pjm .item .stat{
  font-style:normal;font-size:9.5px;font-weight:700;letter-spacing:.06em;text-transform:uppercase;
  padding:1px 6px;border-radius:999px;border:1px solid var(--line);color:var(--ink-3);margin-top:2px;white-space:nowrap
}
.pjm .item .stat:empty{display:none}
.pjm .item.hold .stat{border-color:var(--amber);color:var(--amber)}
.pjm .item.done{opacity:.75}
.pjm .item.done::before{background:var(--ink-3)}
.pjm .item::after{
  position:absolute;top:-8px;right:8px;padding:0 6px;border-radius:999px;background:var(--surface);
  font-size:9px;font-weight:700;letter-spacing:.06em;text-transform:uppercase
}

/* exchange between client and server */
.pjm .wire{margin:28px 0 0;padding-top:18px;border-top:1px solid var(--line)}
.pjm .wire-t{font-size:11px;font-weight:700;letter-spacing:.09em;text-transform:uppercase;color:var(--ink-3);margin:0 0 10px}
.pjm .lanes{display:flex;justify-content:space-between;gap:12px;font-size:12px;font-weight:600;color:var(--ink-2);margin-bottom:9px}
.pjm .msgs{display:flex;flex-direction:column;gap:5px}
.pjm .msg{display:flex;flex-wrap:wrap;align-items:baseline;gap:4px 10px;padding:6px 11px;border-radius:7px;font-size:12.5px;color:var(--ink-2)}
.pjm .msg code{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace;font-size:12px;font-weight:600;color:var(--ink);background:none;padding:0;overflow-wrap:anywhere}
.pjm .msg .t{min-width:0}
.pjm .req{background:var(--blue-soft);border-left:3px solid var(--blue);margin-right:12%}
.pjm .req::after{content:"\2192";margin-left:auto;padding-left:8px;color:var(--blue);font-weight:700}
.pjm .res{background:var(--surface);border-right:3px solid var(--line);margin-left:12%;text-align:right}
.pjm .res::before{content:"\2190";margin-right:auto;padding-right:8px;color:var(--ink-3);font-weight:700}
.pjm .note{font-size:12px;font-style:italic;color:var(--ink-3);text-align:center;padding:1px 10px;margin:0}

/* timeline (radio labels) */
.pjm .bar{
  position:sticky;bottom:0;margin:30px -22px 0;padding:14px 22px 16px;border-radius:0 0 12px 12px;
  background:var(--bg);border-top:1px solid var(--line)
}
.pjm .stops{position:relative;display:grid;grid-template-columns:repeat(9,1fr)}
.pjm .line,.pjm .fill{position:absolute;top:7px;height:3px;border-radius:2px}
.pjm .line{left:5.556%;right:5.556%;background:var(--track)}
.pjm .fill{left:5.556%;width:0;background:var(--blue)}
.pjm .stop{position:relative;display:flex;flex-direction:column;align-items:center;gap:3px;cursor:pointer;padding:0 2px;margin:0;text-align:center;font-weight:400}
.pjm .dot{width:17px;height:17px;border-radius:50%;background:var(--surface);border:2px solid var(--line)}
.pjm .stop .d{font-size:12px;font-variant-numeric:tabular-nums;color:var(--ink-2)}
.pjm .stop .n{font-size:11px;line-height:1.3;color:var(--ink-3)}
.pjm .stop:hover .dot{border-color:var(--blue)}

/* ---------- state per step (no JavaScript) ---------- */
#pjm-s0:checked ~ * .st:not(.on0),
#pjm-s1:checked ~ * .st:not(.on1),
#pjm-s2:checked ~ * .st:not(.on2),
#pjm-s3:checked ~ * .st:not(.on3),
#pjm-s4:checked ~ * .st:not(.on4),
#pjm-s5:checked ~ * .st:not(.on5),
#pjm-s6:checked ~ * .st:not(.on6),
#pjm-s7:checked ~ * .st:not(.on7),
#pjm-s8:checked ~ * .st:not(.on8){display:none}

/* newly added in this step */
#pjm-s1:checked ~ * .new1,
#pjm-s2:checked ~ * .new2,
#pjm-s3:checked ~ * .new3,
#pjm-s4:checked ~ * .new4,
#pjm-s7:checked ~ * .new7,
#pjm-s8:checked ~ * .new8{border-color:var(--grow);box-shadow:0 0 0 2px var(--grow-soft);opacity:1}
#pjm-s1:checked ~ * .new1::after,
#pjm-s2:checked ~ * .new2::after,
#pjm-s3:checked ~ * .new3::after,
#pjm-s4:checked ~ * .new4::after,
#pjm-s7:checked ~ * .new7::after,
#pjm-s8:checked ~ * .new8::after{content:"neu";color:var(--grow)}

/* changed in this step */
#pjm-s3:checked ~ * .chg3,
#pjm-s4:checked ~ * .chg4,
#pjm-s6:checked ~ * .chg6,
#pjm-s7:checked ~ * .chg7,
#pjm-s8:checked ~ * .chg8{border-color:var(--amber);box-shadow:0 0 0 2px var(--amber-soft);opacity:1}
#pjm-s3:checked ~ * .chg3::after,
#pjm-s4:checked ~ * .chg4::after,
#pjm-s6:checked ~ * .chg6::after,
#pjm-s7:checked ~ * .chg7::after,
#pjm-s8:checked ~ * .chg8::after{content:attr(data-chg);color:var(--amber)}

/* removed in this step */
#pjm-s8:checked ~ * .gone8{background:var(--brick-soft);border-color:var(--brick);color:var(--brick)}
#pjm-s8:checked ~ * .gone8::before{background:var(--brick);opacity:1}
#pjm-s8:checked ~ * .gone8 .nm,
#pjm-s8:checked ~ * .gone8 .dz{text-decoration:line-through;text-decoration-thickness:1.5px;color:var(--brick)}
#pjm-s8:checked ~ * .gone8::after{content:attr(data-gone);color:var(--brick)}

/* timeline: progress + current stop */
#pjm-s1:checked ~ .bar .fill{width:11.111%}
#pjm-s2:checked ~ .bar .fill{width:22.222%}
#pjm-s3:checked ~ .bar .fill{width:33.333%}
#pjm-s4:checked ~ .bar .fill{width:44.444%}
#pjm-s5:checked ~ .bar .fill{width:55.556%}
#pjm-s6:checked ~ .bar .fill{width:66.667%}
#pjm-s7:checked ~ .bar .fill{width:77.778%}
#pjm-s8:checked ~ .bar .fill{width:88.889%}
#pjm-s0:checked ~ .bar [for="pjm-s0"] .dot,
#pjm-s1:checked ~ .bar [for="pjm-s1"] .dot,
#pjm-s2:checked ~ .bar [for="pjm-s2"] .dot,
#pjm-s3:checked ~ .bar [for="pjm-s3"] .dot,
#pjm-s4:checked ~ .bar [for="pjm-s4"] .dot,
#pjm-s5:checked ~ .bar [for="pjm-s5"] .dot,
#pjm-s6:checked ~ .bar [for="pjm-s6"] .dot,
#pjm-s7:checked ~ .bar [for="pjm-s7"] .dot,
#pjm-s8:checked ~ .bar [for="pjm-s8"] .dot{background:var(--blue);border-color:var(--blue);box-shadow:0 0 0 4px var(--surface)}
#pjm-s0:checked ~ .bar [for="pjm-s0"] .d,
#pjm-s1:checked ~ .bar [for="pjm-s1"] .d,
#pjm-s2:checked ~ .bar [for="pjm-s2"] .d,
#pjm-s3:checked ~ .bar [for="pjm-s3"] .d,
#pjm-s4:checked ~ .bar [for="pjm-s4"] .d,
#pjm-s5:checked ~ .bar [for="pjm-s5"] .d,
#pjm-s6:checked ~ .bar [for="pjm-s6"] .d,
#pjm-s7:checked ~ .bar [for="pjm-s7"] .d,
#pjm-s8:checked ~ .bar [for="pjm-s8"] .d{color:var(--blue);font-weight:600}
#pjm-s0:focus-visible ~ .bar [for="pjm-s0"] .dot,
#pjm-s1:focus-visible ~ .bar [for="pjm-s1"] .dot,
#pjm-s2:focus-visible ~ .bar [for="pjm-s2"] .dot,
#pjm-s3:focus-visible ~ .bar [for="pjm-s3"] .dot,
#pjm-s4:focus-visible ~ .bar [for="pjm-s4"] .dot,
#pjm-s5:focus-visible ~ .bar [for="pjm-s5"] .dot,
#pjm-s6:focus-visible ~ .bar [for="pjm-s6"] .dot,
#pjm-s7:focus-visible ~ .bar [for="pjm-s7"] .dot,
#pjm-s8:focus-visible ~ .bar [for="pjm-s8"] .dot{outline:2px solid var(--blue);outline-offset:3px}

@media (prefers-reduced-motion:no-preference){
  .pjm .fill{transition:width .25s ease}
}
@media (max-width:820px){
  .pjm{padding:20px 16px 0}
  .pjm .bar{margin:30px -16px 0;padding:14px 16px 16px}
  .pjm .cats{grid-template-columns:1fr}
  .pjm .gesamt{min-height:0}
  .pjm .stop .n{display:none}
  .pjm .stop .d{font-size:10.5px}
  .pjm .req{margin-right:0}
  .pjm .res{margin-left:0}
}
</style>

<div class="pjm">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s0" aria-label="27.02.2026 Erster Arztbesuch: Abruf" checked>
  <input class="sr" type="radio" name="pjm-step" id="pjm-s1" aria-label="27.02.2026 Erster Arztbesuch: Planeinträge erstellen">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s2" aria-label="27.02.2026 Erster Arztbesuch: Rezept">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s3" aria-label="28.02.2026 Abgabe in der Apotheke, Teil 1">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s4" aria-label="01.03.2026 Abgabe in der Apotheke, Teil 2">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s5" aria-label="07.03.2026 Patient ruft Medikationsplan ab">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s6" aria-label="14.03.2026 Präoperativer Arzttermin">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s7" aria-label="17. bis 19.03.2026 Krankenhausaufenthalt">
  <input class="sr" type="radio" name="pjm-step" id="pjm-s8" aria-label="22.03.2026 Termin bei Dr. Urlaubsvertretung">

  <header>
    <div class="title">Patient Journey Max Mustermann</div>
    <div class="legend">
      <span><i class="sw sw-g"></i>alle Einträge der Kategorie</span>
      <span><i class="sw sw-s"></i>aktuell / offen</span>
      <span><i class="sw sw-n"></i>neu</span>
      <span><i class="sw sw-c"></i>geändert</span>
      <span><i class="sw sw-x"></i>entfernt</span>
    </div>
  </header>

  <div class="caption">
    <p class="st on0"><span class="d">27.02.2026</span><b>Erster Arztbesuch – Abruf.</b> Dr. Hausärztin stellt eine leichte arterielle Hypertonie fest und ruft die e-Medikation ab. Da noch nie ein Medikationsplan abgerufen wurde, legt die Fachanwendung einen leeren Medikationsplan an (<i>emptyReason = notstarted</i>).<span class="who">Journey-01-01 · Dr. Hausärztin</span></p>
    <p class="st on1"><span class="d">27.02.2026</span><b>Erster Arztbesuch – Planeinträge.</b> Dr. Hausärztin erstellt zwei Planeinträge – Ramipril als Dauermedikation und Dexpanthenol-Salbe für 3 Wochen – und speichert den Medikationsplan.<span class="who">Journey-01-02 · Dr. Hausärztin</span></p>
    <p class="st on2"><span class="d">27.02.2026</span><b>Erster Arztbesuch – Rezept.</b> Für beide Arzneimittel wird ein Kassenrezept ausgestellt und je eine <i>Geplante Abgabe</i> in der e-Medikation dokumentiert.<span class="who">Journey-01-03 · Dr. Hausärztin</span></p>
    <p class="st on3"><span class="d">28.02.2026</span><b>Apotheke, Teil 1.</b> Ramipril wird vollständig abgegeben, die zugehörige Geplante Abgabe wird automatisch abgeschlossen. Die Dexpanthenol-Salbe muss erst hergestellt werden: Besorgerprozess (<i>First Fill – Part Fill</i>, Menge 0).<span class="who">Journey-02 · Apotheke</span></p>
    <p class="st on4"><span class="d">01.03.2026</span><b>Apotheke, Teil 2.</b> Die fertige Salbe wird übergeben und der Besorgerprozess mit einer weiteren Durchgeführten Abgabe (<i>RFC – Refill Complete</i>) abgeschlossen. Die Geplante Abgabe wird automatisch abgeschlossen.<span class="who">Journey-03 · Apotheke</span></p>
    <p class="st on5"><span class="d">07.03.2026</span><b>Patient ruft ab.</b> Herr Mustermann sieht im Zugangsportal nach, wie lange er die Salbe anwenden soll. Er sieht keine offenen Geplanten Abgaben und alle bisherigen Abholungen. Es ändert sich nichts.<span class="who">Journey-04 · ELGA-Portal</span></p>
    <p class="st on6"><span class="d">14.03.2026</span><b>Präoperativer Arzttermin.</b> Vor der geplanten Leistenbruch-Operation pausiert Dr. Hausärztin Ramipril, um eine intraoperative Hypotonie zu vermeiden (<i>on-hold, statusReason = surg</i>).<span class="who">Journey-05 · Dr. Hausärztin</span></p>
    <p class="st on7"><span class="d">17.–19.03.2026</span><b>Krankenhausaufenthalt.</b> Bei der OP-Besprechung wird der Medikationsplan abgerufen. Bei der Entlassung wird Ramipril mit erhöhter Dosis (1-0-1-0) wieder aufgenommen und der Wirkstoff Metamizol gegen postoperative Schmerzen ergänzt.<span class="who">Journey-06 · Dr. Krankenhaus</span></p>
    <p class="st on8"><span class="d">22.03.2026</span><b>Dr. Urlaubsvertretung.</b> Die Wirkstoffangabe Metamizol wird durch das Arzneimittel Metagelan-Tropfen ersetzt. Der Behandlungszeitraum der Dexpanthenol-Salbe ist abgelaufen, der Planeintrag wird entfernt. Für Metagelan wird eine Geplante Abgabe erstellt.<span class="who">Journey-07 · Dr. Urlaubsvertretung</span></p>
  </div>

  <div class="cats">
    <section class="cat">
      <div class="cat-t">Medikationsplan</div>
      <div class="cat-s">List mit Planeinträgen (MedicationRequest)</div>
      <div class="gesamt" data-label="Medikationsplan">
        <div class="field">
          <span class="field-t">Aktuelle Planversion</span>
          <p class="empty st on0">leer · emptyReason notstarted</p>
          <ul class="items">
            <li class="item st on1 on2 on3 on4 on5 new1"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">aktiv</em><span class="dz">1-0-0-0 · Dauermedikation</span></li>
            <li class="item hold st on6 chg6" data-chg="geändert"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">pausiert</em><span class="dz">1-0-0-0 · on-hold wegen OP (surg)</span></li>
            <li class="item st on7 on8 chg7" data-chg="geändert"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">aktiv</em><span class="dz">1-0-1-0 · Dauermedikation</span></li>
            <li class="item st on1 on2 on3 on4 on5 on6 on7 on8 new1 gone8" data-gone="entfernt"><span class="nm">Dexpanthenol-5-%-Salbe</span><em class="stat st on1 on2 on3 on4 on5 on6 on7">aktiv</em><em class="stat st on8">abgelaufen</em><span class="dz">2× täglich dünn auftragen · 3 Wochen</span></li>
            <li class="item st on7 new7"><span class="nm">Metamizol 1.000 mg</span><em class="stat">aktiv</em><span class="dz">Wirkstoffangabe · 4× täglich</span></li>
            <li class="item st on8 chg8" data-chg="geändert"><span class="nm">Metagelan 500 mg/ml Tropfen</span><em class="stat">aktiv</em><span class="dz">4× täglich 40 Tropfen</span></li>
          </ul>
        </div>
      </div>
    </section>

    <section class="cat">
      <div class="cat-t">Geplante Abgaben</div>
      <div class="cat-s">MedicationRequest, Kategorie „Geplante Abgabe“</div>
      <div class="gesamt" data-label="alle Geplanten Abgaben">
        <div class="field">
          <span class="field-t">Offen (active)</span>
          <p class="empty st on0 on1 on4 on5 on6 on7">keine offenen Geplanten Abgaben</p>
          <ul class="items">
            <li class="item st on2 new2"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">aktiv</em><span class="dz">Kassenrezept · zu Planeintrag Ramipril</span></li>
            <li class="item st on2 on3 new2"><span class="nm">Dexpanthenol-5-%-Salbe</span><em class="stat">aktiv</em><span class="dz">Kassenrezept · zu Planeintrag Dexpanthenol</span></li>
            <li class="item st on8 new8"><span class="nm">Metagelan 500 mg/ml Tropfen</span><em class="stat">aktiv</em><span class="dz">2 Packungen · Kassenrezept</span></li>
          </ul>
        </div>
        <ul class="items">
          <li class="item done st on3 on4 on5 on6 on7 on8 chg3" data-chg="abgeschlossen"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">completed</em><span class="dz">vollständig eingelöst</span></li>
          <li class="item done st on4 on5 on6 on7 on8 chg4" data-chg="abgeschlossen"><span class="nm">Dexpanthenol-5-%-Salbe</span><em class="stat">completed</em><span class="dz">vollständig eingelöst</span></li>
        </ul>
      </div>
    </section>

    <section class="cat">
      <div class="cat-t">Durchgeführte Abgaben</div>
      <div class="cat-s">MedicationDispense</div>
      <div class="gesamt" data-label="alle Durchgeführten Abgaben">
        <p class="empty st on0 on1 on2">noch keine Abgaben</p>
        <ul class="items">
          <li class="item st on3 on4 on5 on6 on7 on8 new3"><span class="nm">Ramipril 5 mg Tabletten</span><em class="stat">28.02.</em><span class="dz">vollständige Einzelabgabe</span></li>
          <li class="item st on3 on4 on5 on6 on7 on8 new3"><span class="nm">Dexpanthenol-5-%-Salbe</span><em class="stat">28.02.</em><span class="dz">Besorgerprozess · First Fill – Part Fill · Menge 0</span></li>
          <li class="item st on4 on5 on6 on7 on8 new4"><span class="nm">Dexpanthenol-5-%-Salbe</span><em class="stat">01.03.</em><span class="dz">Besorgerprozess abgeschlossen · RFC</span></li>
        </ul>
      </div>
    </section>
  </div>

  <section class="wire">
    <div class="wire-t">Datenaustausch in diesem Schritt</div>
    <div class="lanes"><span>Client &ndash; GDA-Software bzw. ELGA-Portal</span><span>e-Medikation Fachanwendung</span></div>
    <div class="msgs">
      <!-- 0 Abruf -->
      <div class="msg req st on0"><code>POST /List/$plan-read</code><span class="t">aktuellen Medikationsplan abrufen</span></div>
      <div class="msg res st on0"><code>200 Bundle</code><span class="t">leerer Medikationsplan, emptyReason notstarted · ETag</span></div>
      <p class="note st on0">die Fachanwendung legt den Medikationsplan beim ersten Abruf selbst an · List.source = Device</p>
      <div class="msg req st on0"><code>GET /MedicationRequest?category=…|2&amp;status=active</code><span class="t">offene Geplante Abgaben</span></div>
      <div class="msg res st on0"><code>200 Bundle</code><span class="t">0 Einträge</span></div>
      <div class="msg req st on0"><code>GET /MedicationDispense</code><span class="t">Durchgeführte Abgaben</span></div>
      <div class="msg res st on0"><code>200 Bundle</code><span class="t">0 Einträge</span></div>

      <!-- 1 Planeinträge -->
      <div class="msg req st on1"><code>POST /List/$plan-write</code><span class="t">Transaction-Bundle: List + 2× Planeintrag (flag new) · ETag aus $plan-read</span></div>
      <div class="msg res st on1"><code>200 OK</code><span class="t">neue Planversion gespeichert</span></div>
      <p class="note st on1">beim nächsten $plan-read setzt die Fachanwendung die Flags von new auf unchanged</p>

      <!-- 2 Rezept -->
      <div class="msg req st on2"><code>POST $groupidentifier-create</code><span class="t">e-Med GroupIdentifier („Rezeptklammer“) beziehen</span></div>
      <div class="msg res st on2"><code>200 OK</code><span class="t">e-Med GroupIdentifier</span></div>
      <div class="msg req st on2"><code>POST $prescription-write</code><span class="t">Transaction-Bundle: 2× Geplante Abgabe, status active, gleicher GroupIdentifier</span></div>
      <div class="msg res st on2"><code>200 OK</code><span class="t">Geplante Abgaben gespeichert</span></div>
      <p class="note st on2">Operationen $groupidentifier-create und $prescription-write in Arbeit</p>

      <!-- 3 Apotheke Teil 1 -->
      <div class="msg req st on3"><code>$plan-read · GET /MedicationRequest · GET /MedicationDispense</code><span class="t">e-card gesteckt, Abruf zur Wechselwirkungsprüfung</span></div>
      <div class="msg res st on3"><code>200 Bundle</code><span class="t">2 Planeinträge · 2 offene Geplante Abgaben · 0 Abgaben</span></div>
      <div class="msg req st on3"><code>POST $dispense-write</code><span class="t">Transaction-Bundle: 2× Durchgeführte Abgabe (vollständig, Besorgerprozess)</span></div>
      <div class="msg res st on3"><code>200 OK</code><span class="t">Durchgeführte Abgaben gespeichert</span></div>
      <p class="note st on3">Kassenrezept ohne weitere Einlösung: die Fachanwendung setzt die Geplante Abgabe Ramipril auf completed</p>

      <!-- 4 Apotheke Teil 2 -->
      <div class="msg req st on4"><code>$plan-read · GET /MedicationRequest · GET /MedicationDispense</code><span class="t">e-card gesteckt</span></div>
      <div class="msg res st on4"><code>200 Bundle</code><span class="t">1 offene Geplante Abgabe · Besorgerprozess-Abgabe</span></div>
      <div class="msg req st on4"><code>POST $dispense-write</code><span class="t">1× Durchgeführte Abgabe, type = RFC, tatsächliche Menge</span></div>
      <div class="msg res st on4"><code>200 OK</code><span class="t">Durchgeführte Abgabe gespeichert</span></div>
      <p class="note st on4">die Fachanwendung setzt die Geplante Abgabe Dexpanthenol auf completed</p>

      <!-- 5 Portal -->
      <div class="msg req st on5"><code>POST /List/$plan-read</code><span class="t">über das ELGA-Portal</span></div>
      <div class="msg res st on5"><code>200 Bundle</code><span class="t">2 Planeinträge, Dexpanthenol: 3 Wochen</span></div>
      <div class="msg req st on5"><code>GET /MedicationRequest · GET /MedicationDispense</code><span class="t">Geplante und Durchgeführte Abgaben</span></div>
      <div class="msg res st on5"><code>200 Bundle</code><span class="t">0 offene Geplante Abgaben · 3 Durchgeführte Abgaben</span></div>
      <p class="note st on5">rein lesender Zugriff – keine neue Planversion</p>

      <!-- 6 Präoperativ -->
      <div class="msg req st on6"><code>POST /List/$plan-read</code><span class="t">aktuellen Medikationsplan inkl. ETag holen</span></div>
      <div class="msg res st on6"><code>200 Bundle</code><span class="t">2 Planeinträge</span></div>
      <div class="msg req st on6"><code>POST /List/$plan-write</code><span class="t">Ramipril: status on-hold, statusReason surg (changed) · Dexpanthenol unchanged</span></div>
      <div class="msg res st on6"><code>200 OK</code><span class="t">neue Planversion gespeichert</span></div>

      <!-- 7 Krankenhaus -->
      <div class="msg req st on7"><code>POST /List/$plan-read</code><span class="t">17.03. OP-Besprechung: Ramipril pausiert?</span></div>
      <div class="msg res st on7"><code>200 Bundle</code><span class="t">Ramipril on-hold</span></div>
      <div class="msg req st on7"><code>POST /List/$plan-write</code><span class="t">19.03.: Ramipril active, 1-0-1-0 (changed) · Dexpanthenol unchanged · Metamizol (new)</span></div>
      <div class="msg res st on7"><code>200 OK</code><span class="t">neue Planversion gespeichert</span></div>

      <!-- 8 Urlaubsvertretung -->
      <div class="msg req st on8"><code>POST /List/$plan-read</code><span class="t">aktuellen Medikationsplan abrufen</span></div>
      <div class="msg res st on8"><code>200 Bundle</code><span class="t">Dexpanthenol von der Fachanwendung als abgelaufen markiert</span></div>
      <div class="msg req st on8"><code>POST /List/$plan-write</code><span class="t">Ramipril unchanged · Dexpanthenol removed · Metamizol → Metagelan (changed)</span></div>
      <div class="msg res st on8"><code>200 OK</code><span class="t">neue Planversion gespeichert</span></div>
      <div class="msg req st on8"><code>POST $prescription-write</code><span class="t">1× Geplante Abgabe Metagelan-Tropfen, 2 Packungen</span></div>
      <div class="msg res st on8"><code>200 OK</code><span class="t">Geplante Abgabe gespeichert</span></div>
      <p class="note st on8">beim nächsten $plan-read ist der entfernte Planeintrag nicht mehr im Medikationsplan enthalten</p>
    </div>
  </section>

  <nav class="bar" aria-label="Zeitpunkt wählen">
    <div class="stops">
      <span class="line"></span><span class="fill"></span>
      <label class="stop" for="pjm-s0"><span class="dot"></span><span class="d">27.02.</span><span class="n">Abruf</span></label>
      <label class="stop" for="pjm-s1"><span class="dot"></span><span class="d">27.02.</span><span class="n">Planeinträge</span></label>
      <label class="stop" for="pjm-s2"><span class="dot"></span><span class="d">27.02.</span><span class="n">Rezept</span></label>
      <label class="stop" for="pjm-s3"><span class="dot"></span><span class="d">28.02.</span><span class="n">Apotheke 1</span></label>
      <label class="stop" for="pjm-s4"><span class="dot"></span><span class="d">01.03.</span><span class="n">Apotheke 2</span></label>
      <label class="stop" for="pjm-s5"><span class="dot"></span><span class="d">07.03.</span><span class="n">Portal</span></label>
      <label class="stop" for="pjm-s6"><span class="dot"></span><span class="d">14.03.</span><span class="n">Präoperativ</span></label>
      <label class="stop" for="pjm-s7"><span class="dot"></span><span class="d">19.03.</span><span class="n">Krankenhaus</span></label>
      <label class="stop" for="pjm-s8"><span class="dot"></span><span class="d">22.03.</span><span class="n">Vertretung</span></label>
    </div>
  </nav>
</div>
