%dw 2.0
output application/json


---
{
	query: "query Area(\$filter: Filter) {
  areas(filter: \$filter) {
    areaName
    area_name
    children {
      area_name
      totalClimbs
      children {
        area_name
        totalClimbs
        climbs {
          name
          grades {
            french
          }
        metadata {
          lat
          lng
        }
        }
        children {
          area_name
          totalClimbs
          climbs {
            name
            grades {
              french
            }
          }
          metadata {
            lat
            lng
          }
          children {
            area_name
            totalClimbs
            climbs {
              name
              grades {
                french
              }
              metadata {
                lng
                lat
              }
            }
          }
        }
      }
    }
    }
    }",
	variables: {
		filter: {
			area_name: {
				match: "France",
				exactMatch: true
			}
		}
	}
}