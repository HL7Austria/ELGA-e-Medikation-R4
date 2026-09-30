{% include styleheader.md %}

#### Search Parameters

<div class="note">
<p><b>Historische Planversionen (<code>_history</code>)</b></p>
<p>
<code>_history</code> ist kein Suchparameter, sondern eine eigene FHIR-Interaktion, die als Teil des URL-Pfads angegeben wird. Sie liefert frühere Versionen des Medikationsplans (List-Ressource). Pro Patient existiert genau eine List-Ressource. Deren Versionen bilden die gesamte Historie der Medikationsplanversionen dieses Patienten ab.
</p>
<ul>
  <li><b>Alle Versionen des Plans, mit Suchparametern:</b> <code>[base]/List/_history?[searchparameters]</code></li>
  <li><b>Alle Versionen eines Plans:</b> <code>[base]/List/[id]/_history</code></li>
  <li><b>Eine bestimmte, bereits bekannte Version:</b> <code>[base]/List/[id]/_history/[vid]</code></li>
</ul>
<p>
Als Erweiterung des FHIR-Basisstandards können alle unten aufgeführten Suchparameter auch auf die History-Interaktion angewendet werden. Die Suche wirkt dann auf alle gespeicherten Versionen und nicht nur auf die aktuelle. Beispiel: <code>[base]/List/_history?date=ge2026-01-01</code>. Die Standard-History-Parameter (<code>_since</code>, <code>_at</code>, <code>_count</code>) bleiben zusätzlich nutzbar.
</p>
</div>

<table class="list">
  <tr>
    <td><b>Name</b></td>
    <td><b>Type</b></td>
    <td><b>Description</b></td>
    <td><b>Expression</b></td>
  </tr>
  <!-- Standard FHIR Suchparameter-->
  <tr>
    <td>_id</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Technische id der Ressource</div></td>
    <td><code>List.id</code></td>
  </tr>
  <tr>
    <td>_lastUpdated</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#date">date</a></td>
    <td><div>Timestamp der letzten Änderung der Liste</div></td>
    <td><code>List.meta.lastUpdated</code></td>
  </tr>
  <tr>
    <td>_profile</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#reference">reference</a></td>
    <td><div>Von der Liste deklarierte Profile zu denen sie angibt konform zu sein</div></td>
    <td><code>List.meta.profile</code></td>
  </tr>

  <!-- Elemente der Liste selbst -->

  <tr>
    <td>code</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div><a href="list.html">List</a>: Art der Liste (in diesem Fall: Medikationsplan)</div></td>
    <td><code>List.code</code></td>
  </tr>
  <tr>
    <td>date</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#date">date</a></td>
    <td><div>Erstellungszeitpunkt bzw. Zeitraum der Erfassung von Medikationsplanversionen</div></td>
    <td><code>List.date</code></td>
  </tr>
  <tr>
    <td>empty-reason</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div><p>Medikationsplan mit einem bestimmten Grund warum der Plan leer ist</p></div></td>
    <td><code>List.emptyReason</code></td>
  </tr>
  <tr>
    <td>item</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#reference">reference</a></td>
    <td><div><p>Medikationsplan, der einen bestimmten Planeintrag beinhaltet</p></div></td>
    <td><code>List.entry.item</code></td>
  </tr>
  <tr>
    <td>source</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#reference">reference</a></td>
    <td><div><p>Autor der letzten Änderung des Medikationsplans</p></div></td>
    <td><code>List.source</code></td>
  </tr>
  <!-- <tr>
    <td>status</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div><p>Status des Medikationsplans: current | retired </p></div></td>
    <td><code>List.status</code></td>
  </tr> -->
  <!-- ASW 29.09.26 TODO Status als Suchparameter relevant? -->
  

  <!-- Elemente des MedicationRequest, der Teil der Liste ist -->
  <tr>
    <td>medicationrequest-author</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#reference">reference</a></td>
    <td><div>Autor eines MedicationRequest, der Teil der Liste ist</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).requester</code></td>
  </tr>
  <tr>
    <td>medicationrequest-status</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Status des MedicationRequest, der Teil der Liste ist</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).status</code></td>
  </tr>
  <tr>
    <td>medicationrequest-status-reason</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Absetzgrund (StatusReason)</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).statusReason.ofType(CodeableConcept)</code></td>
  </tr>
  <tr>
    <td>medicationrequest-effectivePeriod</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#date">date</a></td>
    <td><div>Einnahmezeitraum</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.effectiveDosePeriod').value.ofType(Period)</code></td>
  </tr>
    <tr>
    <td>medicationrequest-authoredOn</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#date">date</a></td>
    <td><div>Erstellungs-/Änderungszeitpunkt</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).authoredOn</code></td>
  </tr>
  <tr>
    <td>medicationrequest-courseOfTherapyType</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Art der Medikation (Akutmedikation oder Dauermedikation): acute|continuous</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).courseOfTherapyType.ofType(CodeableConcept)</code></td>
  </tr>

  <!-- Contained Medication im MedicationRequest -->
  <tr>
    <td><a href="SearchParameter-at-elga-emed-searchparameter-list-mr-medication-code.html">medicationrequest-medication-code</a></td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Code (PZN) der enthaltenen Medication</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).medication.resolve().ofType(Medication).code.ofType(CodeableConcept)</code></td>
  </tr>
  <tr>
    <td>medicationrequest-medication-name</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#string">string</a></td>
    <td><div>Arzneimittelname der enthaltenen Medication</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).medication.resolve().ofType(Medication).code.coding.display</code></td>
  </tr>
  <tr>
    <td>medicationrequest-medication-ingredient</td>
    <td><a href="https://hl7.org/fhir/R4/search.html#token">token</a></td>
    <td><div>Wirkstoff der enthaltenen Medication</div></td>
    <td><code>List.entry.item.resolve().ofType(MedicationRequest).medication.resolve().ofType(Medication).ingredient.item.ofType(CodeableConcept)</code></td>
  </tr>
</table>