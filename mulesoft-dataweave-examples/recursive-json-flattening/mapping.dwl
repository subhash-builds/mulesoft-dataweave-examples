%dw 2.0
output application/json
fun recursionOrder(orderObj, prefix="") = 
orderObj pluck ((value, key, index) -> if(value is Object)
flatten(recursionOrder(value, (prefix ++ key ++ ".")) ) else (prefix ++ key): value)
---
recursionOrder(payload) map {
    (flatten($))
}