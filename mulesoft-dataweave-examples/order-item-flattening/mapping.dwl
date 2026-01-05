%dw 2.0
output application/json
---
payload.orders.items flatMap ((item1, index1) -> item1 map ({
    "orderId": payload.orders.orderId[index1],
    "customerName": payload.orders.customer.name[index1],
    "item": $.description,
    "totalPrice": $.qty * $.price,
    "orderDate": payload.orders.orderDate[index1]
}))