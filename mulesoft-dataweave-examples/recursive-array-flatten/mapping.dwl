%dw 2.0
output application/json

fun flattenArray(arr) =
    arr flatMap (item) ->
        if (item is Array)
            flattenArray(item)
        else
            [item]
---
flattenArray(payload)