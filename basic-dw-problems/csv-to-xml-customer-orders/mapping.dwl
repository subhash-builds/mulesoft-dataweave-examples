%dw 2.0
output application/xml 
var orders = "OrderID,CustomerID,Amount
101,1,250
102,2,180
103,1,320
104,3,150
105,4,null"
fun filterOrder(customer)= read(orders, "application/csv") filter $.CustomerID==customer.CustomerID
var removedAttributes=["CustomerID", "Amount"]
---
Customers: {
    (payload map ((item, index) -> "Customer" @(CustomerID: item.CustomerID, CustomerName: item.CustomerName, totalAmount: sum(filterOrder(item).Amount)  default 0):"Orders":{
     ((filterOrder(item)) map {
        Order @(lineItem: $$ + 1): $ -- removedAttributes ++{
            Amount: ($.Amount default 0)
        }
    })
}))
}