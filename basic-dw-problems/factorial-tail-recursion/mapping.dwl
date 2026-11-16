%dw 2.0
output application/json
fun facRec(num, facValue)= if(num==1) facValue else facRec(num-1, num * facValue)
---
payload map ({
    (("factorial of ") ++ ($)): facRec($, 1)
} )