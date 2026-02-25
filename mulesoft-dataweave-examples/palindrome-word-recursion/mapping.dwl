%dw 2.0
output application/json
import * from dw::core::Strings
fun revRec(string, rev= "")= if(isEmpty(string)) rev else revRec(string[0 to -2], rev ++ string[-1])
---
payload map ({
    (capitalize(lower($))): if(lower($) == revRec(lower($))) "PALINDROME WORD" else "NON-PALINDROME WORD"
})