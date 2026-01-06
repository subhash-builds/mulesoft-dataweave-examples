%dw 2.0
output application/json
import * from dw::core::Objects
---
payload mapObject ((($$): $) if( $ !=null)) ++ {
    "filedsToNull": keySet(payload mapObject ((($$): $) if($ == null or $ =="")))
}