%dw 2.0
output application/json
fun ordersByCustomer(customer)=payload.orders filter ($.customerId == customer.id)
---
payload.customers map ($ ++ {
  "totalOrders": sizeOf(ordersByCustomer($)),
  "totalAmount": (ordersByCustomer($).amount reduce($+$$)  default 0)
})