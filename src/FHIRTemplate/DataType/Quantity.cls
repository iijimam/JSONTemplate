Class FHIRTemplate.DataType.Quantity Extends JSONTemplate.Base
{

Parameter SYSTEM = "http://unitsofmeasure.org";

Property value As %Integer;

Property comparator As %String;

Property unit As %String;

Property system As %String;

Property code As %String;

XData Template [ MimeType = application/json ]
{
{
        "value":"#(..value)#",
        "comparator":"#(..comparator)#",
        "unit": "#(..unit)#",
        "system":"#(..#SYSTEM)#",
        "code": "#(..code)#"
}
}

}
