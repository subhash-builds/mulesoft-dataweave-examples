%dw 2.0
output application/json
fun getVal(obj)= obj pluck ((value, key, index) -> if(value is Object) getVal(value) else value)
fun flatArr(arr)= arr flatMap ((item, index) -> if(item is Array) flatArr(item) else [item] )
---
flatArr(getVal(payload))