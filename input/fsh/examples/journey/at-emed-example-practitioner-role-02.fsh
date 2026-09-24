Instance: At-Emed-Example-PractitionerRole-02
InstanceOf: AtElgaCorePractitionerRole
Title: "Beispiel PractitionerRole Apothekerin"
Description: "Beispiel einer Apothekerin (Dr. Apothekerin + Apotheke)"
Usage: #example
* practitioner = Reference(Practitioner/At-Emed-Example-Practitioner-03) "Dr. Apothekerin"
* organization = Reference(Organization/At-Emed-Example-Organization-03) "Amadeus Apotheke"
* code = $cs-elga-gtelvogdarollen#222 "Apothekerin/Apotheker"