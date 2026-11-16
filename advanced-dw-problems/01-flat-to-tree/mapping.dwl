%dw 2.0
output application/json
var byParent= payload groupBy ($.parentId  default "root")
fun recChild(parentId: String)= byParent[parentId] map (($ - "parentId") ++ {"children": recChild($.id as String)  default []})

---
recChild("root")