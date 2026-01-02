%dw 2.0
output application/json
var recordList= payload.items.payload
fun getStatistics(created, success)= if((created and success)==true) "insert" else if ((created or success)==true) "update" else "fail"
---
((recordList map ({
    final: getStatistics($.created, $.success)
} )) groupBy ($.final) ) mapObject (
    {
    ($$): sizeOf($)
})