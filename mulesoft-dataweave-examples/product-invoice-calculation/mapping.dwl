%dw 2.0
output application/json
var maxIndex = sizeOf(payload.items) - 1
---
(0 to maxIndex) reduce ((index, accumulator=[]) -> 
    accumulator + {
        "item": (payload.items[index]),
        "totalPrice": (payload.price[index] * payload.quantity[index])
    }
)