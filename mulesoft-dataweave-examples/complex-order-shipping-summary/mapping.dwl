%dw 2.0
output application/json
var orders=payload.orders.*order
fun items (each)=each.items.*item
---
orders map ((item1, index1) ->   {
    "id": orders.@id[index1],
    "status": orders.@status[index1],
    "priority": orders.@priority[index1],
    "customer": {
      "name": item1.customer.name,
      "type": {
        "code": item1.customer."type".@code,
        "label": item1.customer."type"
      }
    },
    "items": items(item1) map ((item2, index2) -> {
        "category": items(item1)[index2].@category,
        "products": items(item1) filter ( items(item1)[$$].@category == items(item1)[index2].@category )
    })
}
)