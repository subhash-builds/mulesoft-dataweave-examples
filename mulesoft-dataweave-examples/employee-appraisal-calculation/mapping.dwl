%dw 2.0
output application/json
---
payload.employees map ({
    "id": $.id,
    "firstName": ($.name splitBy  " ")[0],
    "lastName": (($.name splitBy  " ")[1 to -1]) joinBy  " ",
    "skills": ($.skills splitBy  ",") map trim($),
    "NextAppraisalDate": ($.currentAppraisalDate as Date) + |P1Y1D|,
    "experienceYears": ((now() as Date).year - ($.joiningDate as Date).year),
    "salary": $.salary

})