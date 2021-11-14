/datum/map_config/tramstation
	map_name = "Tramstation"
	map_path = "map_files/tramstation"
	map_file = "tramstation_skyrat.dmm"

	traits = list(list("Up" = 1,
						"Baseturf" = "/turf/open/floor/plating/asteroid/airless",
						"Linkage" = "Cross"),
					list("Down" = -1,
						"Baseturf" = "/turf/open/openspace",
						"Linkage" = "Cross"))

	shuttles = list(
		"cargo" = "cargo_skyrat",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_tram",
		"emergency" = "emergency_tram")

	job_changes = list("cook" = list("additional_cqc_areas" = list("/area/service/kitchen/diner")),
						"captain" = list("special_charter" = "asteroid"))
