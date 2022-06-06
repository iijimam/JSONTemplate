/// DischargeSummaryの文書作成医療機関情報の仕様で作成
Class FHIRTemplate.Organization Extends Resource
{

Parameter ResourceType = "Organization";

Property TextDiv As %String(MAXLEN = 10000);

/// Extentionのidentifier.valueIdentifier.value
Property PrefNum As %String;

/// 点数コード　1:医科,3:歯科
Property TensuCode As %String(VALUELIST = ",1,3");

/// 保険医療機関番号7桁
Property HokenNum7 As %String(MAXLEN = 7, MINLEN = 7);

/// 保険医療機関番号10桁
Property HokenNum10 As %String(MAXLEN = 10, MINLEN = 10);

/// 医療機関名称
Property HospitalName As %String(MAXLEN = 100);

/// 医療機関電話番号
Property Phone As %String;

/// 医療機関住所文字列
Property AddressText As %String(MAXLEN = 100);

/// 医療機関郵便番号
Property AddressZip As %String;

/// 固定値
/// meta.profile/extension/
XData Template [ MimeType = application/json ]
{
{
    "resourceType": "#(..#ResourceType)#",
    "meta": {
        "profile": ["http://jpfhir.jp/fhir/eClinicalSummary/StructureDefinition/JP_Organization_eClinicalSummary_issuer"]
    },
    "text":{
        "status":"generated",
        "div":"#(..TextDiv)#"
    },
    "extension":[
        {
            "url":"http://jpfhir.jp/fhir/core/Extension/StructureDefinition/JP_Organization_PrefectureNo",
            "valueIdentifier":{
                "system":"urn:oid:1.2.392.100495.20.3.21",
                "value":"#(..PrefNum)#"
            }
        },
        {
            "url":"http://jpfhir.jp/fhir/core/Extension/StructureDefinition/JP_Organization_InsuranceOrganizationCategory",
            "valueIdentifier":{
                "system":"urn:oid:1.2.392.100495.20.3.22",
                "value":"#(..TensuCode)#"
            }            
        },
        {
            "url":"http://jpfhir.jp/fhir/core/Extension/StructureDefinition/JP_Organization_InsuranceOrganizationNo",
            "valueIdentifier":{
                "system":"urn:oid:1.2.392.100495.20.3.23",
                "value":"#(..HokenNum7)#"
            }            
        }
    ],
    "identifier": [
        {
            "system": "http://jpfhir.jp/fhir/Common/CodeSystem/insurance-medical-nstitution-no",
            "value":"#(..HokenNum10)#"
        }
    ],
    "type": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/organization-type",
                    "code": "prov",
                    "display": "#(..HospitalName)#"
                }
            ]
        }
    ],
    "name": "#(..HospitalName)#",
    "telecom": [
        {
            "system": "phone",
            "value": "#(..Phone)#"
        }
    ],
    "address": [
        {
            "text":"#(..AddressText)#",
            "postalCode": "#(..AddressZip)#",
            "country": "JP"
        }
    ]
}
}

}
