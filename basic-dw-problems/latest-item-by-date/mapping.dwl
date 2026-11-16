%dw 2.0
output application/json
fun toTimestamp(d) = (d as Date {format: "yyyy-MM-dd"}) 
---
payload groupBy $.OrderNumber__c mapObject ((value, key, index) ->{
    "OrderNumber_c": (key),
    "Items": (value orderBy toTimestamp($.RequestDate__c))[-1 to 0] 
        orderBy $.ItemNumber__c 
        distinctBy $.ItemNumber__c 
        map ($ -"OrderNumber__c")
})