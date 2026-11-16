%dw 2.0
output application/json
---
payload groupBy $.region mapObject ( {
    ($$): ($ groupBy ($.country)) mapObject ({
        ($$): $ map ({
            "Product": $.product,
            "Amount": (($.price  default 0) * ($.quantity default 0))
        })
    })
})