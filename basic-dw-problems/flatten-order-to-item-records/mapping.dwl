%dw 2.0
output application/json
---
flatten(payload.orders map ((order, index1) -> order.items map ((item, index2) ->{
    "orderId": order.orderId,
    "customerId": order.customer.id,
    "customerName": order.customer.name,
    "product": item.product,
    "price": item.price
})))