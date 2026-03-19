ValueSet: DurchgefuehrteAbgabeTypVS
Title: "ELGA e-Med Durchgeführte Abgabe Typ Value Set"
Description: "ValueSet für zulässige Ausprägungen eines Typs einer durchgeführten Abgabe (MedicationDispense)."
//https://terminology.hl7.org/7.1.0/en/ValueSet-v3-ActPharmacySupplyType.html

* ^experimental = true

* include $cs-medication-dispense-type#FFC "First Fill - Complete"  // vollständig erfüllte Bestellungen
* include $cs-medication-dispense-type#FFP "First Fill - Part Fill"  // teilweise erfüllte Bestellungen
* include $cs-medication-dispense-type#RFP "Refill - Part Fill"
* include $cs-medication-dispense-type#RFC "Refill - Complete"  // Rezept vollständig eingelöst (alle Teilabgaben)