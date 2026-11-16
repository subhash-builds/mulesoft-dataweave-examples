%dw 2.0
output application/json
fun arrayOfNum(num)= num splitBy("")
fun sizeOfNum(num)= sizeOf(num)
---
payload map ((item1, index1) -> {
    (item1): if((arrayOfNum(item1) reduce ((item, accumulator=0) -> (item pow sizeOfNum(item1)) + accumulator ))== item1)  "YES" else "NO"
})
