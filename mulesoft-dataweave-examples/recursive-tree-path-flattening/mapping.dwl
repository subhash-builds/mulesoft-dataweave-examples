%dw 2.0
output application/json

fun flattenTree(node, path = "root", depth = 0) =
    [{
        name: node.name,
        path: path,
        depth: depth
    }]
    ++
    (
        node.children
            flatMap (
                flattenTree(
                    $,
                    path ++ "/" ++ $.name,
                    depth + 1
                )
            )
    )

---
// [
// {"name": "root", "path": "root", "depth": 0},
// {"name": "A", "path": "root/A", "depth": 1},

// {"name": "A1", "path": "root/A/A1", "depth": 2},
// {"name": "A2", "path": "root/A/A2", "depth": 2},
// {"name": "A2a", "path": "root/A/A2/A2a", "depth": 3},
// {"name": "B", "path": "root/B", "depth": 1}
// ]
flattenTree(payload)