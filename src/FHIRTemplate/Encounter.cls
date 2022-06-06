Class FHIRTemplate.Encounter Extends Resource
{

Parameter ResourceType = "Encounter";

Property Identifier As FHIRTemplate.DataType.Identifier;

Property Class As FHIRTemplate.Examples.ActCode;

Property ClassHistoryClass As FHIRTemplate.Examples.ActCode;

Property ClassHistoryPeriod As FHIRTemplate.DataType.Period;

Property Period As FHIRTemplate.DataType.Period;

Property Length As FHIRTemplate.DataType.Duration;

/// reasonCode.coding.0.systemが記入できる場合コードで。MEDIS：標準病名マスター病名交換用コードが例にある（urn:oid:1.2.392.200119.4.101.6）
Property ReasonCode As list Of FHIRTemplate.Examples.ByomeiCode;

/// Diagnosis
Property Diagnosis As FHIRTemplate.Encounter.diagnosis;

/// Organizationリソース
Property HospitalizationOrigin As FHIRTemplate.Organization;

Property AdmitSource As FHIRTemplate.DataType.CodeableConcept;

Property DischargeDisposition As FHIRTemplate.DataType.CodeableConcept;

Property Rank As %Integer [ InitialExpression = 1 ];

/// 固定値にしたもの
/// meta.profile/status/class以下/diagnosis.use.coding/diagnosis.rank
XData Template [ MimeType = application/json ]
{
{
    "resourceType": "#(..#ResourceType)#",
    "meta": {
        "profile": ["http://jpfhir.jp/fhir/eClinicalSummary/StructureDefinition/JP_Encounter_eClinicalSummary"]   
    },
    "identifier":["#(..Identifier)#"],        
    "status": "finished",
    "class": "#(..Class)#",
    "classHistory":[
        {
            "class":"#(..ClassHistoryClass)#",
            "period":"#(..ClassHistoryPeriod)#"
        }
    ],
    "period":"#(..Period)#",
    "length":"#(..Length)#",
    "reasonCode": ["#(..ReasonCode)#"],
    "diagnosis":[
        "#(..Diagnosis)#"
    ],
    "hospitalization":{
        "origin":"#(..HospitalizationOrigin(Reference))#",
        "admitSource": {
        	"coding": [
                "#(..AdmitSource)#"
        	]
        },
        "dischargeDisposition": {
        	"coding": [
                "#(..DischargeDisposition)#"
        	]
        }
    }
}
}

}
