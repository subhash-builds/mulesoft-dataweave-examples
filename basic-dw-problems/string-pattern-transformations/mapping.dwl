%dw 2.0
output application/json
---
payload map ((item1, index1) -> {
    (item1): (index1 to sizeOf(item1)-1) map ((index1 to $) joinBy"") 
})