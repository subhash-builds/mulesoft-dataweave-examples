%dw 2.0
output application/json
import * from dw::core::Dates
import * from dw::core::Strings
fun getAge(dob) = (now().year) - (dob as Date {format: "yyyy/MM/dd"}).year
---
payload map ({
    "name": trim($.name) splitBy  /\s+/ map capitalize($) joinBy  " ",
    "age": getAge($.dob),
    "daysSinceLastLogin": daysBetween(($.lastLogin as LocalDateTime {format: "yyyy-MM-dd HH:mm:ss"}), now() as Date)
})