/datum/map_config/deltastation
	map_name = "Delta Station"
	map_path = "map_files/Deltastation"
	map_file = "DeltaStation2_skyrat.dmm"

	shuttles = list(
		"cargo" = "cargo_delta",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_delta",
		"emergency" = "emergency_delta")

	job_changes = list("cook" = list("additional_cqc_areas" = list("/area/service/bar/atrium")))
