%dw 2.0
output application/json


var mapCotation = readUrl("classpath://Cotations.csv", "application/csv")

fun cotationFunction(cotation) =
    (mapCotation filter ($.source1 as String == cotation))[0].target default "Non noté"

fun mapAreas(area, region=null) =
    do {
        var currentRegion = 
            if (region == null and area.area_name != "France") area.area_name
            else region

        ---
        (
            // 1. Mapper les climbs
            (area.climbs default []) map (climb) -> {
                location: {
                    region: currentRegion,
                    spotName: climb.name
                },
                grade: {
                    difficulty: climb.grades.french default null,
                    level: cotationFunction(climb.grades.french) 
                },
                coordinates: {
                    latitude: climb.metadata.lat default 46,
                    longitude: climb.metadata.lng default 2
                }
            }
        )
        ++
        // 2. Récursion
        ((area.children default []) flatMap (child) -> mapAreas(child, currentRegion))
    }
---
payload.data.areas flatMap (area) -> mapAreas(area)