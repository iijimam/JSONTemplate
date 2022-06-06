Class FHIRTemplate.DataType.TimeStamp Extends %DataType [ ClassType = datatype, ClientDataType = TIMESTAMP, OdbcType = TIMESTAMP, SqlCategory = TIMESTAMP ]
{

/// 出力フォーマット
/// 1 ... YYYY-MM-DDTHH:MM:SS+timezone
/// 2 ... YYYY-MM-DDTHH:MM:SSZ
/// 3 ... YYYY-MM-DD
Parameter FORMAT = 1;

ClassMethod LogicalToDisplay(%val) As %String [ CodeMode = generator, ServerOnly = 1 ]
{
	If ($$$getClassType(%class)=$$$cCLASSCLASSTYPEDATATYPE) || $$$comMemberKeyGet(%class,$$$cCLASSparameter,"XMLENABLED",$$$cPARAMdefault) || $$$comMemberKeyGet(%class,$$$cCLASSparameter,"%JSONENABLED",$$$cPARAMdefault) {
         if ..#FORMAT=2 {
            $$$GENERATE(" quit $translate($zdatetime(%val,3,,3),"" "",""T"")_""Z""")
        } elseif ..#FORMAT=3 {
            $$$GENERATE(" quit $zdate(%val,3)")
        } else {
            set timezone=$ztimezone*(-1),hour=timezone\60,min=timezone#60
            set timezone="+"_(hour\10)_(hour#10)_":"_(min\10)_(min#10)
            $$$GENERATE(" quit $select(%val'["","":$zdate(%val,3),1:$translate($zdatetime(%val,3,,3),"" "",""T"")_"""_timezone_""")")
        }
    }
}

}
