%dw 2.0
output application/xml
---
"book": {
    "title": payload.book.title,
    "authors": {
        author: payload.book.*author distinctBy ($)
    }
}