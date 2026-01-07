%dw 2.0
output application/json 
fun filterStatus(state: String)= payload map ($ - "items" ++{
        "items": ($.items filter ($.status == state)).name
    }) filter (!isEmpty($.items))
---
{
    "availableItem": filterStatus("available"),
    "unAvailableItem": filterStatus("out_of_stock")
}
