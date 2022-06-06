/// 文書カテゴリ
Class FHIRTemplate.Examples.DiagnosisRoleCode Extends (%Persistent, FHIRTemplate.DataType.CodingBase)
{

Parameter CodeSystem = "http://terminology.hl7.org/CodeSystem/diagnosis-role";

Index IDKeyIdx On code [ IdKey, Unique ];

/// コードからインスタンスを取得
ClassMethod GetByCode(code As %String) As DocType
{
    set obj=..%OpenId(code)
    quit obj
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
    "AD;入院時診断",
    "DD;退院時診断",
    "CC;主訴",
    "CM;併存症診断",
    "pre-op;術前診断",
    "post-op;術後診断",
    "billing;会計請求診断"
  ]  
}
}

Storage Default
{
<Data name="DiagnosisRoleCodeDefaultData">
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
<DataLocation>^FHIRTemplaE049.DiagnosisRo8DCFD</DataLocation>
<DefaultData>DiagnosisRoleCodeDefaultData</DefaultData>
<IdLocation>^FHIRTemplaE049.DiagnosisRo8DCFD</IdLocation>
<IndexLocation>^FHIRTemplaE049.DiagnosisRo8DCFI</IndexLocation>
<StreamLocation>^FHIRTemplaE049.DiagnosisRo8DCFS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
