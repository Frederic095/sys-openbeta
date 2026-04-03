%dw 2.0


fun filteredAreaFunction (climbingSpots,level,region)=

climbingSpots filter (item) -> 
    (level == "" or item.grade.level == level)
    and
    (region == "" or item.location.region == region)


