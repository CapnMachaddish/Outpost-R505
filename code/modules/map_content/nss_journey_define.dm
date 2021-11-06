/datum/map_config/nss_journey
	map_name = "NSS Journey"
	map_path = "map_files/NSSJourney"
	map_file = "NSSJourney.dmm"
	job_changes = list(
		"prisoner" = list("total_positions" = 4, "spawn_positions" = 4),
		"cook" = list("additional_cqc_areas" = list("/area/service/kitchen/diner"))
	)

	shuttles = list(
		"emergency" = "emergency_box",
		"ferry" = "ferry_fancy",
		"cargo" = "cargo_skyrat",
		"whiteship" = "whiteship_box"
	)
