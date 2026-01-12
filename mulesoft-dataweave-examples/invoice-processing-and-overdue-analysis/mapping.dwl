%dw 2.0
output application/csv
var invoices= payload.Invoices.*Invoice
var modifyFields= ["InvoiceDate", "DueDate", "PaymentStatus", "LineItems"]
fun changeDateFormat(date)= (date as Date {"format": "u-MM-dd"} as Date {"format": "dd/MM/u"})
fun validateStatus(status)= if(status== "Paid") "N"  else "Y"
---
invoices map ((invoice, index) -> invoice -- modifyFields ++{
    "InvoiceDate": changeDateFormat(invoice.InvoiceDate),
    "DueDate": changeDateFormat(invoice.DueDate),
    "DueDays": ((invoice.DueDate).day - (invoice.InvoiceDate).day),
    "IsOverdue": validateStatus(invoice.PaymentStatus),
    "InvoiceNetTotal": sum((invoice.LineItems.*Line map {
        total: ($.UnitPrice  default 0) * ($.Quantity  default 0)
    }).total)
})