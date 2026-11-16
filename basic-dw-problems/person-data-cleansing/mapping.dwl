%dw 2.0
output application/json
import * from dw::core::Strings
fun dySplit(person: Object, regex)= (person.name splitBy  regex)
---
payload map (({
    "firstName": capitalize(dySplit($, " ")[0]),
    "lastName": capitalize(dySplit($, " ")[1]),
    "year": ($.Year splitBy  "/")[1],
    (if(isEmpty($.pan)) {"adhar": $.adhar} else {"pan": $.pan})
}))