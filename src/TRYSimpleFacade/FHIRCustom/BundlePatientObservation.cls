Class FHIRCustom.BundlePatientObservation Extends FHIRTemplate.Bundle
{

/// JSON出力する際のテンプレート
XData Template [ MimeType = application/json ]
{
{
  "resourceType": "#(..#ResourceType)#",
  "type": "searchset",
  "total":"#(..Total)#",
  "entry": [
  "#(..Resource(FHIRTemplate.Bundle.entry))#"
  ]
}
}

Property Total As %Integer;

}
