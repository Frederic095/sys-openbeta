%dw 2.0
output application/json

fun mapAreas(area, parentRegion="") =
    do {
        var currentRegion = 
            if (parentRegion == "") area.area_name
            else parentRegion ++ " > " ++ area.area_name

        ---
        (
            // 1. Mapper les climbs de la zone actuelle
            (area.climbs default []) map (climb) -> {
                location: {
                    region: currentRegion,
                    spotName: climb.name
                },
                grade: {
                    difficulty: climb.grades.french default null,
                    level: null // à enrichir si tu veux une logique
                },
                coordinates: {
                    latitude: climb.metadata.lat default 46,
                    longitude: climb.metadata.lng default 2
                }
            }
        )
        ++
        // 2. Parcourir récursivement les enfants
        ((area.children default []) flatMap (child) -> mapAreas(child, currentRegion))
    }

---
payload.data.areas flatMap (area) -> mapAreas(area)