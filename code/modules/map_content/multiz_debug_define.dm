/datum/map_config/multizdebug
	map_name = "MultiZ Debug"
	map_path = "map_files/debug"
	map_file = "multiz.dmm"

	traits = list(list("Up" = 1,
					"Linkage" = "Cross"),
				list("Up" = 1,
					"Down" = -1,
					"Baseturf" = "/turf/open/openspace",
					"Linkage" = "Cross"),
				list("Down" = -1,
					"Baseturf" = "/turf/open/openspace",
					"Linkage" = "Cross")
		)
