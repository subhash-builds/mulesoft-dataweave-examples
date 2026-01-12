%dw 2.0
output application/xml
fun filObj(order)= payload filter($.OrderID == order.OrderID)
fun multiple(each)= (each.Quantity  default 0) * (each.Price  default 0)
---
Orders: {
    ((payload distinctBy $.OrderID) map((order, index) -> {
    Order @(OrderID: order.OrderID): {
        "CustomerName": order.CustomerName,
        "OrderDate": ((order.OrderDate as Date {"format": "u/MM/dd"}) as String {"format": "MMMM dd, u"}),
        "OrderLines": {
            (filObj(order) map ( {
                "OrderLine": {
                    "ItemCode": $.ItemCode,
                    "ItemName": $.ItemName,
                    "Quantity": $.Quantity  default 0,
                    "Price": $.Price  default 0,
                    "TotalPrice": (multiple($))
                }
            }))
        },
        "GrandTotal": sum((filObj(order) map ( {
            "total": (multiple($))
        })).total)
   }
}))
}