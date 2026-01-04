%dw 2.0
output application/json
var items = payload.Order.Items.*Item map ({
    sku: $.@sku,
    qty: $.@qty,
    price: $.@price,
    total: $.@qty * $.@price
} )
var head= payload.Order.Header
---
{
    orderId: head.@orderId,
    date: head.@date,
    Customer: head.Customer,
    Items: items,
    grandTotal: sum(items.total)
}