%dw 2.0
output application/json

var minRows = 1
var maxRows = 10000
var records= payload
---
if (sizeOf(records) < minRows or sizeOf(records) > maxRows)
{
    errorCode: "ROW_COUNT_INVALID",
    message: "Maximum 10000 records allowed."
}
else
records
    map ((row, index) -> do {

        var errors =
            []
            ++
            (
                if (
                    isEmpty(row.order_id)
                    or !(row.order_id matches /^ORD[0-9]{4}$/)
                )
                ["Invalid order_id format."]
                else []
            )

            ++
            (
                if (
                    isEmpty(row.customer_id)
                    or !(row.customer_id matches /^CUST[0-9]{4}$/)
                )
                ["customer_id missing"]
                else []
            )

            ++
            (
                if (
                    isEmpty(row.product)
                    or sizeOf((row.product default "") as String) > 100
                )
                ["Product cannot be empty."]
                else []
            )

            ++
            (
                if (
                    isEmpty(row.quantity)
                    or !((row.quantity as String) matches /^[0-9]+$/)
                    or ((row.quantity default 0) as Number) <= 0
                )
                ["Quantity must be a positive integer."]
                else []
            )

            ++
            (
                if (
                    isEmpty(row.amount)
                    or !((row.amount as String) matches /^[0-9]+(\.[0-9]{1,2})?$/)
                    or ((row.amount default 0) as Number) <= 0
                )
                ["amount invalid"]
                else []
            )

        ---
        if (!isEmpty(errors))
            {
                record: index + 1,
                order_id: row.order_id default "",
                error: errors joinBy ", "
            }
        else
            null
    })
    filter ($ != null)