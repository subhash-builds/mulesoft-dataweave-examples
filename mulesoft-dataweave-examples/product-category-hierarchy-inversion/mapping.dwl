%dw 2.0
output application/json
var products= payload.categories flatMap ((item, index) -> item.products map ($ ++ {
    "categories": item.name
}))
var groupProducts= products groupBy ($.id)
---
products: (products distinctBy $.id) map ((item, index) -> item  update {
    case ."categories" -> groupProducts[item.id as String].categories
})