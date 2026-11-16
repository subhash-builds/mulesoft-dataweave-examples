%dw 2.0
output application/json
fun maxDateTime(datetimeArray)= max(datetimeArray map (changeToDateFormat($)))
fun changeToDateFormat(date)= 
if ((date as LocalDateTime {format:"dd-MM-yyyy hh:mm a"} default null) !=null ) date as LocalDateTime {format:"dd-MM-yyyy hh:mm a"} 
else if((date as LocalDateTime {"format": "u/MM/dd HH:mm:ss"} default null)!=null) date as LocalDateTime {"format": "u/MM/dd H:mm:ss"} 
else ( date as LocalDateTime {"format": "MMM-dd-u HH:mm:ss"})
---
payload groupBy $.region mapObject {
    ($$): $ groupBy $.merchantCode mapObject {
        ((($$) splitBy  "-")[1]): {
            "totalSales": sum($.amount map ($ as Number)  default 0),
            "transactionCount": sizeOf($),
            "latestTransactionDate": maxDateTime($.transactionDate)
        }
    }
}