%dw 2.0
output application/xml
fun isSeniorEmployee(age) = if (age > 30) true else false
var hrEmployees = payload.employees filter ($.dept == "HR")
var excludedFields = ["id", "age"]
---
Employees @(xmlns: "http://company.com/hr"):
    {
        (hrEmployees map ((item, index) -> Employee @(id: item.id, senior: isSeniorEmployee(item.age)) : item -- excludedFields))
    }