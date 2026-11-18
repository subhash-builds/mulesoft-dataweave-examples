%dw 2.0
output application/json
var byParent= payload groupBy ($.parentId  default "root")
fun recChild(parentId: String)= byParent[parentId] map (($ - "parentId") ++ {"children": recChild($.id as String)  default []})
---
//1. Flat list to nested tree
//Input: [{id:1,parentId:null,name:"A"},{id:2,parentId:1,name:"B"},{id:3,parentId:2,name:"C"},{id:4,parentId:1,name:"D"}]
//Build a tree where each node has a children array. Leaf nodes should have children: []. Don’t hardcode depth, so use a recursive function.
recChild("root")