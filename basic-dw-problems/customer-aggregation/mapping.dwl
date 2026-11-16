%dw 2.0
output application/json
---
payload groupBy ($.customerId ) mapObject ((value, key) -> {
    (key): {
         "overallAmount": sum(value.amount),
        "categories": 
            {
                (value map ((customers, index2) ->{
            (customers.category): (sum((value filter ($.category == customers.category )).amount) ) 
        } ) distinctBy ($))
            }
    }
})