%dw 2.0
output application/json

var level = vars.level
var region = vars.location

---

payload filter (item) -> 
    (levellevelParam == null or item.grade.level == level)
    and
    (region == null or item.location.region == region)