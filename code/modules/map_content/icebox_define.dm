/datum/map_config/icebox
	map_name = "Ice Box Station"
	map_path = "map_files/IceBoxStation"
	map_file = list("IcemoonUnderground_Below.dmm",
					"IcemoonUnderground_Above_skyrat.dmm",
					"IceBoxStation_skyrat.dmm")

	traits = list(list("Up" = 1,
						"Mining" = TRUE,
						"Station" = FALSE,
						"Linkage" = null,
						"Gravity" = TRUE,
						"Ice Ruins Underground" = TRUE,
						"Baseturf" = "/turf/open/lava/plasma/ice_moon"),
					list("Down" = -1,
						"Up" = 1,
						"Mining" = TRUE,
						"Linkage" = null,
						"Gravity" = TRUE,
						"Ice Ruins Underground" = TRUE,
						"Baseturf" = "/turf/open/openspace/icemoon/keep_below"),
					list("Down" = -1,
						"Mining" = TRUE,
						"Linkage" = null,
						"Gravity" = TRUE,
						"Ice Ruins" = TRUE,
						"Weather_Snowstorm" = TRUE,
						"Baseturf" = "/turf/open/openspace/icemoon/keep_below")
					)
	space_ruin_levels = 0
	space_empty_levels = 0

	minetype = "none"

	shuttles = list(
		"cargo" = "cargo_skyrat",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_box",
		"emergency" = "emergency_box")

	job_changes = list("cook" = list("additional_cqc_areas" = list("/area/service/kitchen/diner")),
						"captain" = list("special_charter" = "moon"))

	overmap_object_type = /datum/overmap_object/shuttle/planet/icebox
