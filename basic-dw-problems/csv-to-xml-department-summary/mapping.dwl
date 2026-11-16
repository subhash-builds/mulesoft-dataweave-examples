%dw 2.0
output application/xml
---
departments: {
    (payload groupBy ($.dept) mapObject ((value, key, index) -> {
    department @(name: (key)): {
        (value map ({
        employee @(salary: $.salary): $.emp
    } ))
    }
}))
}