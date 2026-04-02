%dw 2.0
output application/json

var level = vars.level
var region = vars.region

---

payload filter (item) -> 
    (level == "" or item.grade.level == level)
    and
    (region == "" or item.location.region == region)