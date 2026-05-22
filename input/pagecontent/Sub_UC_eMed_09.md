{% include styleheader.md %}

<!-- Technische Use Cases für Durchgeführte Abgabe schreiben (UC_eMed_09) -->

### Sub_UC_eMed_09_01 - Durchgeführte Abgabe erfassen

Der GDA (Apotheke bzw. Arzt mit Hausapotheke) kann eine [Durchgeführte Abgabe](design_choices.html#durchgeführte-abgabe-AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe-medicationdispense) für einen ELGA-Teilnehmer erfassen, um die Abgabe eines Medikamentes medizinisch zu dokumentieren.

Sofern eine zugehörige [Geplante Abgabe](design_choices.html#geplante-abgabe-atelgaemedmedicationrequestgeplanteabgabe-medicationrequest) vorliegt, **muss** diese im Element *authorizingPrescription* referenziert werden. 

Die in der *Geplanten Abgabe* dokumentierte [Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart) (bzw. eine evtl. Einschränkung durch den GDA (Arzt) im Element *MedicationRequest.numberOfRepeatsAllowed*), legt fest wieviele Abgaben durchgeführt werden dürfen. 

Der aktuelle Status einer *Durchgeführten Abgabe* wird mittels *MedicationDispense.status*- und *MedicationDispense.type*-Element dokumentiert (siehe [Status des MedicationDispense in der durchgeführten Abgabe](workflowmanagement.html#status-des-medicationdispense-in-der-durchgeführten-abgabe)) und kann sich auf den Status der zugehörigen *Geplanten Abgabe* auswirken.


Folgende Tabelle bildet eine Übersicht über alle Varianten von (Teil-)Abgaben:
- Einzelabgabe
- Besorgerprozess
- Teilabgaben
- Leerabgaben
<br>

#### Varianten der (Teil-)Abgabe 

Im Element *MedicationDispense.type* einer durchgeführten Abgabe wird die Art der Abgabe dokumentiert, welche von der [Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart) (Anzahl Einlösungen) und vom Use Case abhängt.

| Use Case (pro Einlösung)                                   | Geplante Abgabe (MedicationRequest.status)                   | Beschreibung                                                                                          | Durchgeführte Abgabe (MedicationDispense)                                                             | Beschreibung                                                                                                                                                                               |
| ---------------------------------------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Vollständige Abgabe (Einzelabgabe)                         | complete, wenn letzte Eilnlösung abgeschlossen, sonst active | geplante Abgabe wird nach erfolgter Dispense automatisch  auf complete gesetzt                        | type: FFC (First Fill - Complete)<br>quantity:  x Packungen<br>status: „complete“                            | Dispense abgeschlossen; Kann nicht mehr verändert werden.                                                                                                                                  |
| "Besorgerprozess": Medikament von Apotheke bestellt        | active                                                       | geplante Abgabe bleibt active                                                                         | type: FFP (First Fill - Part Fill)<br>quantity:  0 Packungen (wurden  ausgegeben)<br>status: „preparation?“   | Medikament bestellt oder Magistrale Zubereitung in Vorbereitung. Geplante Abgabe kann nicht mehr in einer anderen Apotheke abgegeben werden                                                |
| "Besorgerprozess": bestelltes Medikament wird ausgehändigt | complete                                                     | wenn Dispense complete, dann auch geplante Abgabe complete                                            | type: RFC (Refill - Complete)<br>quantity:  x Packungen<br>status: „complete“                                | Durchgeführte Abgabe abgeschlossen                                                                                                                                                         |
| 1\. Teilabgabe                                             | active                                                       | geplante Abgabe bleibt active                                                                         | type: FFP (First Fill - Part Fill)<br>quantity:  x Packungen<br>status: „complete“                           | 1\. Teilabgabe                                                                                                                                                                             |
| Weitere Teilabgabe                                         | active                                                       | geplante Abgabe bleibt active                                                                         | type: RFP (Refill - Part Fill)<br>quantity:  x Packungen<br>status: „complete“                               | weitere Teilabgabe                                                                                                                                                                         |
| Letzte Teilabgabe                                          | complete                                                     | nach der letzten Teilabgabe wird die geplante Abgabe automatisch auf complete gesetzt                 | type:  RFC (Refill - Complete)<br>quantity:  x Packungen<br>status: „complete“                               | letzte Teilabgabe                                                                                                                                                                          |
| Leerabgabe bei Einzelabgabe                               | complete                                                     | die geplante Abgabe wird automatisch auf complete gesetzt                                             | type: FFC (First Fill - Complete) bzw. RFC (Refill Complete)<br>quantity:  0 Packungen<br>status: „cancelled“ | Das Medikament einer geplanten Abgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt.                                                                                 |
| Leerabgabe beendet Teilabgaben                             | complete                                                     | nach einer Leerabgabe bei einer  Teilabgabe wird die geplante Abgabe automatisch auf complete gesetzt | type: RFC (Refill - Complete)<br>quantity:  0 Packungen<br>status: „cancelled“                                | Das Medikament einer geplanten Abgabe wird vom Patienten nicht benötigt und daher als Leerabgabe vermerkt. Dieser Einlösevorgang ist damit beendet.                                        |
| Notabgabe                                                  |  -                                                           | keine geplante Abgabe vorhanden                                                                       | type: EM (Emergency Supply)<br>quantity:  x Packungen<br>status: „complete“                                  | Das Medikament wurde ohne zugrundeliegende geplante Abgabe abgegeben.<br>Es wird kein Rezept nachgereicht                                                                                  |
| Rezept wird nachgebracht                                   |  -                                                           | keine geplante Abgabe vorhanden                                                                       | type: SO (Script Owing)<br>quantity:  x Packungen<br>status: „complete“                                      | Medikament wurde abgegeben oder reserviert, das formale Rezept wird später nachgereicht.  Planeintrag + geplante Abgabe für Wechselwirkungsrelevante Medikatmente soll nacherfasst werden. |
| OTC Abgabe (rezeptfrei)                                    |  -                                                           | keine geplante Abgabe vorhanden                                                                       | type: OTC (hinzufügen)<br>quantity:  x Packungen<br>status: „complete“                                       | Rezeptfreies Medikament wurde abgegeben. Ein Planeintrag für Wechselwirkungsrelevante Medikatmente soll nacherfasst werden.                                                                |

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe mit Bezug zu einer geplanten Abgabe erfassen (Vollständige Abgabe)

Nach der letztmöglichen Einlösung (und Erstellung einer *Durchgeführten Abgabe* mit Status *complete*) setzt die Fachanwendung die zugehörige *Geplante Abgabe* auf den Status *completed* (siehe[Sub_UC_eMed_08_02 - Geplante Abgabe beenden (durch Fachanwendung)](Sub_UC_eMed_08.html#sub_uc_emed_08_02---geplante-abgabe-beenden-durch-fachanwendung)).

Wenn die geplante Abgabe nur eine einmalige Einlösung ermöglicht (z.B. Kassenrezept), erkennt die Fachanwendung durch die Kombination aus MedicationDispense.type enthält *X-fill complete* (und Status *complete*) und Geplante Abgabe MedicationReqeust.numberOfRepeatsAllowed == 0, dass die geplante Abgabe abgeschlossen ist und setzt deren Status auf complete. Wenn die geplante Abgabe eine mehrmalige Einlösungen (numberOfRepeatsAllowed) ermöglicht (z.B. Privatrezept), bleibt der Status der geplanten Abgabe weiterhin active bis die letzte Einlösung erfolgt ist.

<!-- teilabgabe kann abgabe eines teils, bestellung (gesamtbesllung oder teil) oder leerabgabe status cancelled -->

#### Relevante Elemente (MedicationDispense)

```JSON
AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe
    recorded: Datum der Erstellung der Durchgeführten Abgabe
    status: completed  
    statusReasonCodeableConcept: Wert aus Valueset (in Arbeit)        // optionale Begründung für den Status https://hl7.org/fhir/R4/valueset-medicationdispense-status-reason.html     
    medicationReference.reference: Tatsächlich abgegebenes Medikament // Contained Medication
    authoredOn: Datum der Erstellung der Durchgeführten Abgabe
    performer: veranwortlicher GDA (Apotheke) für die Durchgeführte Abgabe 
    authorizingPrescription: Verpflichtende Referenz auf zugehörige Geplante Abgabe
    type: FFC (First Fill - Complete) | (Part Fill - Complete) // Art der Abgabe
    quantity: Abgebende Menge (Packungen) je Abgabe
    whenHandedOver: Der Zeitpunkt, zu dem das abgegebene Produkt ausgehändigt wurde
    dosageInstruction: Dosierung + Einnahmezeitraum (ab sofort | in der Zukunft)  // angepasst an abgegebene Medikation
```

<!-- #### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe als vollständige Abgabe (Einzelabgabe) erfassen -->

<!-- Werden geplante Abgaben mit einer [Rezeptart](workflowmanagement.html#gültigkeit-von-geplanten-abgaben-basierend-auf-der-rezeptart), die nur einmalig eingelöst werden,  


geplante Abgabe wird nach erfolgter Dispense automatisch  auf complete gesetzt

Dispense abgeschlossen; Kann nicht mehr verändert werden. -->
<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe ohne Bezug zu einer geplanten Abgabe erfassen

In folgenden Fällen liegt bei der Erfassung einer *Durchgeführten Abgabe* keine zugehörige *Durchgeführte Abgabe* vor:
- Notabgabe (Rezept wird nachgebracht)
<!-- (d.h. es muss im nachhinein ein Planeintrag und eine geplante Abgabe erstellt werden (Nacherfassung) und die geplante Abgabe muss die bereits erstellten durchgeführte Abgabe referenzieren?) Usecase? -->
- OTC Medikation (nicht rezeptpflichtig):
    - für wechselwirkungsrelevante Medikamente (aus ASP-Liste) soll eine *Durchgeführte Abgabe* erstellt werden

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe mit Besorgerprozess erfassen

- "Besorgerprozess": Medikament von Apotheke bestellt oder Magistrale Zubereitung in Vorbereitung
- "Besorgerprozess": bestelltes Medikament wird ausgehändigt

<!-- Geplante Abgabe kann nicht mehr in einer anderen Apotheke eingelöst werden 
und Teilabgabe -->

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe als Teilabgaben erfassen

- 1. Teilabgabe 
- Weitere Teilabgabe
- Letzte Teilabgabe

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe als Leerabgabe erfassen

- Leerabgabe bei Einzelabgabe
- Leerabgabe beendet Teilabgaben

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe Nacherfassen

Eine *Durchgeführte Abgabe* muss nacherfasst werden, wenn das Arzneimittel bereits abgegeben wurde, 
    - aber eine Speicherung zum Zeitpunkt der Abgabe aus technischen Gründen nicht möglich war
    - der Arzneimittelbezug aus dem Ausland erfolgt ist (Element *recorded* abweichend von *whenHandedOver*)
    - wenn ein e-Rezept-Eintrag oder ein Papierrezept vorhanden ist und keine geplante Abgabe in e-Medikation eingetragen wurden.

In Arbeit.

<br>

#### Sub_UC_eMed_09_01_0x Durchgeführte Abgabe mit Substitution eines Medikaments erfassen

Eine Substitution eines Medikaments ist nur implizit ersichtich, durch die Referenz auf die zugehörige geplante Abgabe.

<!-- Begrüdung verpflichtend? -->
<br>

### Sub_UC_eMed_09_02 - Durchgeführte Abgabe verwerfen

Ein GDA (Apotheke) kann jede bestehende [Durchgeführte Abgabe](design_choices.html#durchgeführte-abgabe-AtElgaEmedMedicationDispenseDurchgefuehrteAbgabe-medicationdispense) aufgrund einer fehlerhaften Eingabe verwerfen (auch wenn er diese nicht selbst erstellt hat). 

Um eine *Durchgeführte Abgabe* zu verwerfen, ruft der GDA diese mittels GET MedicationDispense ab und bearbeitet diese wie folgt:
- Der Status wird auf *entered-in-error* gesetzt,
- der verantwortliche GDA (*requester*) und das Datum in *authoredOn* werden entsprechend aktualisiert.

Die stornierte *Durchgeführte Abgabe* wird damit abgeschlossen, kann aber über die Historie eingesehen werden.
<!-- TODO: Suchparameter nach stornierten Durchgeführten Abgaben? -->
<!-- TODO: kann ein GDA (Apotheke) die Durchgeführte Abgabe eines anderen GDAs verwerfen oder nur die eigenen (wie im CDA)? Wenn auch fremde, woher soll er wissen, dass es ein Irrtum war? Begründung f Statuswechsel? -->
<!-- TODO: Wenn stornierte *Durchgeführte Abgabe* Teil eines e-Rezepts mit weiteren geplanten Abgaben ist: Auswirkungen? keine -->
<br>

### Sub_UC_eMed_09_03 - Durchgeführte Abgabe löschen (durch ELGA-Teilnehmer)

Der ELGA-Teilnehmer kann eine *Durchgeführte Abgabe* endgültig löschen. 

Die Löschung der *Durchgeführten Abgabe* umfasst:

- die fachliche Entfernung der betreffenden MedicationDispense-Ressource sowie
- die Entfernung aller zugehörigen historischen Ressourcenversionen (_history).

Zum Löschen einer *Durchgeführte Abgabe* ruft der ELGA-Teilnehmer die betreffende *Durchgeführte Abgabe* im ELGA-Portal auf. Dieses führt zunächst eine Leseoperation auf die betreffende MedicationDispense-Ressource aus (GET MedicationDispense/[id]) und löscht anschließend die betreffende geplante Abgabe mittels DELETE (DELETE [base]/MedicationDispense/[id]).

Die Ressource einschließlich aller historischen Versionen darf nach erfolgreicher Löschung weder über reguläre FHIR-Interaktionen noch über administrative Schnittstellen abrufbar sein.
<!-- Todo: Auswirkunung auf bestehende geplante Abgaben? Darf nicht wieder active werden -->

<!-- #### Beispiel

#### Technische Hinweise

#### Relevante Profile

#### Relevante Invarianten

#### Mögliche Notifications -->