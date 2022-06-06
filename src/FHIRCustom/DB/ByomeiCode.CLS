/// 傷病名マスターサンプル
Class FHIRMaster.DB.ByomeiCode Extends %Persistent
{

/// コード
Property Code As %String;

/// 名称
Property Name As %String;

Index IDKeyIdx On Code [ IdKey, Unique ];

/// データのインポート
ClassMethod ImportData(filename As %String) As %Status
{
    set ret=$$$OK
    try {
        do ..%KillExtent()
        set file=##class(%Stream.FileCharacter).%New()
        set ret=file.LinkToFile( filename )
        quit:$$$ISERR(ret)

        while 'file.AtEnd {
            set line=file.ReadLine()
            if $length(line,""",""")>=13 {
                set obj=..%New()
                set obj.Code=$piece(line,""",""",13)
                set obj.Name=$piece(line,""",""",6)
                set ret=obj.%Save()
                //quit:$$$ISERR(ret)
            }
        }
    } catch err {
        set ret=err.AsStatus()
    }
    quit ret
}

Storage Default
{
<Data name="ByomeiCodeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^FHIRMaster.DB.ByomeiCodeD</DataLocation>
<DefaultData>ByomeiCodeDefaultData</DefaultData>
<IdLocation>^FHIRMaster.DB.ByomeiCodeD</IdLocation>
<IndexLocation>^FHIRMaster.DB.ByomeiCodeI</IndexLocation>
<StreamLocation>^FHIRMaster.DB.ByomeiCodeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
