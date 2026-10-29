{% include styleheader.md %}

<!-- Transaktionen -->

<!-- <br>
[![diagram](eMed_Interactions.png){: style="width: 60%"}](eMed_Interactions.png) -->

<div class="note-to-balloters" markdown="1">

Die Umsetzung des Patientenkontakts in den Transaktionen ist nicht Teil des Ballots. Der konkrete Zugriff wird in der [Lösungsarchitektur](https://dev.elga.gv.at/apis/emed/latest/emed-fhir-anbindung/) beschrieben.
 
In diesem IG werden daher alle Requests ab dem `/[type]` dargestellt.
</div>
 

<br>
<div>{% include_relative plantuml/interaction_overview.svg %}</div>
<br>

<style>
table thead th {
  border: none !important;
}
</style>

<table class="table table-striped table-bordered">

<thead>
<tr>
<th style="width:5%">HTTP</th>
<th style="width:20%">Endpunkt</th>
<th style="width:20%">Custom-Operation/FHIR-Interaction</th>
<th style="width:10%">Profil</th>
<th style="width:30%">Beschreibung</th>
<th style="width:5%; text-align:center;">Rollen</th>
<th style="width:10%;">(Such-) parameter</th>
</tr>
</thead>

<tbody>

<tr>
<td><strong>POST</strong></td>
<td><code>/</code></td>
<td><code>$groupidentifier-create</code></td>
<td></td>
<td>Erzeugen eines neuen e-Med GroupIdentifiers für Geplante Abgaben</td>
<td>GDA</td>
<td></td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/</code></td>
<td><code>$groupidentifier-search</code></td>
<td></td>
<td>Geplante und Durchgeführte Abgaben mittels e-Med GroupIdentifier lesen</td>
<td>GDA</td>
<td></td>
</tr>

<tr style="border-top:3px solid #666;">
<td><strong>POST</strong></td>
<td><code>/List</code></td>
<td><code>$plan-read</code></td>
<td>Medikationsplan</td>
<td>Aktuelle Medikationsplanversion lesen</td>
<td>GDA, PAT</td>
<td></td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/List</code></td>
<td><code>$plan-write</code></td>
<td>Medikationsplan</td>
<td>Neue Version eines Medikationsplans schreiben</td>
<td>GDA</td>
<td></td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/List</code></td>
<td><code>$history-delete</code></td>
<td>Medikationsplan</td>
<td>Aktuelle oder historische Medikationsplanversion löschen</td>
<td>PAT</td>
<td></td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/List</code></td>
<td><code>$history-search</code></td>
<td>Medikationsplan</td>
<td>
plan-history-search & plan-history-directory-search:<br>
In historischen Medikationsplanversion(en) suchen und alle referenzierten Ressourcen inkludieren. Directory-Search wenn der Parameter<code>include</code> nicht verwendet wird.
</td>
<td>GDA, PAT</td>
<td><a href="StructureDefinition-at-elga-emed-list-medikationsplan.html#search-parameters">List (Search-) parameters</a></td>
</tr>

<!--
<tr>
<td><strong>GET</strong></td>
<td><code>/List/[id]/_history</code></td>
<td><code>history-instance</code></td>
<td>
Die gesamte Historie des Medikationsplan abrufen<br>
</td>
<td>GDA, PAT</td>
<td></td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/List/[id]/_history/[vid]</code></td>
<td><code>vread</code></td>
<td>
Historische Medikationsplanversion(en) lesen<br>
Standardabfrage mit _include
</td>
<td>GDA, PAT</td>
<td></td>
</tr>
-->

<!-- MedicationRequest: typbezogene Interaktionen -->

<tr style="border-top:3px solid #666;">
  <td><strong>POST</strong></td>
  <td><code>/MedicationRequest</code></td>
  <td><code>$prescription-write</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html">Geplante Abgabe</a></td>
  <td>Geplante Abgabe schreiben</td>
  <td>GDA</td>
  <td></td>
</tr>

<tr>
  <td><strong>POST</strong></td>
  <td><code>/MedicationRequest</code></td>
  <td><code>$history-search</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html">Planeintrag</a></td>
  <td>
  In historischen Planeintragsversionen suchen und alle
  referenzierten Ressourcen inkludieren.
  Nur MedicationRequests ohne referenzierte Ressourcen, wenn <code>include</code> nicht verwendet wird.<br>
  Gilt ausschließlich für Planeinträge, nicht für Geplante Abgaben.
  </td>
  <td>GDA, PAT</td>
  <td>
    <a href="StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html#search-parameters">Planeintrag (Search-) parameters</a>
  </td>
</tr>

<tr>
  <td><strong>GET</strong></td>
  <td><code>/MedicationRequest?category=Planeintrag</code></td>
  <td><code>search-type</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html">Planeintrag</a></td>
  <td>
    planentry-search: Aktuelle Planeinträge suchen
    (<code>?category=Planeintrag</code>)
  </td>
  <td>GDA, PAT</td>
  <td>
    <a href="StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html#search-parameters">Planeintrag (Search-) parameters</a>
  </td>
</tr>

<tr>
  <td><strong>GET</strong></td>
  <td><code>/MedicationRequest?category=GeplAbgabe</code></td>
  <td><code>search-type</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html">Geplante Abgabe</a></td>
  <td>prescription-search: Geplante Abgaben suchen
    (<code>?category=GeplAbgabe</code>)
  </td>
  <td>GDA, PAT</td>
  <td>
    <a href="StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html#search-parameters">Geplante Abgabe (Search-) parameters</a>
  </td>
</tr>

<!-- MedicationRequest: instanzbezogene Interaktionen -->


<tr>
  <td><strong>POST</strong></td>
  <td><code>/MedicationRequest/[id]</code></td>
  <td><code>$prescription-discard</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html">Geplante Abgabe</a></td>
  <td>Eigene Geplante Abgabe stornieren</td>
  <td>GDA</td>
  <td></td>
</tr>

<tr>
  <td><strong>POST</strong></td>
  <td><code>/MedicationRequest/[id]</code></td>
  <td><code>$planentry-delete</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-planeintrag.html">Planeintrag</a></td>
  <td>Gesamte Historie eines Planeintrags löschen</td>
  <td>PAT</td>
  <td></td>
</tr>

<tr>
  <td><strong>DELETE</strong></td>
  <td><code>/MedicationRequest/[id]</code></td>
  <td><code>delete</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationrequest-geplanteabgabe.html">Geplante Abgabe</a></td>
  <td>prescription-delete: Geplante Abgabe löschen; nur für Geplante Abgaben</td>
  <td>PAT</td>
  <td></td>
</tr>
<!-- Wie kann man hier abfangen, dass nur Geplante Abgaben gelöscht werden können und keine Planeinträge?-->

<!--
<tr>
<td><strong>GET</strong></td>
<td><code>/MedicationRequest/[id]/_history</code></td>
<td><code>history-instance</code></td>
<td>
Die gesamte Historie eines Medikationsplaneintrags abrufen<br>
</td>
<td>GDA, PAT</td>
<td></td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/MedicationRequest/[id]/_history/[vid]</code></td>
<td><code>vread</code></td>
<td>
eine historische Planeintragsversion lesen<br>
</td>
<td>GDA, PAT</td>
<td></td>
</tr>
-->

  <!-- MedicationDispense: typbezogene Interaktionen -->
<tr style="border-top:3px solid #666;">
  <td><strong>POST</strong></td>
  <td><code>/MedicationDispense</code></td>
  <td><code>$dispense-write</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html">Durchgeführte Abgabe</a></td>
  <td>Durchgeführte Abgabe schreiben</td>
  <td>GDA</td>
  <td></td>
</tr>

<tr>
  <td><strong>GET</strong></td>
  <td><code>/MedicationDispense</code></td>
  <td><code>search-type</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html">Durchgeführte Abgabe</a></td>
  <td>dispense-search: Durchgeführte Abgaben suchen</td>
  <td>GDA, PAT</td>
  <td>
    <a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html#search-parameters">MedicationDispense (Search-) parameters</a>
  </td>
</tr>

<!-- MedicationDispense: instanzbezogene Interaktionen -->
<tr>
  <td><strong>POST</strong></td>
  <td><code>/MedicationDispense/[id]</code></td>
  <td><code>$dispense-discard</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html">Durchgeführte Abgabe</a></td>
  <td>Eigene Durchgeführte Abgabe stornieren</td>
  <td>GDA</td>
  <td></td>
</tr>

<tr>
  <td><strong>POST</strong></td>
  <td><code>/MedicationDispense/[id]</code></td>
  <td><code>$reference-plan</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html">Durchgeführte Abgabe</a></td>
  <td>Referenz auf Medikationsplan erstellen</td>
  <td>GDA</td>
  <td></td>
</tr>

<tr>
  <td><strong>DELETE</strong></td>
  <td><code>/MedicationDispense/[id]</code></td>
  <td><code>delete</code></td>
  <td><a href="StructureDefinition-at-elga-emed-medicationdispense-durchgefuehrteabgabe.html">Durchgeführte Abgabe</a></td>
  <td>dispense-delete: Durchgeführte Abgabe löschen</td>
  <td>PAT</td>
  <td></td>
</tr>

</tbody>

</table>


### Suchparameter Überblick

[![diagram](searchparameter_overview.png){: style="width: 60%"}](searchparameter_overview.png)
