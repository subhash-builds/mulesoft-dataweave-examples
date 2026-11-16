%dw 2.0
output application/json
var students=payload.university.*student
---
flatten(students.subjects map ((subject, ind) -> subject pluck ({
    "StudentID":students.@id[ind],
    "Name":students.name[ind],
    "Subject": $
    }
)))