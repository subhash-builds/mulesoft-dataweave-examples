%dw 2.0
output application/json
import * from dw::core::Strings
fun titleByGender(gen)= if(gen=="M") "Mr." else "Ms."
---
(payload flatMap ($) distinctBy ($.name ) map ({
    name: titleByGender($.gender) ++ capitalize($.name) 
} ) ).name