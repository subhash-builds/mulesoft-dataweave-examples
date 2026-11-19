%dw 2.0
output application/json
import * from dw::core::Strings
fun toCamel(value: Any) = value  match {
    case is Object -> value mapObject((camelize($$ as String)): toCamel($))
    case is Array -> value map ((item) -> toCamel(item))
    else -> value
}
---
toCamel(payload)