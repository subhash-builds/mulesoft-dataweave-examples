%dw 2.0
output application/json
fun toGroup(data, value: String) = data groupBy (($["date"] as Date)[value])
fun totalCal(amountList) = amountList reduce ((item, accumulator=0) ->(item  default 0) + accumulator)
var months = {
    "1": "January",
    "2": "February",
    "3": "March",
    "4": "April",
    "5": "May",
    "6": "June",
    "7": "July",
    "8": "August",
    "9": "September",
    "10": "October",
    "11": "November",
    "12": "December"
}
---
// Group orders by year, then by quarter, then by month, calculating totals at each level
(toGroup(payload.orders, "year") mapObject ((value1, key1, index1) ->{
    (key1): {
        "total": totalCal(value1.amount)
    } ++ (toGroup(value1, "quarter") mapObject ((value2, key2, index2) ->{
        ("Q" ++ key2): {
            "total":totalCal(value2.amount),
            "months": (toGroup(value1, "month") mapObject ({
            (months[$$ as String]): totalCal($.amount)
        })) 
        }
    } ))
})) orderBy ($$ as Number)
