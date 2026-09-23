Instance: At-Emed-Example-PractitionerRole-01
InstanceOf: AtElgaCorePractitionerRole
Title: "Beispiel PractitionerRole Allgemeinmedizinerin 01"
Description: "Beispiel einer Allgemeinmedizinerin und ihrer Organisation (Dr. Hausärztin + Ordination)"
Usage: #example
* practitioner = Reference(Practitioner/At-Emed-Example-Practitioner-01) "Dr. Hausärztin"
* organization = Reference(Organization/At-Emed-Example-Organization-01) "Ordination Dr. Hausärztin"
* code = $cs-elga-gtelvogdarollen#1000 "Ärztin/Arzt"
//* specialty = $cs-sct#419192003 "Internal medicine"