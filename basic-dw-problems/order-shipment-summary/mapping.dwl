%dw 2.0
output application/json
var shipmentDetails= [
  {
   "shipmentID": 1,
   "orderID": "So01",
   "shipmentQuantity": "50 units" },
  {
   "shipmentID": 2,
   "orderID": "So01",
   "shipmentQuantity": "110 units" },
  {
   "shipmentID": 3,
   "orderID": "So02",
   "shipmentQuantity": "100 units" },
  {
   "shipmentID": 4,
   "orderID": "So02",
   "shipmentQuantity": "80 units" },
  {
   "shipmentID": 5,
   "orderID": "So03",
   "shipmentQuantity": "150 units" }
]
fun filterShipment(orderObj)= (shipmentDetails filter ($.orderID==orderObj.orderID ))
fun units(orderObj)= sum(filterShipment(orderObj).shipmentQuantity map (( $ replace  /[^0-9]/ with "") as Number))
---
payload map ($ ++ {
     "shipment":
        "shipmentID": filterShipment($).shipmentID,
        "shipmentQuantity": filterShipment($).shipmentQuantity,
        "pendingQuantity": ($.orderedQuantity replace  /[^0-9]/ with "") - units($)
} )