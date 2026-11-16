%dw 2.0
output application/xml
// Convert prices from USD to INR (1 USD = 84 INR)
// Add discountedPrice (10% off)
---
Products: {
    (payload.Products.*Product map ((item, index) ->Product: item - "Price" ++ {
        "Price" @(currency: "INR"): if(item.Price.@currency=="USD")(( item.Price * 84) *(1-0.1)) else item.Price * (1-0.1)
    } ))
}
