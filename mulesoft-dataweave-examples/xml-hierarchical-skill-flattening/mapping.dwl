%dw 2.0
output application/json
---
payload.company.*department reduce ((item1, accumulator1=[]) -> accumulator1 + flatten((item1.employees.*employee reduce ((item2, accumulator2 = []) -> accumulator2 + (item2.skills.*skill  reduce ((item3, accumulator3 = []) -> accumulator3 + ({
    "department": item1.@id,
    "Employee": item2.@id,
    "Skill": item3
}) ))))))