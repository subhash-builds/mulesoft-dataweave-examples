%dw 2.0
output application/json
---
payload reduce ((item, acc= []) -> acc ++ (item.order.place.name.asisiselm reduce ((subItem, subAcc=[]) ->subAcc ++ [if(item.order.place.name.firstName == "sachin") 
    {
        "asisslem": subItem.asile,
        "Lastname": item.order.place.name.lastname	
    }
    else
    {
        "Lastname": item.order.place.name.lastname,
        "asisslem": subItem.asile
    }
] )))