{% include styleheader.md %}

<!-- Transaktionen -->

<!-- <br>
[![diagram](eMed_Interactions.png){: style="width: 60%"}](eMed_Interactions.png) -->

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
<th style="width:10%">HTTP</th>
<th style="width:30%">Endpunkt</th>
<th style="width:25%">Operation</th>
<th style="width:25%">Beschreibung</th>
<th style="width:10%; text-align:center;">Rollen</th>
</tr>
</thead>

<tbody>

<tr>
<td><strong>POST</strong></td>
<td><code>/</code></td>
<td><code>$groupidentifier-create</code></td>
<td>Erzeugen eines neuen e-Med GroupIdentifiers für Geplante Abgaben</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/</code></td>
<td><code>$groupidentifier-search</code></td>
<td>Geplante und durchgeführte Abgaben mittels e-Med GroupIdentifier lesen</td>
<td>GDA</td>
</tr>

<tr style="border-top:3px solid #666;">
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>$plan-read</code></td>
<td>Aktuelle Medikationsplanversion lesen</td>
<td>GDA, PAT</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>$plan-write</code></td>
<td>Neue Version eines Medikationsplans schreiben</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>$patient-plan-write</code></td>
<td>Medikationsplaneinträge löschen</td>
<td>PAT</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>$plan-delete</code></td>
<td>Aktuelle oder historische Medikationsplanversion löschen</td>
<td>PAT</td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>plan-history-search</code></td>
<td>
Historische Medikationsplanversion(en) lesen<br>
(<code>_history?_include=*</code> bzw.<br>
<code>_include=*&amp;item=MedicationRequest/{id}&amp;subject=Patient/{id}&amp;date=...</code>)
</td>
<td>GDA, PAT</td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/Patient/{id}/List</code></td>
<td><code>plan-history-directory-search</code></td>
<td>
Verzeichnis historischer Medikationspläne abrufen<br>
(<code>_history?_elements=date,source</code>)
</td>
<td>GDA, PAT</td>
</tr>

<tr style="border-top:3px solid #666;">
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/MedicationRequest</code></td>
<td><code>$prescription-write</code></td>
<td>Geplante Abgabe schreiben</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/MedicationRequest</code></td>
<td><code>$prescription-discard</code></td>
<td>Eigene geplante Abgabe verwerfen</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/Patient/{id}/MedicationRequest</code></td>
<td><code>prescription-search</code></td>
<td>Geplante Abgaben suchen (<code>?category=GeplAbgabe</code>)</td>
<td>GDA, PAT</td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/Patient/{id}/MedicationRequest</code></td>
<td><code>planentry-search</code></td>
<td>Medikationsplaneinträge suchen (<code>?category=Planeintrag</code>)</td>
<td>GDA, PAT</td>
</tr>

<tr>
<td><strong>DELETE</strong></td>
<td><code>/Patient/{id}/MedicationRequest</code></td>
<td><code>prescription-delete</code></td>
<td>Geplante Abgabe löschen</td>
<td>PAT</td>
</tr>

<tr style="border-top:3px solid #666;">
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/MedicationDispense</code></td>
<td><code>$dispense-write</code></td>
<td>Durchgeführte Abgabe schreiben</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/MedicationDispense</code></td>
<td><code>$dispense-discard</code></td>
<td>Eigene durchgeführte Abgabe verwerfen</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>POST</strong></td>
<td><code>/Patient/{id}/MedicationDispense</code></td>
<td><code>$reference-plan</code></td>
<td>Referenz auf Medikationsplan erstellen</td>
<td>GDA</td>
</tr>

<tr>
<td><strong>GET</strong></td>
<td><code>/Patient/{id}/MedicationDispense</code></td>
<td><code>dispense-search</code></td>
<td>Durchgeführte Abgaben suchen</td>
<td>GDA, PAT</td>
</tr>

<tr>
<td><strong>DELETE</strong></td>
<td><code>/Patient/{id}/MedicationDispense</code></td>
<td><code>dispense-delete</code></td>
<td>Durchgeführte Abgabe löschen</td>
<td>PAT</td>
</tr>

</tbody>

</table>