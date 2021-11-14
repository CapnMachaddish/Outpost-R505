/datum/map_config/waterkilostation
	map_name = "WaterKiloStation"
	map_path = "map_files/WaterKiloStation"
	map_file = list(
		"WaterKiloStation.dmm",
		"WaterKiloBelow.dmm"
	)
	space_ruin_levels = 0
	space_empty_levels = 0
	traits = list(
		list(
			"Linkage" = null,
			"Down" = 1,
			"Gravity" = TRUE,
			"Nearstation Ocean Ruins" = TRUE,
			"Ocean Ruins" = TRUE,
			"Ocean Station" = TRUE,
			"Baseturf" = "/turf/open/floor/plating/asteroid"
		),
		list(
			"Up" = -1,
			"Linkage" = null,
			"Gravity" = TRUE,
			"Trench Ruins" = TRUE,
			"Baseturf" = "/turf/open/floor/plating/asteroid"
		)
	)
	shuttles = list(
	    "emergency" = "emergency_kilo",
	    "ferry" = "ferry_kilo",
	    "cargo" = "cargo_kilo",
	    "whiteship" = "whiteship_kilo"
	)

	overmap_object_type = /datum/overmap_object/shuttle/planet/kilo_ocean
