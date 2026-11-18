%dw 2.0
output application/json
fun toPath(nodes, prefix: String = "", tDepth: Number = 0)= nodes flatMap (do {
    var pathVar = if(isEmpty(prefix)) $.name else (prefix ++ " > " ++ $.name)
    ---
    [{path: pathVar, depth: tDepth }] ++ toPath($.children default [], pathVar  , tDepth + 1)
})
---
//  Tree to path list
// Reverse of #1. Flatten the tree into [{path:"A", depth:0},{path:"A > B", depth:1},{path:"A > B > C", depth:2}, ...]. Use recursion, and mark the function @TailRec only if you can make it truly tail-recursive (it’s a good exercise to see why that’s hard here).
toPath(payload)