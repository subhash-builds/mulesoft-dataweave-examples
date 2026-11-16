%dw 2.0
output application/json
fun recAdd(arr, tot) =if(isEmpty(arr)) tot  else (recAdd(arr[1 to -1], arr[0] + tot))
---
recAdd(payload, 0)