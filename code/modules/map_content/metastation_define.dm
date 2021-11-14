/datum/map_config/metastation
	map_name = "Meta Station"
	map_path = "map_files/MetaStation"
	map_file = "MetaStation_skyrat.dmm"

	shuttles = list(
		"cargo" = "cargo_skyrat",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_meta",
		"emergency" = "emergency_meta")

	job_changes = list("cook" = list("additional_cqc_areas" = list("/area/service/bar", "/area/service/kitchen/coldroom")))
