%dw 2.0
output application/json
var customer= payload.customer
var removeFieldAdd= ["state", "pinCode"]
var address= payload.customer.address
---
{
  "orderId": payload.order.orderId,
  "orderStatus": "VALIDATED",
  "customer": {
    "customerId": customer.customerId,
    "name": customer.firstName ++ " " ++ customer.lastName ,
    "email": customer.email,
    "phone": customer.phone,
    "address": (address -- removeFieldAdd ++ {
        "state": address.state ++ " - " ++ address.pinCode
    }).. joinBy  ", "
  },
  "orderItems": payload.cartItems map {
      "sku": $.sku,
      "qty": $.quantity,
      "unitPrice": $.price
  },
  "payment": payload.payment - "currency"
}