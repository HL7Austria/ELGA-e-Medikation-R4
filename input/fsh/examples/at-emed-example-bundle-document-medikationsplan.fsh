Instance: AtEmedExampleBundleDocumentMedikationsplan01
InstanceOf: AtEmedBundleDocumentMedikationsplan
Title: "Beispiel eines Document Bundles Medikationsplan 1"
Description: "Beispiel eines Document Bundles Medikationsplan 1"
Usage: #example

* type = #document
* timestamp = "2024-10-03T10:12:00+02:00"

// Composition zuerst
* entry[0].fullUrl = "Composition/example-composition"
* entry[0].resource = ExampleMedikationsplanComposition

* entry[+].fullUrl = "MedicationRequest/med1"
* entry[=].resource = ExamplePlaneintragMed1

* entry[+].fullUrl = "MedicationRequest/med2"
* entry[=].resource = ExamplePlaneintragMed2

* entry[+].fullUrl = "List/planlist"
* entry[=].resource = ExampleMedikationsplanList


Instance: ExampleMedikationsplanComposition
InstanceOf: AtEmedCompositionMedikationsplan
Usage: #example

* status = #final
* type = $cs-sct#736378000 "Medikationsplan"
* subject = Reference(Patient/ExamplePatient)
* date = "2024-10-03T10:12:00+02:00"
* author = Reference(Practitioner/ExampleArzt)
* title = "Medikationsplan"

* section.code = #medikationsplan "Medikationsplan"
* section.entry[0] = Reference(MedicationRequest/med1)
* section.entry[1] = Reference(MedicationRequest/med2)
* section.entry[2] = Reference(List/planlist)


Instance: ExampleMedikationsplanList
InstanceOf: AtEmedListMedikationsplan
Usage: #example

* status = #current
* mode = #working
* orderedBy = #user

* entry[0].flag = #original
* entry[0].item = Reference(MedicationRequest/med1)

* entry[1].flag = #original
* entry[1].item = Reference(MedicationRequest/med2)


Instance: ExamplePlaneintragMed1
InstanceOf: AtEmedMedicationRequestPlaneintrag
Usage: #example

* status = #active
* intent = #order
* category.coding = #1 "Medikationsplaneintrag"
* medicationCodeableConcept = $cs-asp-liste#2443061 "EBETREXAT TBL 10MG"
* subject = Reference(Patient/ExamplePatient)
* authoredOn = "2024-10-03"
* requester = Reference(Practitioner/ExampleArzt)
* dosageInstruction.text = "1x morgens"


Instance: ExamplePlaneintragMed2
InstanceOf: AtEmedMedicationRequestPlaneintrag
Usage: #example

* status = #active
* intent = #order
* category.coding = #1 "Medikationsplaneintrag"
* medicationCodeableConcept = $cs-asp-liste#3847199 "AMLODIPIN 5MG"
* subject = Reference(Patient/ExamplePatient)
* authoredOn = "2024-10-03"
* requester = Reference(Practitioner/ExampleArzt)
* dosageInstruction.text = "1x täglich"


Instance: ExamplePatient
InstanceOf: HL7ATCorePatient
* name[0].family = "Test"
* name[0].given[0] = "Erika"
* gender = #female
* birthDate = "1970-02-14"


Instance: ExampleArzt
InstanceOf: HL7ATCorePractitioner
* name.family = "Hausarzt"
* name.given = "Max"