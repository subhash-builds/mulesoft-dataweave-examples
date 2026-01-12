%dw 2.0
output application/json skipNullOn="everywhere"
---
payload.header.customers map ((customer, index1) ->{
    "customer": customer.custId,
    "orders": customer.orders map ((order, index2) ->  {
        "orderId": order.orderId,
        "hasDiscounts": order.discounts.seasonal,
        "items": order.lineItems.sku,
        "avgOrderValue": ((order.lineItems map ((prod, index2) ->{
                total: (prod.price  default 0) * (prod.qty  default 0)
            } )).total) reduce ($+$$),
        "coupons": sizeOf(order.discounts.coupons filter $!=null)
    })   
})