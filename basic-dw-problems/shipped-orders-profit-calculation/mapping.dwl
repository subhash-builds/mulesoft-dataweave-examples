%dw 2.0
output application/json
---
(payload.orders filter $.shipped==true) map ((item, index) ->{
    "OrderId": (item.id as Number) as String,
    "items": item.items.name,
    "purchaseValue": sum(item.items.price),
    "profitGenerated": sum(item.items.price) - sum(item.expenses..)
})
