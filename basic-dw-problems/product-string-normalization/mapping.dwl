%dw 2.0
output application/json
fun splitProdDetails(details: String) = trim(details) splitBy  "|" map trim($) 
---
payload mapObject ({
    "Count": sizeOf($),
    "Items": $ map ({
        "Code": splitProdDetails($)[0],
        "Name": splitProdDetails($)[1],
        "Country": lower(splitProdDetails($)[2])
    })
})