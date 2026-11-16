%dw 2.0
output application/json
var branches= payload.Company.*Branch
---
branches map ((item, index) ->{
    "branch": branches.@code[index],
    "teamCount": sizeOf(item..*Team),
    "membersCount": sizeOf(item..*Member)
} )