Instance: At-Emed-Example-PractitionerRole-03
InstanceOf: AtElgaCorePractitionerRole
Title: "Beispiel PractitionerRole Ärztin im Krankenhaus"
Description: "Beispiel einer Ärztin im Krankenhaus (Dr. Krankenhaus + Organisation)"
Usage: #example
* practitioner = Reference(Practitioner/At-Emed-Example-Practitioner-03) "Dr. Krankenhaus"
* organization = Reference(Organization/At-Emed-Example-Organization-03) "Krankenhaus"
* code = $cs-elga-gtelvogdarollen#107 "Fachärztin/Facharzt für Chirurgie"
* specialty = $cs-sct#419192003 "Internal medicine"