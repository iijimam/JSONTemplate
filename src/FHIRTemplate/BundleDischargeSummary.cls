/// 退院時サマリ用Bundle
Class FHIRTemplate.BundleDischargeSummary Extends FHIRTemplate.Resource
{

/// JSON出力する際のテンプレート
XData Template [ MimeType = application/json ]
{
{
  "resourceType": "#(..#ResourceType)#",
  "meta": {
    "profile": [
      "#(..#Profile)#"
    ]
  },
  "type": "document",
  "timestamp": "#(..TimeStamp)#",
  "entry": [
    "#(..Composition(FHIRTemplate.Bundle.entry))#",
    "#(..Patient(FHIRTemplate.Bundle.entry))#",
    "#(..Practitioner(FHIRTemplate.Bundle.entry))#",
    "#(..Organization(FHIRTemplate.Bundle.entry))#",
    "#(..Encounter(FHIRTemplate.Bundle.entry))#",
    "#(..Condition(FHIRTemplate.Bundle.entry))#",
    "#(..AllergyIntolerance(FHIRTemplate.Bundle.entry))#",
    "#(..MedicationRequest(FHIRTemplate.Bundle.entry))#",
    "#(..CarePlan(FHIRTemplate.Bundle.entry))#",
    "#(..DocumentReference(FHIRTemplate.Bundle.entry))#"
  ],
  "signature":{
    "type":[
      {
      "system":"urn:iso-astm:E1762-95:2013",
      "code":"1.2.840.10065.1.12.1.1"
      }
    ],
    "when":"#(..When)#",
    "who":{
      "reference":"urn:uuid:#(..PractitionerResourceId)#"
    },
    "data":"6aOv5bO2576O56mC5a2Q"
  }
  }
}

Parameter ResourceType = "Bundle";

Parameter Profile = "jpfhir.jp/fhir/eDischargeSummary/StructureDefinition/JP_Bundle_eDischargeSummary";

Property TimeStamp As FHIRTemplate.DataType.TimeStamp;

Property Composition As CompositionDischargeSummary [ Required ];

Property Patient As Patient [ Required ];

Property Encounter As FHIRTemplate.Encounter;

Property Practitioner As FHIRTemplate.Practitioner;

Property PractitionerResourceId As %String;

/// Property Practitioner As list Of Practitioner;
Property Organization As FHIRTemplate.Organization;

Property Condition As FHIRTemplate.Condition;

Property AllergyIntolerance As FHIRTemplate.AllergyIntolerance;

Property DocumentReference As FHIRTemplate.DocumentReference;

Property MedicationRequest As FHIRTemplate.MedicationRequest;

Property CarePlan As FHIRTemplate.CarePlan;

Property Type As FHIRTemplate.DataType.Coding;

Property When As FHIRTemplate.DataType.TimeStamp;

}
