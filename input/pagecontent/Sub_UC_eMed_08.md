{% include styleheader.md %}

<!--  Technische Use Cases für Geplante Abgabe schreiben (UC_eMed_08) -->


Im folgenden Kapitel werden die fachlichen Anwendungsfälle in Form technischer Use Cases beschrieben. Die zugehörigen Sequenzdiagramme veranschaulichen die beteiligten Akteure sowie die jeweiligen Abläufe.

Für jeden Use Case werden in den Kapiteln *Relevante Elemente* die wichtigsten Elemente der verwendeten Profile beschrieben. Dies ermöglicht eine kompakte Übersicht über die erforderlichen Anpassungen der Ressourcen im Kontext des jeweiligen Anwendungsfalls.




#### Sub_UC_eMed_08_01 - Geplante Abgabe erfassen

Ein GDA kann basierend auf bestehenden Einträgen eines Medikationsplans ein oder mehrere geplanten Abgaben erstellen (eine Rezeptierung durchführen).


<!-- Rezept/ Verordnung (PRESCRIPTION)
OFFEN, EINGELÖST, STORNIERT, ABGELAUFEN, NICHT_ABGEGEBEN


Abgabe (DISPENSE)
ABGEGEBEN, ABGESETZT, STORNIERT -->


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