%dw 2.0
output application/json
fun itemFil(index)=payload.items[index]
fun itemTotal(index1)= sum((itemFil(index1).price map ({
        "total": $ * itemFil(index1).qty[$$]
    })).total)
---
payload.customer map ((item1, index1) -> item1 - "name" ++{
    "customerName": item1.name,
    "mostExpensiveItem": (itemFil(index1) filter ($.price == max(itemFil(index1).price))).product[0],
    "orderStatus": payload.status[index1],
    "totalAfterDiscount": itemTotal(index1) * (1-payload.discount[index1]),
    "totalBeforeDiscount": itemTotal(index1),
    "totalItems": sum(itemFil(index1).qty)
} )