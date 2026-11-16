%dw 2.0
output application/json
---
{
    "salesByRegion": (payload.orders groupBy $.region) pluck ( {
    "region": $$,
    "total": sum($.amount),
    "id": $.id
})
}