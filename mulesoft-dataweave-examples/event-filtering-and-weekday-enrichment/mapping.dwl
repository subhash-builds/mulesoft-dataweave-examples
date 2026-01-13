%dw 2.0
output application/json
fun weekDay(dayInNum)= dayInNum  match {
    
    case 1 -> "mon"
    case 2 -> "tue"
    case 3 -> "wed"
    case 4 -> "thu"
    case 5 -> "fri"
    case 6 -> "sat"
    case 7 -> "sun"
}
fun atDay(eventObj)= (eventObj.datetime as LocalDateTime).dayOfWeek
---
payload orderBy (-atDay($) ) filter ( $.organizer== "Ross")  map ($ ++ {
    "day": weekDay(atDay($))
} ) distinctBy ($.day)