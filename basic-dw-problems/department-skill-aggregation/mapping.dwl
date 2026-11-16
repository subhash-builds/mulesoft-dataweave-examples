%dw 2.0
output application/json
---
{
    skills: ((flatten(payload.departments..*skills)) distinctBy $) orderBy $ 
}