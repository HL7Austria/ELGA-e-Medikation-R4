Instance: At-Emed-Example-PractitionerRole-01
InstanceOf: AtElgaCorePractitionerRole
Title: "Beispiel Allgemeinmedizinerin 01 (Dr. Hausärztin + Organisation)"
Description: "Beispiel einer behandelnden Ärztin und ihrer Organisation"
Usage: #example
* practitioner = Reference(Practitioner/At-Emed-Example-PractitionerRole-01) "Dr. Hausärztin"
* organization = Reference(Organization/At-Emed-Example-Organization-Hausarzt-01) "Ordination"
* code = $cs-elga-gtelvogdarollen#1000 "Ärztin/Arzt"
* specialty = $cs-sct#419192003 "Internal medicine"