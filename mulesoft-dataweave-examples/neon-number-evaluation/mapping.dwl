%dw 2.0
output application/json
fun sqr(num)= num * num
fun divAndSum(num) = (num splitBy("")) reduce ($+$$)
fun checkNeon(num) = if((divAndSum(sqr(num)) as Number)== num) "NEON NUMBER" else "NON-NEON NUMBER"
---
payload map ( {
    ($): checkNeon($)
})