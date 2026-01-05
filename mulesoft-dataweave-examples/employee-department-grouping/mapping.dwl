%dw 2.0
output application/json
---
(payload.employees.*emp groupBy ($.name[0])) mapObject ((value, key, index) -> {
    (key): (value groupBy ($.dept)) mapObject ({
        ($$): $.name
    } )
})