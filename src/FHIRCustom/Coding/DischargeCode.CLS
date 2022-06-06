/// 文書カテゴリ
Class FHIRTemplate.Examples.DischargeCode Extends (%Persistent, FHIRTemplate.DataType.CodingBase)
{

Parameter CodeSystem = "http://jpfhir.jp/fhir/Common/CodeSystem/admit-Source";

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
    "0;院内の他病棟からの転棟",
    "1;家庭からの入院",
    "4;他の病院・診療所の病棟からの転院",
    "5;介護施設・福祉施設に入所中",
    "8;院内で出生",
    "9;その他"
  ]  
}
}

Storage Default
{
<Data name="DischargeCodeDefaultData">
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
<DataLocation>^FHIRTemplateE049.DischargeCodeD</DataLocation>
<DefaultData>DischargeCodeDefaultData</DefaultData>
<IdLocation>^FHIRTemplateE049.DischargeCodeD</IdLocation>
<IndexLocation>^FHIRTemplateE049.DischargeCodeI</IndexLocation>
<StreamLocation>^FHIRTemplateE049.DischargeCodeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
