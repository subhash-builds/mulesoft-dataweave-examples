%dw 2.0
output application/json
import * from dw::Runtime
fun toDateTime(datetime) = do{
    var listfar= ["u/MM/dd HH:mm:ss", "dd-MM-u hh:mm a", "MMM-dd-u HH:mm:ss", "dd-MM-u hh:mm a"]
    ---
    ((listfar map (try(()-> datetime as LocalDateTime {"format": $}))) 
    filter ($.success))[0].result
} 
---
payload groupBy ($.region) mapObject ({
    ($$): ($ groupBy (($.merchantCode splitBy  "-")[1])) mapObject ((value, key, index) -> {
        (key): {
            "totalSales": sum(value.amount map $ as Number),
            "transactionCount": sizeOf(value),
            "latestTransactionDate": max(value.transactionDate map (toDateTime($)  default "No Matching Format"))
        }
    })
})

 