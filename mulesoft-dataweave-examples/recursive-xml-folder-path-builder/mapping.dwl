%dw 2.0
output application/json
fun getPath(root, path="")= root mapObject ((value, key, index) -> if((key as String) == "file") {
    "path": path ++ root.@name,
    "file": value
} else getPath(value, path ++ root.@name ++ "/")  )
---
payload.folders.*folder map (getPath($))