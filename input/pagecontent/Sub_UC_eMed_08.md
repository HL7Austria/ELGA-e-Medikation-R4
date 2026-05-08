{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_08) -->

Im folgenden Kapitel werden die fachlichen Anwendungsfälle in Form technischer Use Cases beschrieben. Die zugehörigen Sequenzdiagramme veranschaulichen die beteiligten Akteure sowie die jeweiligen Abläufe.

Für jeden Use Case werden in den Kapiteln *Relevante Elemente* die wichtigsten Elemente der verwendeten Profile beschrieben. Dies ermöglicht eine kompakte Übersicht über die erforderlichen Anpassungen der Ressourcen im Kontext des jeweiligen Anwendungsfalls.
 

#### Sub_UC_eMed_08_01 - Geplante Abgabe basierend auf bestehenden Planeintrag erfassen (unverändert)

Ein GDA kann basierend auf einem bestehenden Medikationsplaneintrag ein oder mehrere geplanten Abgaben erstellen und das Erzeugen eines e-Rezepts auslösen.

Sollte für die geplante Abgabe noch kein zugehöriger Medikationsplaneintrag existieren, muss dieser zuerst erstellt werden (siehe *Sub_UC_eMed_06_03 - Medikationsplaneintrag in Medikationsplan hinzufügen*).

Ist keine Anpassung des Medikationsplaneintrags erforderlich, führt der GDA ein GET auf das Collection Bundle aus, das den Medikationsplan mit allen zugehörigen relevanten Ressourcen enthält ([Read-only-Zugriff](interactions.html#read-only-zugriff)).
Basierend auf vorhandenen Planeinträgen (MedicationRequests) erstellt der GDA neue Geplante Abgaben (MedicationRequest) wie folgt:
- Der Status der neuen geplanten Abgabe ist offen (*active*) 
- Die Rezeptart muss verpflichtend ausgewählt werden (*Kassenrezept, Privatrezept* oder *Substitutionsrezept*)
- Die Medikation ist gemäß Planeintrag zu übernehmen. Enthält der Planeintrag ausschließlich Wirkstoffe, ist ein entsprechendes Medikament aus der ASP-Liste (inkl. PZN) bzw. eine magistrale Zubereitung zu dokumentieren. 
<!-- TODO: prüfen, ob die Medikation ist gemäß Planeintrag zu übernehmen ist -->
- Werden mehrere geplante Abgaben zeitgleich erstellt, können diese mittels gleichem groupIdentifier (*e-Med-ID*) versehen werden ("Rezeptklammer", die auch im e-Rezept mitgeführt wird). Diese eindeutige Kennung kann von der Fachanwendung über eine Schnittstelle angefordert werden und ermöglicht berechtigten Akteuren eine gezielte Suche nach geplanten Abgaben. 
- Die Dosierangaben können angepasst werden
- Der Gültigkeitszeitraum (*dispenseRequest.validityPeriod*) innerhalb dessen geplante Abgaben eingelöst werden können, 
- sowie die Anzahl möglicher weiterer Einlösungen (*dispenseRequest.numberOfRepeatsAllowed*) ist abhängig dem der ausgewählten **Rezeptart** 
- Die Menge des Medikaments, die bei jeder Abgabe bereitgestellt werden soll, ist zu dokumentieren
(*dispenseRequest.quantity*).
<!-- TODO Suchparameter emed-id: alle geplanten abgaben zu einer e-med-id finden -->


##### Ablauf

<!-- <div>{ include_relative plantuml/UC_eMed_08_01.svg }</div> -->


##### Relevante Elemente (List)

```JSON
AtEmedMRGeplanteAbgabe
    status: active 
    category:recipetype                     // Verpflichtende Angabe der Rezeptart
    medicationReference.reference: Medikation mit PZN oder Magistrale Anwendung // Contained Medication, diese muss der Medikation aus dem Medikationsplaneintrag entsprechen
    authoredOn: Datum der Erstellung des Medikationsplaneintrags    
    requester: veranwortlicher GDA         // wird auf Übereinstimmung mit List.source geprüft
    basedOn: Referenz auf den zugehörigen Medikationsplaneintrag 
    groupIdentifier: e-Med-ID              // Rezeptklammer 
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft) 
    dispenseRequest.validityPeriod         // abhängig von Rezeptart, bzw. verkürzt durch gda
    dispenseRequest.numberOfRepeatsAllowed // abhängig von Rezeptart
    dispenseRequest.quantity
```

#### Sub_UC_eMed_08_02 - Geplante Abgabe basierend auf neuem Planeintrag erfassen

<!-- Rezept/ Verordnung (PRESCRIPTION)
<!-- | **active** | offene geplante Abgabe |


<!-- Relevante Elemente  -->

<!-- status | **active** | Neue geplante Abgabe |
category:recipetype  //rezeptart muss angegeben sein
medication[x] // medikation muss der medikation aus dem medikationsplaneintrag entsprechen
authoredOn
requester
basedOn  //der zugehörige medikationsplaneintrag muss referenziert werden
groupIdentifier // Rezeptklammer (vom e-Rezept?)
dosageInstruction
dispenseRequest.validityPeriod  // abh. von rezeptart, bzw. verkürzt durch gda
dispenseRequest.numberOfRepeatsAllowed // abh. von rezeptart
dispenseRequest.quantity



todo: muss die dosierung mit planeintrag übereinstimmen? was muss die fachanwendung prüfen muss? was darf von planeintrag abweichen?

 -->



#### Sub_UC_eMed_08_02 - Geplante Abgabe beenden

<!-- |  **completed**  | geplante Abgabe beendet |

Nach der letztmöglichen durchgeführten Abgabe zur geplanten Abgabe, setzt die Fachanwendung den Status der geplanten Abgabe auf beendet.


#### Sub_UC_eMed_08_03 - Geplante Abgabe stornieren


<!-- |  **entered-in-error**  | geplante Abgabe storniert|

$geplante-Abgabe-stornieren 


#### Sub_UC_eMed_08_03 - Geplante Abgabe durch ELGA-Teilnehmer löschen

$delete oder DELETE -->




#### Beispiel

#### Technische Hinweise

#### Relevante Profile

#### Relevante Invarianten

#### Mögliche Notifications