Profile: AtEmedListMedikationsplan
Parent: List
Id: at-emed-list-medikationsplan
Title: "ELGA e-Medikation Medikationsplan"
Description: "**Beschreibung:** Bildet den Medikationsplan eines ELGA Teilnehmers ab. Enthält verordnete Arzneimittel und deren Dosierung in Form von 0..* Medikationsplaneinträgen (AtEmedMedicationRequestPlaneintrag). "


// Resource: List
// Id: List
// Description: "A list is a curated collection of resources."

// * obeys lst-3 and lst-2 and lst-1
// * . ^short = "A list is a curated collection of resources"
// * . ^definition = "A list is a curated collection of resources."
// * . ^alias[0] = "Collection"
// * . ^alias[+] = "WorkingList"
// * . ^alias[+] = "Organizer"
// * identifier 0..* Identifier "Business identifier" "Identifier for the List assigned for business purposes outside the context of FHIR."
// * status 1..1 ?! SU code "current | retired | entered-in-error" "Indicates the current state of this list."
// * status from http://hl7.org/fhir/ValueSet/list-status|4.0.1 (required)
// * status ^comment = "This element is labeled as a modifier because the status contains codes that mark the resource as not currently valid."
// * status ^isModifierReason = "This element is labeled as a modifier because it is a status element that contains status entered-in-error which means that the resource should not be treated as valid"
// * status ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * status ^binding.extension.valueString = "ListStatus"
// * status ^binding.description = "The current state of the list."
// * mode 1..1 ?! SU code "working | snapshot | changes" "How this list was prepared - whether it is a working list that is suitable for being maintained on an ongoing basis, or if it represents a snapshot of a list of items from another source, or whether it is a prepared list where items may be marked as added, modified or deleted."
// * mode from http://hl7.org/fhir/ValueSet/list-mode|4.0.1 (required)
// * mode ^comment = "This element is labeled as a modifier because a change list must not be misunderstood as a complete list."
// * mode ^requirements = "Lists are used in various ways, and it must be known in what way it is safe to use them."
// * mode ^isModifierReason = "If set to \"changes\", the list is considered incomplete, while the other two codes indicate the list is complete, which changes the understanding of the elements listed"
// * mode ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * mode ^binding.extension.valueString = "ListMode"
// * mode ^binding.description = "The processing mode that applies to this list."
// * title 0..1 SU string "Descriptive name for the list" "A label for the list assigned by the author."
// * title ^requirements = "Allows customization beyond just the code identifying the kind of list."
// * title ^example.label = "General"
// * title ^example.valueString = "Dr. Jane's Patients"
// * code 0..1 SU CodeableConcept "What the purpose of this list is" "This code defines the purpose of the list - why it was created."
// * code from http://hl7.org/fhir/ValueSet/list-example-codes (example)
// * code ^comment = "If there is no code, the purpose of the list is implied where it is used, such as in a document section using Document.section.code."
// * code ^requirements = "Lists often contain subsets of resources rather than an exhaustive list.  The code identifies what type of subset is included."
// * code ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * code ^binding.extension.valueString = "ListPurpose"
// * code ^binding.description = "What the purpose of a list is."
// * subject 0..1 SU Reference(http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/Group or http://hl7.org/fhir/StructureDefinition/Device or http://hl7.org/fhir/StructureDefinition/Location) "If all resources have the same subject" "The common subject (or patient) of the resources that are in the list if there is one."
// * subject ^comment = "Some purely arbitrary lists do not have a common subject, so this is optional."
// * subject ^requirements = "The primary purpose of listing the subject explicitly is to help with finding the right list."
// * encounter 0..1 Reference(http://hl7.org/fhir/StructureDefinition/Encounter) "Context in which list created" "The encounter that is the context in which this list was created."
// * date 0..1 SU dateTime "When the list was prepared" "The date that the list was prepared."
// * date ^comment = "The actual important date is the date of currency of the resources that were summarized, but it is usually assumed that these are current when the preparation occurs."
// * date ^requirements = "Identifies how current the list is which affects relevance."
// * source 0..1 SU Reference(http://hl7.org/fhir/StructureDefinition/Practitioner or http://hl7.org/fhir/StructureDefinition/PractitionerRole or http://hl7.org/fhir/StructureDefinition/Patient or http://hl7.org/fhir/StructureDefinition/Device) "Who and/or what defined the list contents (aka Author)" "The entity responsible for deciding what the contents of the list were. Where the list was created by a human, this is the same as the author of the list."
// * source ^comment = "The primary source is the entity that made the decisions what items are in the list. This may be software or user."
// * source ^requirements = "Allows follow-up as well as context."
// * source ^alias[0] = "Author"
// * orderedBy 0..1 CodeableConcept "What order the list has" "What order applies to the items in the list."
// * orderedBy from http://hl7.org/fhir/ValueSet/list-order (preferred)
// * orderedBy ^comment = "Applications SHOULD render ordered lists in the order provided, but MAY allow users to re-order based on their own preferences as well. If there is no order specified, the order is unknown, though there may still be some order."
// * orderedBy ^requirements = "Important for presentation and rendering.  Lists may be sorted to place more important information first or to group related entries."
// * orderedBy ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * orderedBy ^binding.extension.valueString = "ListOrder"
// * orderedBy ^binding.description = "What order applies to the items in a list."
// * note 0..* Annotation "Comments about the list" "Comments that apply to the overall list."
// * entry 0..* BackboneElement "Entries in the list" "Entries in this list."
// * entry ^comment = "If there are no entries in the list, an emptyReason SHOULD be provided."
// * entry ^condition = "lst-1"
// * entry.flag 0..1 CodeableConcept "Status/Workflow information about this item" "The flag allows the system constructing the list to indicate the role and significance of the item in the list."
// * entry.flag from http://hl7.org/fhir/ValueSet/list-item-flag (example)
// * entry.flag ^comment = "The flag can only be understood in the context of the List.code. If the flag means that the entry has actually been deleted from the list, the deleted element SHALL be true. Deleted can only be used if the List.mode is \"changes\"."
// * entry.flag ^requirements = "This field is present to support various clinical uses of lists, such as a discharge summary medication list, where flags specify whether the medication was added, modified, or deleted from the list."
// * entry.flag ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * entry.flag ^binding.extension.valueString = "ListItemFlag"
// * entry.flag ^binding.description = "Codes that provide further information about the reason and meaning of the item in the list."
// * entry.deleted 0..1 ?! boolean "If this item is actually marked as deleted" "True if this item is marked as deleted in the list."
// * entry.deleted ^comment = "If the flag means that the entry has actually been deleted from the list, the deleted element SHALL be true. Both flag and deleted can only be used if the List.mode is \"changes\". A deleted entry should be displayed in narrative as deleted.  This element is labeled as a modifier because it indicates that an item is (to be) no longer in the list."
// * entry.deleted ^requirements = "The flag element may contain codes that an application processing the list does not understand. However there can be no ambiguity if a list item is actually marked as \"deleted\"."
// * entry.deleted ^meaningWhenMissing = "List items are generally only treated as deleted when this element explicitly carries a value of true. Systems SHOULD always populate this value when mode is 'changes'"
// * entry.deleted ^condition = "lst-2"
// * entry.deleted ^isModifierReason = "If deleted is true, then the item included in the list isn't actually part of the list anymore"
// * entry.date 0..1 dateTime "When item added to list" "When this item was added to the list."
// * entry.date ^requirements = "The date may be significant for understanding the meaning of items in a working list."
// * entry.item 1..1 Reference(http://hl7.org/fhir/StructureDefinition/Resource) "Actual entry" "A reference to the actual resource from which data was derived."
// * emptyReason 0..1 CodeableConcept "Why list is empty" "If the list is empty, why the list is empty."
// * emptyReason from http://hl7.org/fhir/ValueSet/list-empty-reason (preferred)
// * emptyReason ^comment = "The various reasons for an empty list make a significant interpretation to its interpretation. Note that this code is for use when the entire list has been suppressed, and not for when individual items are omitted - implementers may consider using a text note or a flag on an entry in these cases."
// * emptyReason ^requirements = "Allows capturing things like \"none exist\" or \"not asked\" which can be important for most lists."
// * emptyReason ^condition = "lst-1"
// * emptyReason ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
// * emptyReason ^binding.extension.valueString = "ListEmptyReason"
// * emptyReason ^binding.description = "If a list is empty, why it is empty."

// Invariant: lst-3
// Description: "An entry date can only be used if the mode of the list is \"working\""
// * severity = #error
// * expression = "mode = 'working' or entry.date.empty()"
// * xpath = "(f:mode/@value = 'working') or not(exists(f:entry/f:date))"

// Invariant: lst-2
// Description: "The deleted flag can only be used if the mode of the list is \"changes\""
// * severity = #error
// * expression = "mode = 'changes' or entry.deleted.empty()"
// * xpath = "(f:mode/@value = 'changes') or not(exists(f:entry/f:deleted))"

// Invariant: lst-1
// Description: "A list can only have an emptyReason if it is empty"
// * severity = #error
// * expression = "emptyReason.empty() or entry.empty()"
// * xpath = "not(exists(f:emptyReason) and exists(f:entry))"

// Mapping: rim
// Id: rim
// Title: "RIM Mapping"
// Source: List
// Target: "http://hl7.org/v3"
// * -> "Act[classCode<ORG,moodCode=EVN]"
// * identifier -> ".id"
// * status -> ".status[current=active;retired=obsolete;entered-in-error=nullified]"
// * mode -> ".outBoundRelationship[typeCode=COMP].target[classCode=OBS\"].value"
// * title -> ".title"
// * code -> ".code"
// * subject -> ".participation[typeCode<SUB].role (and sometimes .player)"
// * encounter -> "inboundRelationship[typeCode=COMP].source[classCode=ENC, moodCode=EVN]"
// * date -> ".participation[typeCode<AUT].time[type=TS]"
// * source -> ".participation[typeCode<AUT].role[classCode=REL].player[classCode=PSN,determinerCode=INST] or .participation[typeCode<AUT].role[classCode=REL].player[classCode=DEV,determinerCode=INST]"
// * orderedBy -> ".outboundRelationship[typeCode=COMP].sequenceNumber > 1"
// * note -> ".inboundRelationship[typeCode=SUBJ].act.text"
// * entry -> ".outboundRelationship[typeCode=COMP] or  .participation[typeCode=SBJ]"
// * entry.flag -> ".outBoundRelationship[typeCode=COMP].target[classCode=OBS\"].value"
// * entry.deleted -> "added: .updateMode=(\"A\",\"AR\")  retained: .updateMode=\"NC\"  updated: .updateMode=\"R\"  deleted: .updateMode=\"D\""
// * entry.date -> ".availabilityTime"
// * entry.item -> ".target or .role or .role.entity"
// * emptyReason -> ".inboundRelationship[typeCode=SUBJ,code<ListEmptyReason].value[type=CD]"

// Mapping: w5
// Id: w5
// Title: "FiveWs Pattern Mapping"
// Source: List
// Target: "http://hl7.org/fhir/fivews"
// * identifier -> "FiveWs.identifier"
// * status -> "FiveWs.status"
// * mode -> "FiveWs.class"
// * code -> "FiveWs.what[x]"
// * subject -> "FiveWs.subject[x]"
// * subject -> "FiveWs.subject"
// * encounter -> "FiveWs.context"
// * date -> "FiveWs.recorded"
// * source -> "FiveWs.author"