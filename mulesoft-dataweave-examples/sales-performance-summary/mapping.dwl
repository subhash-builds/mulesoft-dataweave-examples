%dw 2.0
output application/json
---
payload groupBy ($.Location) pluck ({
    "Location": $.Location[0],
    "UnitsOrdered": sum($.order..units),
    "Report": $ map ({
        ($.Product): {
            "Avgstock": avg($.order.units),
            "Avgsales": avg($.order.sales)
        }
    })
} )