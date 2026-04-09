%dw 2.0
output application/json

var level = vars.level
var region = vars.region
var cotations = readUrl("classpath://Cotations.csv", "application/csv")


fun getLevel(grade) =
    (cotations filter(item) ->(item.source1 == grade))[0].target default "Non noté"

fun mapClimbingSpots(climb, areaName) = {
    "location": {
        "region":   areaName,
        "spotName": climb.name
    },
    "grade": {
        "difficulty": climb.grades.french default "Pas de cotation",
        "level": getLevel(climb.grades.french)
    },
    "coordinates": {
        "latitude":  climb.metadata.lat  default 46, // latitude de la France
        "longitude": climb.metadata.lng  default 2 // longitude de la France
    }
}


var climbingSpots =
    payload.data.areas[0].children
    flatMap (area) ->
        flatten(area..climbs) map (climb) -> mapClimbingSpots(climb, area.area_name)

---

climbingSpots
filter (item) ->
    (level == "" or item.grade.level == level)
    and
    (region == "" or item.location.region == region)