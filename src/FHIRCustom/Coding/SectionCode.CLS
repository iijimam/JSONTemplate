/// 文書カテゴリ
Class FHIRTemplate.Examples.SectionCode Extends (%Persistent, FHIRTemplate.DataType.CodingBase)
{

Parameter CodeSystem = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section";

Index IDKeyIdx On code [ IdKey, Unique ];

/// コードからインスタンスを取得
ClassMethod GetByCode(code As %String) As DocType
{
    set obj=..%OpenId(code)
    quit obj
}

Storage Default
{
<Data name="SectionCodeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>display</Value>
</Value>
<Value name="3">
<Value>version</Value>
</Value>
<Value name="4">
<Value>userSelected</Value>
</Value>
</Data>
<DataLocation>^FHIRTemplate.EE049.SectionCodeD</DataLocation>
<DefaultData>SectionCodeDefaultData</DefaultData>
<IdLocation>^FHIRTemplate.EE049.SectionCodeD</IdLocation>
<IndexLocation>^FHIRTemplate.EE049.SectionCodeI</IndexLocation>
<StreamLocation>^FHIRTemplate.EE049.SectionCodeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

/// データ生成
ClassMethod GenerateData() As %Status
{
    set stream=##class(%Dictionary.CompiledXData).%OpenId(..%ClassName(1)_"||InsertCode").Data
    set data={}.%FromJSON(stream)

    do ..%KillExtent()
    set iter=data.data.%GetIterator()
    while iter.%GetNext(.k,.line) {
        set obj=..%New()
        set obj.code=$piece(line,";",1),obj.display=$piece(line,";",2)
        do obj.%Save()
    }
    quit $$$OK
}

XData InsertCode [ MimeType = application/json ]
{
{ "data":[
    "200;CDA参照;cda",
    "300;構造情報;structured",
    "322;入院詳細;detailsOnAdmission",
    "342;入院時診断;diagnosesOnAdmission",
    "510;アレルギー・不耐性反応;allergiesIntolerance",
    "352;入院時主訴;chiefProblemOnAdmission",
    "312;入院理由;reasonForAdmission",
    "362;入院時現病歴;presentIllnessOnAdmission",
    "372;入院時既往歴;pastIllnessOnAdmission",
    "432;入院時服薬;medicationsOnAdmission",
    "642;入院時社会歴;socialHistoryOnAdmission",
    "612;入院時身体所見;physicalStatusOnAdmission",
    "552;入院時家族歴;familiyHistoryOnAdmission",
    "333;入院中経過;hospitalCourse",
    "324;退院時詳細;detailsOnDischarge",
    "444;退院時投薬指示;medicationOnDischarge",
    "424;退院時方針指示;instructionOnDischarge",
    "614;退院時身体所見;physicalStatusOnDischarge",
    "713;入院中治療;hospitalProcedure",
    "623;入院中検査結果;hospitalStudy",
    "810;医療機器;medicalDevice",
    "530;予防接種歴;immunization",
    "410;事前指示;advanceDirective"
  ]  
}
}

}
