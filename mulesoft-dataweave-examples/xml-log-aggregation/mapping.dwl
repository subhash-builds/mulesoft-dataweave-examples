%dw 2.0
output application/json
var logs=payload.Logs.*Log
fun eachFil(item)= logs filter $.@level==item.@level
---
logs distinctBy $.@level map ((item, index) ->{
    (item.@level):{
        "count": sizeOf(eachFil(item)),
        "messages": eachFil(item).Message
    }
} )