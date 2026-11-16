%dw 2.0
output application/csv
var orders=payload.Orders.*Order
---
flatten(orders.Items map ((item1, index1) -> item1.*Item map ({
        "OrderId": orders.@id[index1],
    "CustomerName": orders.Customer.Name[index1],
    "Location": orders.Customer.Country[index1],
    "Product": $.Product,
    "Qty": $.Qty,
    "Price": $.Price,
    "LineTotal": (($.Qty  default 0 ) * ($.Price  default 0)),
    "OrderDate": $.OrderDate
})))