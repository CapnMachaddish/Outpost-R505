/datum/map_config/kilostation
	map_name = "Kilo Station"
	map_path = "map_files/KiloStation"
	map_file = "KiloStation_skyrat.dmm"

	space_ruin_levels = 4

	shuttles = list(
		"cargo" = "cargo_kilo",
		"ferry" = "ferry_kilo",
		"whiteship" = "whiteship_kilo",
		"emergency" = "emergency_kilo")

	job_changes = list("cook" = list("additional_cqc_areas" = list("/area/service/bar/atrium")),
						"captain" = list("special_charter" = "asteroid"))
