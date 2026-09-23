Instance: At-Emed-Example-PractitionerRole-04
InstanceOf: AtElgaCorePractitionerRole
Title: "Beispiel PractitionerRole Urlaubsvertretung"
Description: "Beispiel einer Urlaubsvertretung und ihrer Organisation (Dr. Urlaubsvertretung + Ordination)"
Usage: #example
* practitioner = Reference(Practitioner/At-Emed-Example-Practitioner-04) "Dr. Urlaubsvertretung"
* organization = Reference(Organization/At-Emed-Example-Organization-04) "Ordination Dr. Urlaubsvertretung"
* code = $cs-elga-gtelvogdarollen#1000 "Ärztin/Arzt"
//* specialty = $cs-sct#419192003 "Internal medicine"