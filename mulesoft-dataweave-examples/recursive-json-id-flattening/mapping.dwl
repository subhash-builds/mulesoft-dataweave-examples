%dw 2.0
output application/json
fun flattenId(node) = [node.id] ++
    if(node.children?) node.children flatMap (flattenId($)) else []
---
flattenId(payload)