%dw 2.0
output application/xml
var orders=payload.Orders.*Order
fun totalOrderCost(item)= sum((item.Items.*Item map ({
                "total": (($.Price  default 0) * ($.Qty  default 0))
            }))."total")
---
ProcessedOrders: {
    (orders map ((unit, index) ->{
    "Order":{
                "Client" @(orderId: orders.@id[index], status: orders.@status[index], totalAmount: totalOrderCost(unit)):{
                "FullName": unit.Customer.Name,
                "Location": unit.Customer.City
                },
        "OrderLines": {
                (unit.Items.*Item map {
                "Line" @(productCode: $.Product, quantity: $.Qty, lineAmount:($.Price * $.Qty) ):{}
            })
        }
    }
}))
}