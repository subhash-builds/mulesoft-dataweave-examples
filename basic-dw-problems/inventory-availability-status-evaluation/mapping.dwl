%dw 2.0
output application/json
var retrievedProdcuts= [
  {
    "productId": "SKU-101",
    "totalQuantity": 50
  },
  {
    "productId": "SKU-202",
    "totalQuantity": 0
  }
]

fun filterItems(currentProductId)= (retrievedProdcuts filter ($.productId== currentProductId))[0]

var enhanceStatus= payload.items map ((item, index) ->{
      sku: item.sku,
      requestedQuantity: item.qty,
      availableQuantity: filterItems(item.sku).totalQuantity,
      status: if((filterItems(item.sku).totalQuantity) >= item.qty) "AVAILABLE" else "OUT_OF_STOCK"
  } )
var statusList=enhanceStatus.status
fun filterStatus(status) = statusList filter $ == status
---
{
  orderId: payload.orderId,
  overallStatus: if((statusList contains "AVAILABLE") and (sizeOf(statusList) == sizeOf(filterStatus("AVAILABLE")))) "AVAILABLE" else if ((statusList contains "OUT_OF_STOCK") and (sizeOf(statusList) == sizeOf(filterStatus("OUT_OF_STOCK")))) "OUT_OF_STOCK" else "PARTIALLY_AVAILABLE",
  items: enhanceStatus,
  correlationId: correlationId
} 
