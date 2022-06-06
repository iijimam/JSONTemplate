Class FHIRCustom.Coding.ByomeiCode Extends FHIRTemplate.DataType.CodingBase
{

Parameter CodeSystem = "urn:oid:1.2.392.200119.4.101.6";

/// コードからインスタンスを取得
ClassMethod GetByCode(code As %String) As FHIRCustom.Coding.ByomeiCode
{
        set display=""
        &SQL(SELECT Name INTO :display FROM FHIRMaster.ByomeiCode WHERE code = :code)
        if SQLCODE=0 {
                set obj=..%New()
                set obj.display=display
                quit obj
        }
        quit ""
}

}
