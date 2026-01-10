%dw 2.0
output application/json
var romanValues= {
    "I": 1 as Number,
    "V": 5 as Number,
    "X": 10 as Number,
    "L": 50 as Number,
    "C": 100 as Number,
    "D": 500 as Number,
    "M": 1000 as Number
}
fun div(x)= (x splitBy "") map (romanValues[$])
var arr= div(payload.romanNumber)
---
{
    "wholeNumber":  (arr map (if(($$ < sizeOf(arr)-1) and ($ < arr[$$ + 1])) -$ else $) reduce ($+$$))
}